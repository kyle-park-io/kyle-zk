// Age verification ZK circuit (Noir version)
// Prove that a user is over the minimum age without revealing the actual age

use dep::std;

/// Age verification ZK circuit main function
/// 
/// Public inputs:
/// - commitment: Hash of age and nonce
/// - min_age: Minimum age requirement (20 years)
/// 
/// Private inputs:
/// - age: Actual age
/// - nonce: Random value for commitment generation
/// 
/// Returns: Verification result (true for Pass, false for Non-Pass)
fn main(
    // Public inputs
    commitment: pub Field,
    min_age: pub u8,
    // Private inputs (witness)
    age: u8,
    nonce: Field
) -> pub bool {
    // 1. Commitment verification: commitment == Hash(age || nonce)
    let computed_commitment = compute_commitment(age, nonce);
    assert(commitment == computed_commitment, "Invalid commitment");
    
    // 2. Age condition verification: age >= min_age
    let age_check = age >= min_age;
    
    // Return result
    age_check
}

/// Generate commitment by hashing age and nonce
/// Using simple field arithmetic (for demo purposes)
fn compute_commitment(age: u8, nonce: Field) -> Field {
    // Convert age to Field
    let age_field = age as Field;
    
    // Simple hash using field arithmetic
    // This is a simplified version for demonstration
    let result = age_field * 1000000 + nonce;
    result
}

/// Range validation function (additional security)
/// Check if age is within reasonable range
fn validate_age_range(age: u8) -> bool {
    // Reasonable range: 0 to 150 years
    (age >= 0) & (age <= 150)
}

/// Commitment integrity verification
/// Check if correct commitment is generated from age and nonce
fn verify_commitment_integrity(age: u8, nonce: Field, expected_commitment: Field) -> bool {
    let computed = compute_commitment(age, nonce);
    computed == expected_commitment
}

// Test cases
#[test]
fn test_successful_verification_25_years() {
    // Test data: 25 years old, nonce 12345
    let age: u8 = 25;
    let nonce: Field = 12345;
    let min_age: u8 = 20;
    
    // Generate commitment
    let commitment = compute_commitment(age, nonce);
    
    // Perform verification
    let result = main(commitment, min_age, age, nonce);
    
    // Check result
    assert(result == true, "25 years verification should pass");
}

#[test]
fn test_successful_verification_exact_age() {
    // Test data: exactly 20 years old
    let age: u8 = 20;
    let nonce: Field = 67890;
    let min_age: u8 = 20;
    
    let commitment = compute_commitment(age, nonce);
    let result = main(commitment, min_age, age, nonce);
    
    assert(result == true, "Exactly 20 years verification should pass");
}

#[test]
fn test_failed_verification_under_age() {
    // Test data: 19 years old (under age)
    let age: u8 = 19;
    let nonce: Field = 11111;
    let min_age: u8 = 20;
    
    let commitment = compute_commitment(age, nonce);
    let result = main(commitment, min_age, age, nonce);
    
    assert(result == false, "19 years verification should fail");
}

#[test]
fn test_commitment_integrity() {
    // Commitment integrity test
    let age: u8 = 25;
    let nonce: Field = 12345;
    
    let commitment = compute_commitment(age, nonce);
    let is_valid = verify_commitment_integrity(age, nonce, commitment);
    
    assert(is_valid == true, "Commitment integrity should be maintained");
}

#[test]
fn test_age_range_validation() {
    // Age range validation test
    assert(validate_age_range(25) == true, "25 years is valid range");
    assert(validate_age_range(0) == true, "0 years is valid range");
    assert(validate_age_range(150) == true, "150 years is valid range");
    // Note: u8 type in Noir automatically limits negative or >255 values
}

#[test]
fn test_multiple_scenarios() {
    // Multiple scenario test
    let test_cases = [
        (21, 54321, 20, true),  // 21 years, Pass
        (30, 98765, 20, true),  // 30 years, Pass
        (18, 13579, 20, false), // 18 years, Non-Pass
        (19, 24680, 20, false), // 19 years, Non-Pass
    ];
    
    for i in 0..4 {
        let (age, nonce, min_age, expected) = test_cases[i];
        let commitment = compute_commitment(age, nonce);
        let result = main(commitment, min_age, age, nonce);
        assert(result == expected, "Test case should match expected result");
    }
} 