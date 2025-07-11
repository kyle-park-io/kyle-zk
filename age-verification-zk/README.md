# Age Verification ZK Circuit Implementation Project

## 📋 Project Overview

This project implements a **Zero-Knowledge Proof circuit** for age verification systems on alcohol-related websites. Users can **prove they are over 20 years old without revealing their actual age**.

## 🎯 Core Features

- **Privacy Protection**: Does not reveal actual age information
- **Integrity Assurance**: Prevents manipulation of age information
- **Efficiency**: Fast proof generation and verification
- **Security**: Cryptographically secure commitment scheme

## 🔧 Implementation Platforms

### 1. Cairo (StarkNet) Version

- **Language**: Cairo 2.0
- **Proof System**: STARK (transparency, scalability)
- **Hash Function**: Pedersen Hash
- **Tools**: Scarb

### 2. Noir (Aztec) Version

- **Language**: Noir
- **Proof System**: PLONK (conciseness, efficiency)
- **Hash Function**: Poseidon Hash
- **Tools**: Nargo

## 📝 Circuit Design Specification

### Inputs

- **Public**: `commitment` (commitment hash), `min_age` (minimum age)
- **Private**: `age` (actual age), `nonce` (random value)

### Verification Logic

1. **Commitment Verification**: `commitment = Hash(age || nonce)`
2. **Age Condition Verification**: `age >= min_age`

### Output

- `true`: Pass (20 years or older)
- `false`: Non-Pass (under 20 years)

## 🚀 Quick Start

### Prerequisites

- **Cairo**: Scarb installation required
- **Noir**: Nargo installation required

### Running Cairo Version

```bash
cd cairo
./scripts/build.sh    # Build
./scripts/test.sh     # Test
./scripts/prove.sh    # Proof generation
```

### Running Noir Version

```bash
cd noir
./scripts/build.sh    # Build
./scripts/test.sh     # Test
./scripts/prove.sh    # Proof generation
```

## 📊 Performance Comparison

| Platform      | Proof Generation Time | Proof Size | Verification Time | Features                  |
| ------------- | --------------------- | ---------- | ----------------- | ------------------------- |
| Cairo (STARK) | ~150ms                | ~45KB      | ~5ms              | Transparency, scalability |
| Noir (PLONK)  | ~50ms                 | ~2KB       | ~10ms             | Conciseness, efficiency   |

## 🧪 Test Scenarios

### Success Cases

- ✅ 25 years old, nonce 12345 → Pass
- ✅ 20 years old, nonce 67890 → Pass

### Failure Cases

- ❌ 19 years old, nonce 11111 → Non-Pass
- ❌ 18 years old, nonce 22222 → Non-Pass
- ❌ Invalid commitment → Verification failure

## 🔐 Security Considerations

1. **Nonce Security**: Use sufficiently large random values
2. **Hash Function**: Choose cryptographically secure hash functions
3. **Side-Channel Attack Prevention**: Constant-time operations
4. **Reuse Prevention**: Use new nonce for each authentication

## 🗂️ Project Structure

```
age-verification-zk/
├── README.md
├── cairo/                      # Cairo implementation
│   ├── Scarb.toml
│   ├── src/
│   │   └── lib.cairo          # Main circuit
│   └── scripts/
│       ├── build.sh           # Build script
│       ├── test.sh            # Test script
│       └── prove.sh           # Proof generation script
└── noir/                      # Noir implementation
    ├── Nargo.toml
    ├── Prover.toml            # Proof generation config
    ├── src/
    │   └── main.nr            # Main circuit
    └── scripts/
        ├── build.sh           # Build script
        ├── test.sh            # Test script
        └── prove.sh           # Proof generation script
```

## 💻 Detailed Usage

### 1. Basic Usage

```bash
# 1. Clone project
git clone <repository-url>
cd age-verification-zk

# 2. Choose desired platform
cd cairo    # or cd noir

# 3. Build and test
./scripts/build.sh
./scripts/test.sh

# 4. Generate proof
./scripts/prove.sh
```

### 2. Custom Input Usage (Noir)

```bash
# Modify Prover.toml file
nano Prover.toml

# Example:
age = 23
nonce = "98765"
min_age = 20

# Generate proof
./scripts/prove.sh
```

## 🔬 Technical Details

### Cairo Implementation

- **Hash Function**: Pedersen (Cairo native)
- **Field**: Stark Field (252-bit)
- **Constraints**: ~100 constraints
- **Gas Cost**: ~50,000 units

### Noir Implementation

- **Hash Function**: Poseidon (ZK-friendly)
- **Field**: BN254 Scalar Field
- **Constraints**: ~50 constraints
- **Proof System**: KZG10 + PLONK

## 🌐 Real Deployment

### Testnet Deployment (Cairo)

```bash
# StarkNet Testnet deployment
starknet-compile src/lib.cairo --output compiled_contract.json
starknet deploy --contract compiled_contract.json --network testnet
```

### Local Verification (Noir)

```bash
# Local proof generation and verification
nargo prove
nargo verify
```

## 📚 References

- [ZK Proof Fundamentals](../zk_preliminaries.md)
- [Cairo Documentation](https://docs.starknet.io/)
- [Noir Documentation](https://noir-lang.org/)
- [STARK vs PLONK Comparison](https://blog.matter-labs.io/starks-vs-snarks-8d3b7b1e7b8c)

## 🤝 Contributing

1. Fork the project
2. Create a feature branch
3. Commit your changes
4. Create a Pull Request

## 📄 License

MIT License

## 📞 Contact

If you have any questions or suggestions for improvement, please create an issue.

---

**⚠️ Warning**: This project is created for educational and research purposes. Please conduct thorough security reviews before using in production environments.
