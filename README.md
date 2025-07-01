# ZK Framework Learning Project

This project contains example code for learning major Zero-Knowledge Proof frameworks: **Cairo**, **Noir**, and **Halo2**.

## 📁 Project Structure

```
zk/
├── cairo/          # Cairo (StarkNet) examples - ✅ 4 tests passed
├── noir/           # Noir (Aztec) examples - ✅ 6 tests passed
├── halo2/          # Halo2 examples - ✅ 2 tests passed
└── README.md       # This file
```

## 🎯 Framework Comparison

| Framework | Language Style | Proof System | Difficulty | Ecosystem     | Test Results  |
| --------- | -------------- | ------------ | ---------- | ------------- | ------------- |
| **Cairo** | Functional     | STARK        | ⭐⭐⭐     | StarkNet      | ✅ 4/4 passed |
| **Noir**  | Rust-like      | PLONK        | ⭐⭐       | Aztec         | ✅ 6/6 passed |
| **Halo2** | Rust           | PLONKish     | ⭐⭐⭐⭐⭐ | Zcash, Scroll | ✅ 2/2 passed |

## 🚀 Quick Start

### 1. Recommended Learning Order

1. **Noir** - Most intuitive and fastest to get started
2. **Cairo** - Learn functional programming paradigm
3. **Halo2** - Understand low-level circuit design

### 2. Run Tests for Each Framework

```bash
# Start with Noir (easiest)
cd noir && nargo test

# Try Cairo (functional style)
cd cairo && scarb test

# Challenge Halo2 (most complex)
cd halo2 && cargo test
```

## 📊 Test Results Summary

### ✅ All Frameworks Successfully Tested!

#### **Noir** (Aztec Framework)

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

**Performance**: Expression Width: 4, ACIR Opcodes: 1

#### **Cairo** (StarkNet Framework)

```
running 4 tests
test cairo_zk_examples::tests::test_square_proof ... ok (gas usage est.: 1800)
test cairo_zk_examples::tests::test_addition_proof ... ok (gas usage est.: 1800)
test cairo_zk_examples::tests::test_sum_square_proof ... ok (gas usage est.: 1500)
test cairo_zk_examples::tests::test_hash_preimage_proof ... ok (gas usage est.: 1800)
test result: ok. 4 passed; 0 failed; 0 ignored; 0 filtered out;
```

**Performance**: Gas usage 1500-1800, functional programming efficiency

#### **Halo2** (Electric Coin Company)

```
running 2 tests
test tests::test_different_values ... ok
test tests::test_square_circuit ... ok
test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

**Performance**: <0.01s execution, MockProver verification passed

## 📚 Learning Resources

Each folder contains detailed README.md files with comprehensive guides:

- [Cairo Examples & Guide](./cairo/README.md)
- [Noir Examples & Guide](./noir/README.md)
- [Halo2 Examples & Guide](./halo2/README.md)

## 🔍 Example Code Overview

### Common Examples Across All Frameworks

All frameworks demonstrate these fundamental concepts:

1. **Square Proof**: Prove secret number squared equals public value
2. **Hash Preimage**: Prove knowledge of hash preimage
3. **Addition/Sum Proof**: Basic arithmetic operations
4. **Complex Computations**: Multi-step calculations

### Framework-Specific Features

#### Cairo

- **StarkNet functional paradigm**: Immutable, gas-efficient
- **felt252 data type**: 252-bit finite field elements
- **STARK proof system**: Quantum-resistant, scalable

#### Noir

- **Rust-style syntax**: Familiar and developer-friendly
- **Age verification, password checks**: Practical examples
- **PLONK proof system**: Efficient zk-SNARKs

#### Halo2

- **PLONKish circuit design**: Maximum control and flexibility
- **Custom gates and chips**: Advanced circuit optimization
- **MockProver testing**: Comprehensive constraint verification

## 🛠️ Development Environment Setup

### Installation Summary

```bash
# Cairo (Scarb) - Requires version configuration
curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
echo "scarb 2.11.4" > cairo/.tool-versions

# Noir (Nargo) - ASCII-only limitations
curl -L https://raw.githubusercontent.com/noir-lang/noirup/main/install | bash && noirup

# Halo2 (Rust) - API compatibility challenges
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## 🚨 Important Discovered Limitations

### **Noir Constraints**

- **ASCII Characters Only**: Comments and strings must be ASCII
- **pub Keyword Restriction**: Only usable in main function parameters
- **Field Comparisons**: Cannot directly compare Field types with `>=`, `<=`

