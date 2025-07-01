# Cairo ZK Examples

Cairo is a functional programming language used by **StarkNet** for generating STARK proofs.

## 🚀 Features

- **Functional Programming**: Immutability-based safe programming
- **STARK Proofs**: Quantum-resistant and highly scalable
- **StarkNet Integration**: Direct connection to Layer 2 solution
- **Slow Prover, Fast Verifier**: Proof generation takes time but verification is fast

## ⚠️ Important Version Information

### Cairo 2.11.4 Changes

- **Simplified Imports**: Many previous imports are no longer needed
- **Test Plugin**: Requires `cairo_test` dev-dependency
- **felt252 Limitations**: No comparison operators (>=, <=) for finite field elements

## 📦 Installation

### 1. Install Scarb (Cairo Package Manager)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
```

### 2. Setup Version Configuration

Create a `.tool-versions` file (required):

```bash
echo "scarb 2.11.4" > .tool-versions
```

### 3. Verify Installation

```bash
scarb --version
```

Expected output:

```
scarb 2.11.4 (c0ef5ec6a 2025-04-09)
cairo: 2.11.4
sierra: 1.7.0
```

## 🏃‍♂️ Usage

### Test Execution

```bash
cd cairo
scarb test
```

### Build

```bash
scarb build
```

### Expected Test Results

```
running 4 tests
test cairo_zk_examples::tests::test_square_proof ... ok (gas usage est.: 1800)
test cairo_zk_examples::tests::test_addition_proof ... ok (gas usage est.: 1800)
test cairo_zk_examples::tests::test_sum_square_proof ... ok (gas usage est.: 1500)
test cairo_zk_examples::tests::test_hash_preimage_proof ... ok (gas usage est.: 1800)
test result: ok. 4 passed; 0 failed; 0 ignored; 0 filtered out;
```

## 📚 Example Code Explanations

### 1. Basic Square Proof (`square_proof`)

```cairo
fn square_proof(x: felt252, y: felt252) -> bool {
    x * x == y
}
```

- **Purpose**: Prove that number x is the square root of y
- **Usage**: Basic arithmetic proof learning
- **Gas Usage**: ~1800

### 2. Sum Square Proof (`sum_square_proof`)

```cairo
fn sum_square_proof(a: felt252, b: felt252, result: felt252) -> bool {
    let sum = a + b;
    sum * sum == result
}
```

- **Purpose**: Prove that (a + b)² = result
- **Usage**: Composite operation proof
- **Gas Usage**: ~1500 (most efficient!)

### 3. Hash Preimage Proof (`hash_preimage_proof`)

```cairo
fn hash_preimage_proof(preimage: felt252, hash: felt252) -> bool {
    let computed_hash = preimage * 1337 + 42;
    computed_hash == hash
}
```

- **Purpose**: Prove knowledge of preimage without revealing it
- **Usage**: Password verification, commit-reveal schemes
- **Gas Usage**: ~1800

### 4. Addition Proof (`addition_proof`)

```cairo
fn addition_proof(a: felt252, b: felt252, result: felt252) -> bool {
    a + b == result
}
```

- **Purpose**: Prove that a + b = result
- **Usage**: Basic arithmetic verification
- **Gas Usage**: ~1800

## 🔍 Cairo Core Concepts

### felt252 Type

- Cairo's primary data type
- 252-bit finite field element
- All computations happen in modular arithmetic
- **No comparison operators**: Cannot use `>=`, `<=` with felt252

### Functional Characteristics

- Variables are immutable by default
- Pure function oriented
- Minimal side effects
- Gas-efficient design

### Proof System

- **Private Input**: Secret input values
- **Public Input**: Public input values
- **Assertion**: Conditions to prove

## 🛠️ Project Configuration

### Scarb.toml Structure

```toml
[package]
name = "cairo_zk_examples"
version = "0.1.0"
edition = "2023_11"

[dependencies]
starknet = "2.4.0"

