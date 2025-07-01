# Noir ZK Examples

Noir is a domain-specific language for creating zero-knowledge proofs, developed by **Aztec**. It features Rust-like syntax.

## 🚀 Features

- **Rust-like Syntax**: Familiar and intuitive syntax
- **PLONK Proof System**: Efficient zk-SNARK implementation
- **Private Functions**: Prove computation results while hiding inputs
- **Fast Compilation**: Developer-friendly build times

## ⚠️ Important Limitations

### ASCII Characters Only

- **All comments, strings, and identifiers must use ASCII characters only**
- Korean, Chinese, or other Unicode characters will cause compilation errors
- This is a current limitation of the Noir compiler

### pub Keyword Restrictions

- `pub` keyword can only be used in the main function parameters
- Using `pub` in other functions will cause compilation errors
- Only the main function can have public inputs

### Field Type Limitations

- Field types cannot be directly compared with `>=`, `<=` operators
- Use `u32` or other integer types for comparisons
- All arithmetic happens in finite field arithmetic

## 📦 Installation

### 1. Install Nargo (Noir Package Manager)

```bash
curl -L https://raw.githubusercontent.com/noir-lang/noirup/main/install | bash
noirup
```

### 2. Verify Installation

```bash
nargo --version
```

## 🏃‍♂️ Usage

### Available Commands

```bash
nargo check      # Check syntax and types
nargo test       # Run tests
nargo compile    # Compile to ACIR format
nargo execute    # Generate witness
nargo info       # Show circuit information
```

### Complete Workflow

```bash
# 1. Check syntax
nargo check

# 2. Run tests (6 tests should pass)
nargo test

# 3. Compile circuit
nargo compile

# 4. Execute and generate witness
nargo execute

# 5. View circuit info
nargo info
```

## 📚 Example Code Explanations

### 1. Basic Square Proof (`main`)

```noir
fn main(secret_number: Field, public_square: pub Field) {
    assert(secret_number * secret_number == public_square);
}
```

- **Purpose**: Prove that a secret number squared equals a public value
- **Usage**: Most basic zero-knowledge proof

### 2. Range Proof (`range_proof`)

```noir
fn range_proof(secret: u32, min: u32, max: u32) {
    assert(secret >= min);
    assert(secret <= max);
}
```

- **Purpose**: Prove a secret value is within a specific range
- **Note**: Uses `u32` instead of `Field` for comparisons
- **Usage**: Age verification, balance proofs

### 3. Hash Preimage Proof (`hash_preimage`)

```noir
fn hash_preimage(preimage: Field, public_hash: Field) {
    let computed_hash = preimage * 1337 + 42;
    assert(computed_hash == public_hash);
}
```

- **Purpose**: Prove knowledge of a preimage without revealing it
- **Note**: Uses simplified hash function (multiply + add)
- **Usage**: Password verification, commit-reveal schemes

### 4. Age Verification (`age_verification`)

```noir
fn age_verification(birth_year: u32, current_year: u32) {
    let age = current_year - birth_year;
    assert(age >= 18);
}
```

- **Purpose**: Prove you're over 18 without revealing your age
- **Usage**: KYC, age-restricted services

## 🔍 Noir Core Concepts

### Data Types

- **Field**: Primary data type for zero-knowledge computations
- **u32, u64**: Integer types for comparisons and arithmetic
- **bool**: Boolean type for logic operations

### Function Types

- **main**: Entry point with public inputs (marked with `pub`)
- **Regular functions**: Cannot have `pub` parameters
- **Test functions**: Marked with `#[test]` attribute

### Built-in Functions

- `assert()`: Constraint verification
- Basic arithmetic: `+`, `-`, `*` (division more complex)
- Comparisons: `>=`, `<=`, `==` (only for integer types)

## 🎯 Configuration Files

### Prover.toml (Prover Input)

```toml
# Input values for basic square proof example
secret_number = "5"
public_square = "25"

# Use the values below to test other examples
# Range proof example
# secret = "15"
# min = "10"
# max = "20"
```

### Verifier.toml (Verifier Input)

```toml
# Contains only public information known to the verifier
public_square = "25"
```

## 📊 Test Results

When you run `nargo test`, you should see:

```
[noir_zk_examples] Running 6 test functions
[noir_zk_examples] Testing test_main ... ok
[noir_zk_examples] Testing test_age_verification ... ok
[noir_zk_examples] Testing test_sum_proof ... ok
[noir_zk_examples] Testing test_hash_preimage ... ok
[noir_zk_examples] Testing test_range_proof ... ok
[noir_zk_examples] Testing test_password_verification ... ok
[noir_zk_examples] 6 tests passed
```

## 📁 Generated Files

After compilation and execution:

- `target/noir_zk_examples.json` - Compiled circuit (ACIR format)
- `target/noir_zk_examples.gz` - Witness data

## 🔧 Circuit Information

Running `nargo info` shows:

```
+------------------+----------+----------------------+--------------+-----------------+
| Package          | Function | Expression Width     | ACIR Opcodes | Brillig Opcodes |
+------------------+----------+----------------------+--------------+-----------------+
| noir_zk_examples | main     | Bounded { width: 4 } | 1            | 0               |
+------------------+----------+----------------------+--------------+-----------------+
```

This indicates a very efficient circuit with minimal constraints.

## 🚀 Real-World Use Cases

1. **Private Voting**: Prove vote validity without revealing the vote
2. **Anonymous Authentication**: Prove credentials without revealing identity
3. **Private Transactions**: Prove sufficient balance without revealing amount
4. **KYC Proofs**: Prove compliance without revealing personal data

## 🔗 Useful Links

- [Noir Documentation](https://noir-lang.org/)
- [Noir Examples](https://github.com/noir-lang/noir-examples)
- [Aztec Protocol](https://aztec.network/)

## 💡 Next Steps

1. **Complex Logic**: Implement conditional statements and loops
2. **Merkle Tree**: Implement inclusion proofs
3. **Signature Verification**: ECDSA, EdDSA verification circuits
4. **App Integration**: Connect with JavaScript/TypeScript applications

## 🐛 Common Issues

### Compilation Errors

- **"Invalid comment character"**: Use only ASCII characters
- **"unnecessary pub keyword"**: Remove `pub` from non-main functions
- **"Fields cannot be compared"**: Use integer types for comparisons

### Solutions

- Replace all non-ASCII characters with ASCII equivalents
- Only use `pub` in main function parameters
- Use `u32`, `u64` for values that need comparison operations
