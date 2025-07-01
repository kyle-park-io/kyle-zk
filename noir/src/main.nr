// Basic square proof example
fn main(secret_number: Field, public_square: pub Field) {
    assert(secret_number * secret_number == public_square);
}

// Proof that a secret number is within a specific range
fn range_proof(secret: u32, min: u32, max: u32) {
    assert(secret >= min);
    assert(secret <= max);
}

// Hash preimage proof (simplified)
fn hash_preimage(preimage: Field, public_hash: Field) {
    // Simple hash function: multiply by a constant and add another
    let computed_hash = preimage * 1337 + 42;
    assert(computed_hash == public_hash);
}

// Proof that the sum of two secret numbers equals a public value
fn sum_proof(secret_a: Field, secret_b: Field, public_sum: Field) {
    assert(secret_a + secret_b == public_sum);
}

// Age verification (prove you're over 18 without revealing your age)
fn age_verification(birth_year: u32, current_year: u32) {
    let age = current_year - birth_year;
    assert(age >= 18);
}

// Password hash verification (simplified)
fn password_verification(password: Field, public_hash: Field) {
    // Simple hash function (in practice, use more complex hash)
    let computed_hash = password * 1337 + 42;
    assert(computed_hash == public_hash);
}

#[test]
fn test_main() {
    main(5, 25);
}

#[test]
fn test_range_proof() {
    range_proof(15, 10, 20);
}

#[test]
fn test_sum_proof() {
    sum_proof(10, 20, 30);
}

#[test]
fn test_hash_preimage() {
    let preimage = 123;
    let expected_hash = preimage * 1337 + 42;
    hash_preimage(preimage, expected_hash);
}

#[test]
fn test_age_verification() {
    age_verification(1990, 2024); // 34 years old, >= 18
}

#[test]
fn test_password_verification() {
    let password = 12345;
    let expected_hash = password * 1337 + 42;
    password_verification(password, expected_hash);
} 