# Zero-Knowledge Proof Learning Repository

This repository contains projects for learning and experimenting with various Zero-Knowledge Proof frameworks.

## 📁 Project Structure

```
kyle-zk/
├── arithmetic/         # Basic arithmetic ZK examples
│   ├── cairo/          # Cairo (StarkNet) arithmetic implementation
│   ├── halo2/          # Halo2 arithmetic implementation
│   ├── noir/           # Noir (Aztec) arithmetic implementation
│   └── README.md       # Detailed guide and comparison analysis
├── age-verification-zk/ # Age verification ZK examples
└── md/                 # Technical documentation
```

## 🚀 Getting Started

### 1. Basic Arithmetic Examples (arithmetic/)

The most fundamental ZK proof examples, comparing three major frameworks:

```bash
# Run all framework tests
cd arithmetic

# Noir tests (easiest to start)
cd noir && nargo test

# Cairo tests (functional paradigm)
cd cairo && scarb test

# Halo2 tests (most complex but powerful)
cd halo2 && cargo test
```

### 2. Recommended Learning Order

1. **Noir** - Most intuitive and fastest to get started
2. **Cairo** - Learn functional programming paradigm
3. **Halo2** - Understand low-level circuit design

## 📊 Framework Comparison

| Framework | Language Style | Proof System | Difficulty | Ecosystem     |
| --------- | -------------- | ------------ | ---------- | ------------- |
| **Noir**  | Rust-like      | PLONK        | ⭐⭐       | Aztec         |
| **Cairo** | Functional     | STARK        | ⭐⭐⭐     | StarkNet      |
| **Halo2** | Rust           | PLONKish     | ⭐⭐⭐⭐⭐ | Zcash, Scroll |

## 🎯 Learning Goals

- **Core Concepts**: Understanding fundamental ZK proof principles
- **Framework Comparison**: Identifying strengths and weaknesses of each framework
- **Practical Implementation**: Writing and testing simple proof circuits
- **Performance Analysis**: Comparing performance characteristics of each framework

## 📚 Detailed Information

For detailed explanations and usage instructions, refer to the README.md files in each project folder:

- [Arithmetic Examples Detailed Guide](./arithmetic/README.md)
- [Age Verification Examples](./age-verification-zk/README.md)
- [Technical Documentation](./md/)

## 🔮 Future Plans

This repository will be expanded with the following ZK projects:

- **advanced-circuits/**: Complex circuit implementation examples
- **practical-apps/**: Real-world application implementations
- **performance-tests/**: Performance benchmarks and comparisons
- **tutorials/**: Step-by-step learning guides

---

_Welcome to the world of Zero-Knowledge Proofs! 🌟_
