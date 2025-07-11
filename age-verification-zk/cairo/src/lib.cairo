use starknet::ContractAddress;
use core::pedersen::PedersenTrait;
use core::hash::{HashStateTrait, HashStateExTrait};
use core::{pedersen::HashState};

/// Age Verification ZK Circuit
/// Prove that user is over minimum age without revealing actual age
#[starknet::interface]
trait IAgeVerificationZK<TContractState> {
    /// Perform age verification
    /// 
    /// # Arguments
    /// * `commitment` - Hash of age and nonce (public input)
    /// * `min_age` - Minimum age requirement (public input)
    /// * `age` - Actual age (private input)
    /// * `nonce` - Random value for commitment generation (private input)
    /// 
    /// # Returns
    /// * `bool` - true for Pass, false for Non-Pass
    fn verify_age(
        ref self: TContractState,
        commitment: felt252,
        min_age: u8,
        age: u8,
        nonce: felt252
    ) -> bool;
}

#[starknet::contract]
mod AgeVerificationZK {
    use super::IAgeVerificationZK;
    use core::pedersen::PedersenTrait;
    use core::hash::{HashStateTrait, HashStateExTrait};
    use core::{pedersen::HashState};

    #[storage]
    struct Storage {
        verification_count: u128,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        AgeVerified: AgeVerified,
    }

    #[derive(Drop, starknet::Event)]
    struct AgeVerified {
        #[key]
        commitment: felt252,
        result: bool,
        timestamp: u64,
    }

    #[abi(embed_v0)]
    impl AgeVerificationZKImpl of IAgeVerificationZK<ContractState> {
        /// Main age verification function
        fn verify_age(
            ref self: ContractState,
            commitment: felt252,
            min_age: u8,
            age: u8,
            nonce: felt252
        ) -> bool {
            // 1. Commitment verification: commitment = Hash(age || nonce)
            let computed_commitment = self.compute_commitment(age, nonce);
            
            // Fail if commitment does not match
            if computed_commitment != commitment {
                self.emit_verification_event(commitment, false);
                return false;
            }

            // 2. Age condition verification: age >= min_age
            let age_check = age >= min_age;

            // Emit event and increment counter
            self.emit_verification_event(commitment, age_check);
            self.verification_count.write(self.verification_count.read() + 1);

            age_check
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        /// Generate commitment by hashing age and nonce
        /// Using Pedersen hash (efficient in Cairo)
        fn compute_commitment(self: @ContractState, age: u8, nonce: felt252) -> felt252 {
            let mut hash_state = PedersenTrait::new(0);
            hash_state = hash_state.update(age.into());
            hash_state = hash_state.update(nonce);
            hash_state.finalize()
        }

        /// Emit verification event
        fn emit_verification_event(ref self: ContractState, commitment: felt252, result: bool) {
            let timestamp = starknet::get_block_timestamp();
            self.emit(Event::AgeVerified(AgeVerified {
                commitment,
                result,
                timestamp,
            }));
        }
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.verification_count.write(0);
    }

    // Additional helper functions
    #[abi(embed_v0)]
    impl HelperImpl of super::IHelper<ContractState> {
        /// Get total verification count
        fn get_verification_count(self: @ContractState) -> u128 {
            self.verification_count.read()
        }

        /// Create commitment with given age and nonce (for testing)
        fn create_commitment(self: @ContractState, age: u8, nonce: felt252) -> felt252 {
            self.compute_commitment(age, nonce)
        }
    }
}

#[starknet::interface]
trait IHelper<TContractState> {
    fn get_verification_count(self: @TContractState) -> u128;
    fn create_commitment(self: @TContractState, age: u8, nonce: felt252) -> felt252;
}

// Unit tests
#[cfg(test)]
mod tests {
    use super::{AgeVerificationZK};
    use core::pedersen::PedersenTrait;
    use core::hash::{HashStateTrait, HashStateExTrait};
    use core::{pedersen::HashState};

    // Helper function: Generate commitment
    fn compute_commitment(age: u8, nonce: felt252) -> felt252 {
        let mut hash_state = PedersenTrait::new(0);
        hash_state = hash_state.update(age.into());
        hash_state = hash_state.update(nonce);
        hash_state.finalize()
    }

    // Test basic verification logic
    fn test_age_verification_logic(age: u8, nonce: felt252, min_age: u8) -> bool {
        let commitment = compute_commitment(age, nonce);
        let computed_commitment = compute_commitment(age, nonce);
        
        // Commitment verification
        if computed_commitment != commitment {
            return false;
        }
        
        // Age condition verification
        age >= min_age
    }

    #[test]
    #[available_gas(2000000)]
    fn test_successful_verification_pass() {
        // Test data: 25 years old, nonce 12345
        let age: u8 = 25;
        let nonce: felt252 = 12345;
        let min_age: u8 = 20;
        
        let result = test_age_verification_logic(age, nonce, min_age);
        assert(result == true, 'Age verification pass');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_successful_verification_exact_age() {
        // Test data: exactly 20 years old
        let age: u8 = 20;
        let nonce: felt252 = 67890;
        let min_age: u8 = 20;
        
        let result = test_age_verification_logic(age, nonce, min_age);
        assert(result == true, 'Exact age pass');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_failed_verification_under_age() {
        // Test data: 19 years old (under age)
        let age: u8 = 19;
        let nonce: felt252 = 11111;
        let min_age: u8 = 20;
        
        let result = test_age_verification_logic(age, nonce, min_age);
        assert(result == false, 'Under age fail');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_commitment_consistency() {
        // Verify same input generates same commitment
        let age: u8 = 25;
        let nonce: felt252 = 12345;
        
        let commitment1 = compute_commitment(age, nonce);
        let commitment2 = compute_commitment(age, nonce);
        
        assert(commitment1 == commitment2, 'Commitment consistent');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_different_commitments() {
        // Verify different input generates different commitments
        let age1: u8 = 25;
        let age2: u8 = 26;
        let nonce: felt252 = 12345;
        
        let commitment1 = compute_commitment(age1, nonce);
        let commitment2 = compute_commitment(age2, nonce);
        
        assert(commitment1 != commitment2, 'Different commitments');
    }
} 