[dev-dependencies]
cairo_test = "2.11.4"
```

### Required Files

- `.tool-versions` - Scarb version specification
- `Scarb.toml` - Project configuration
- `src/lib.cairo` - Main code file

## 📊 Performance Analysis

### Gas Usage Comparison

| Function              | Gas Usage | Efficiency     |
| --------------------- | --------- | -------------- |
| `sum_square_proof`    | 1500      | Most efficient |
| `square_proof`        | 1800      | Standard       |
| `addition_proof`      | 1800      | Standard       |
| `hash_preimage_proof` | 1800      | Standard       |

### Why Gas Matters

- **StarkNet Deployment**: Gas costs affect deployment
- **Optimization**: Lower gas = better performance
- **Scalability**: Efficient proofs scale better

## 🐛 Common Issues & Solutions

### 1. Scarb Version Error

**Error**: `No version is set for command scarb`
**Solution**: Create `.tool-versions` file:

```bash
echo "scarb 2.11.4" > .tool-versions
```

### 2. Missing cairo_test Plugin

**Error**: `cairo_test plugin not found`
**Solution**: Add to `Scarb.toml`:

```toml
[dev-dependencies]
cairo_test = "2.11.4"
```

### 3. Comparison Operator Error

**Error**: `Trait has no implementation: PartialOrd::<felt252>`
**Solution**: Use integer types for comparisons or avoid comparisons with felt252:

```cairo
// ❌ This doesn't work
fn bad_range_check(value: felt252, min: felt252) -> bool {
    value >= min  // Error!
}

// ✅ This works
fn good_equality_check(a: felt252, b: felt252) -> bool {
    a == b  // OK!
}
```

### 4. Import Errors

**Error**: `Identifier not found: array::ArrayTrait`
**Solution**: Remove unnecessary imports in Cairo 2.11.4:

```cairo
// ❌ Old style (not needed in 2.11.4)
use array::ArrayTrait;
use option::OptionTrait;

// ✅ Modern style (minimal imports)
// Most traits are in scope automatically
```

## 🎯 Learning Path

### Beginner (Current Implementation)

1. **Basic Square Proof**: Understanding felt252 arithmetic
2. **Addition Proof**: Simple linear operations
3. **Hash Preimage**: Introduction to cryptographic concepts

### Intermediate (Next Steps)

1. **Complex Arithmetic**: Multi-step calculations
2. **Data Structures**: Working with arrays and structs
3. **StarkNet Integration**: Deploying to testnet

### Advanced

1. **Pedersen Hashing**: Real cryptographic hash functions
2. **Merkle Trees**: Tree-based proofs
3. **Signature Verification**: ECDSA/EdDSA verification

## 🚀 Real-World Applications

1. **Private Voting**: Vote without revealing choice
2. **Anonymous Authentication**: Prove credentials privately
3. **Scaling Solutions**: StarkNet Layer 2 transactions
4. **DeFi Privacy**: Private balance proofs

## 🔗 Useful Resources

- [Cairo Documentation](https://docs.cairo-lang.org/)
- [StarkNet Documentation](https://docs.starknet.io/)
- [Cairo Examples](https://github.com/starkware-libs/cairo)
- [StarkNet Book](https://book.starknet.io/)

## 💡 Development Tips

### Testing Best Practices

1. **Start Simple**: Begin with basic arithmetic
2. **Gas Optimization**: Monitor gas usage in tests
3. **Functional Thinking**: Embrace immutability
4. **Modular Design**: Keep functions pure and simple

### Debugging Strategies

1. **Assert Messages**: Use descriptive error messages
2. **Unit Testing**: Test each function individually
3. **Gas Profiling**: Optimize for lower gas usage
4. **Type Safety**: Leverage Cairo's type system

## 🔄 Migration from Earlier Versions

If upgrading from Cairo 1.x:

1. Remove unnecessary trait imports
2. Add `cairo_test` dev-dependency
3. Update test syntax to use `#[test]` attribute
4. Review felt252 usage patterns

## ⚠️ Important Limitations

### felt252 Constraints

- **No comparison operators**: Cannot use `<`, `>`, `<=`, `>=`
- **Finite field arithmetic**: All operations modulo large prime
- **No negative numbers**: Use field subtraction instead

### Development Constraints

- **Immutability**: Variables cannot be reassigned
- **Pure functions**: Minimize side effects
- **Gas awareness**: Consider computational costs

---

**Ready to explore STARK-based zero-knowledge proofs!** 🌟

Start with basic arithmetic and gradually build towards complex StarkNet applications.
