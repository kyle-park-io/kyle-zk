# Age Verification ZK Circuit Implementation Task

## 📋 Project Overview

This project implements a Zero-Knowledge Proof circuit for age verification systems on alcohol-related websites. Users can prove they are over 20 years old without revealing their actual age.

## 🎯 Goals

- Privacy protection: Does not reveal actual age
- Integrity assurance: Prevents manipulation of age information
- Efficiency: Fast verification process

## 🔧 Implementation Platforms

### 1. Cairo (StarkNet)

- **Language**: Cairo 2.0
- **Proof System**: STARK
- **Tools**: Scarb, Prover

### 2. Noir (Aztec)

- **Language**: Noir
- **Proof System**: PLONK
- **Tools**: Nargo

## 📝 Circuit Design Specification

### Public Input

- `commitment`: Commitment hash of age information
- `min_age`: Minimum age requirement (20 years)

### Private Input (Witness)

- `age`: Actual age
- `nonce`: Random value for commitment generation (salt)

### Verification Logic

1. **Commitment Verification**

   ```
   commitment = Hash(age || nonce)
   ```

   - Supported hash functions: Keccak-256, SHA-256, Poseidon, etc.

2. **Age Condition Verification**
   ```
   age >= min_age
   ```

### Output

- `Pass`: 20 years or older
- `Non-Pass`: Under 20 years

## 🗂️ Project Structure

```
age-verification-zk/
├── README.md
├── cairo/
│   ├── Scarb.toml
│   ├── src/
│   │   └── lib.cairo
│   ├── scripts/
│   │   ├── build.sh
│   │   ├── test.sh
│   │   └── prove.sh
│   └── tests/
│       └── test_age_verification.cairo
└── noir/
    ├── Nargo.toml
    ├── src/
    │   └── main.nr
    ├── Prover.toml
    ├── scripts/
    │   ├── build.sh
    │   ├── test.sh
    │   └── prove.sh
    └── tests/
        └── test_age_verification.nr
```

## 🚀 Execution Method

### Cairo Version

```bash
cd cairo
./scripts/build.sh
./scripts/test.sh
./scripts/prove.sh
```

### Noir Version

```bash
cd noir
./scripts/build.sh
./scripts/test.sh
./scripts/prove.sh
```

## 🧪 Test Scenarios

### Success Cases

- Age 25, nonce 12345 → Pass
- Age 20, nonce 67890 → Pass

### Failure Cases

- Age 19, nonce 11111 → Non-Pass
- Age 18, nonce 22222 → Non-Pass
- Invalid commitment → Verification failure

## 🔐 Security Considerations

1. **Nonce Security**: Use sufficiently large random values
2. **Hash Function Selection**: Use cryptographically secure hash functions
3. **Side-Channel Attack Prevention**: Constant-time operations
4. **Reuse Prevention**: Use new nonce for each authentication

## 📊 Performance Analysis

### Proof Generation Time

- Cairo: ~X ms
- Noir: ~Y ms

### Verification Time

- Cairo: ~A ms
- Noir: ~B ms

### Proof Size

- Cairo: ~X bytes
- Noir: ~Y bytes

## 🔗 References

- [Cairo Documentation](https://docs.starknet.io/documentation/architecture_and_concepts/Smart_Contracts/cairo-on-starknet/)
- [Noir Documentation](https://noir-lang.org/)
- [ZK Proof Fundamentals](./zk_preliminaries.md)