### **Cairo Constraints**

- **No Comparison Operators**: felt252 cannot use `>=`, `<=` (finite field limitation)
- **Version Configuration**: Requires `.tool-versions` file for scarb
- **Import Simplification**: Cairo 2.11.4 removed many required imports

### **Halo2 Constraints**

- **API Evolution**: v0.3 changed from `FieldExt` to `ff::Field`
- **Dependency Complexity**: Requires careful version management
- **Learning Curve**: Steepest among all three frameworks

## 🎓 Learning Tips

### Progressive Learning Strategy

**Week 1: Noir Foundation**

- Start with basic square proofs
- Understand public vs private inputs
- Learn constraint-based thinking

**Week 2: Cairo Exploration**

- Embrace functional programming paradigm
- Understand gas optimization in STARKs
- Learn felt252 arithmetic limitations

**Week 3: Halo2 Deep Dive**

- Master circuit design concepts
- Understand constraint systems
- Practice with MockProver testing

**Week 4: Real Applications**

- Implement practical use cases
- Compare framework trade-offs
- Build complete ZK applications

### Key Success Factors

1. **Start Simple**: Basic arithmetic before complex logic
2. **Read Error Messages**: Framework errors are often informative
3. **Test Incrementally**: Small changes, frequent testing
4. **Understand Constraints**: Each framework has unique limitations

## 📈 Performance Comparison

| Metric                 | Noir    | Cairo                     | Halo2                        |
| ---------------------- | ------- | ------------------------- | ---------------------------- |
| **Setup Time**         | Fast    | Medium (version config)   | Slow (API complexity)        |
| **Compilation**        | <1s     | ~3s                       | ~1-2s                        |
| **Test Execution**     | <0.01s  | <0.01s                    | <0.01s                       |
| **Learning Curve**     | Gentle  | Moderate                  | Steep                        |
| **Development Speed**  | Fastest | Medium                    | Slowest                      |
| **Circuit Efficiency** | Good    | Excellent (gas optimized) | Excellent (highly optimized) |

## 🔗 Additional Resources

### Official Documentation

- [Cairo Documentation](https://docs.cairo-lang.org/)
- [Noir Documentation](https://noir-lang.org/)
- [Halo2 Book](https://zcash.github.io/halo2/)

### Community & Learning

- [StarkNet Discord](https://discord.gg/starknet) - Cairo community
- [Noir Discord](https://discord.gg/aztec) - Noir/Aztec community
- [ZK Research](https://zkresearch.org/) - General ZK knowledge

### Advanced Learning

- [0xPARC Learning Group](https://learn.0xparc.org/) - Advanced ZK concepts
- [ZK Whiteboard Sessions](https://zkhack.dev/) - Deep technical content
- [Awesome Zero Knowledge](https://github.com/matter-labs/awesome-zero-knowledge-proofs) - Curated resources

## 💡 Project Ideas for Practice

### Beginner Projects

1. **Simple Calculator**: Prove arithmetic without revealing numbers
2. **Age Verification**: Prove age ≥ 18 without revealing exact age
3. **Password Checker**: Verify password without exposing it

### Intermediate Projects

1. **Private Voting System**: Vote without revealing choice
2. **Anonymous Authentication**: Prove group membership privately
3. **Range Proofs**: Prove value within range without revealing value

### Advanced Projects

1. **Private Auction System**: Bid without revealing amounts
2. **ZK Identity System**: Selective disclosure of credentials
3. **Private DeFi**: Balance proofs without exposing holdings

## 🔄 Migration and Compatibility

### Version Management Lessons Learned

- **Cairo**: Always specify version in `.tool-versions`
- **Noir**: Stick to ASCII characters for maximum compatibility
- **Halo2**: Pin dependency versions carefully

### API Evolution Handling

- **Test Regularly**: APIs evolve rapidly in ZK space
- **Read Release Notes**: Breaking changes are common
- **Community Resources**: Discord/forums often have migration guides

---

## 🎉 **Congratulations!**

You now have a complete, working environment for all three major ZK frameworks!

**Next Steps:**

1. **Experiment**: Modify the example code to understand behavior
2. **Build**: Create your own ZK applications
3. **Share**: Contribute back to the ZK community

**Happy ZK Development!** 🚀🔐

Each framework offers unique strengths - choose based on your project needs and learning goals.
