// Simple square proof example
// Prove that x is the square root of y
fn square_proof(x: felt252, y: felt252) -> bool {
    x * x == y
}

// Sum square proof example
// Prove that (a + b)^2 = result
fn sum_square_proof(a: felt252, b: felt252, result: felt252) -> bool {
    let sum = a + b;
    sum * sum == result
}

// Hash preimage proof example
fn hash_preimage_proof(preimage: felt252, hash: felt252) -> bool {
    // Simple hash function (in practice, use Pedersen hash)
    let computed_hash = preimage * 1337 + 42;
    computed_hash == hash
}

// Addition proof example
fn addition_proof(a: felt252, b: felt252, result: felt252) -> bool {
    a + b == result
}

#[cfg(test)]
mod tests {
    use super::{square_proof, sum_square_proof, hash_preimage_proof, addition_proof};

    #[test]
    fn test_square_proof() {
        assert(square_proof(5, 25), 'Square proof failed');
        assert(square_proof(10, 100), 'Square proof failed');
    }

    #[test]
    fn test_sum_square_proof() {
        // (3 + 4)^2 = 49
        assert(sum_square_proof(3, 4, 49), 'Sum square proof failed');
    }

    #[test]
    fn test_hash_preimage_proof() {
        let preimage = 123;
        let hash = preimage * 1337 + 42;
        assert(hash_preimage_proof(preimage, hash), 'Hash preimage proof failed');
    }

    #[test]
    fn test_addition_proof() {
        assert(addition_proof(10, 20, 30), 'Addition proof failed');
        assert(addition_proof(5, 7, 12), 'Addition proof failed');
    }
}
