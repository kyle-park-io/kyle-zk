# Halo2 ZK Examples

Halo2 is a zero-knowledge proof library developed by **Electric Coin Company**, using PLONKish arithmetization.

## 🚀 Features

- **PLONKish Arithmetization**: Flexible constraint system
- **Custom Gates**: Efficiently implement complex logic
- **Lookup Tables**: Optimization using precomputed values
- **Maximum Control**: Control every detail of circuit design

## ⚠️ Important Version Compatibility

### Halo2 v0.3 API Changes

- **Field Types**: Use `ff::Field` instead of `FieldExt`
- **Dependencies**: Requires `pasta_curves` and `ff` crates
- **Imports**: Import structure has changed significantly

## 📦 Installation

### 1. Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 2. Project Setup

The Cargo.toml is already configured with correct dependencies:

```toml
[dependencies]
halo2_proofs = { version = "0.3", features = ["dev-graph"] }
halo2_gadgets = "0.3"
pasta_curves = "0.5"
ff = "0.13"
```

## 🏃‍♂️ Usage

### Test Execution

```bash
cd halo2
cargo test
```

### Expected Test Output

```
running 2 tests
test tests::test_different_values ... ok
test tests::test_square_circuit ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

## 📚 Example Code Explanation

### Square Circuit Implementation

```rust
use halo2_proofs::{
    circuit::{Layouter, Region, SimpleFloorPlanner, Value},
    plonk::{Advice, Circuit, Column, ConstraintSystem, Error, Instance, Selector},
    poly::Rotation,
};
use pasta_curves::Fp;
use ff::Field;

#[derive(Default)]
pub struct SquareCircuit<F: Field> {
    pub a: Value<F>,
    _marker: PhantomData<F>,
}
```

**Key Components:**

- **Config**: Circuit configuration definition
- **Circuit Trait**: Actual circuit implementation
- **MockProver**: Testing and verification tool

**Constraint Definition:**

```rust
// Constraint: a * a = b
meta.create_gate("square", |meta| {
    let lhs = meta.query_advice(advice[0], Rotation::cur());
    let rhs = meta.query_advice(advice[1], Rotation::cur());
    let s_mul = meta.query_selector(s_mul);

    vec![s_mul * (lhs.clone() * lhs - rhs)]
});
```

## 🔍 Halo2 Core Concepts

### 1. Circuit Design Steps

#### Step 1: Config Definition

```rust
#[derive(Debug, Clone)]
pub struct SquareConfig {
    pub advice: [Column<Advice>; 2],    // Private values
    pub instance: Column<Instance>,      // Public values
    pub s_mul: Selector,                // Gate activator
}
```

#### Step 2: Constraint Creation

```rust
fn configure(meta: &mut ConstraintSystem<F>) -> Self::Config {
    let advice = [meta.advice_column(), meta.advice_column()];
    let instance = meta.instance_column();
    let s_mul = meta.selector();

    meta.enable_equality(advice[0]);
    meta.enable_equality(advice[1]);
    meta.enable_equality(instance);

    // Create gate constraint
    meta.create_gate("square", |meta| {
        // ... constraint logic
    });
}
```

#### Step 3: Value Assignment

```rust
fn synthesize(&self, config: Self::Config, mut layouter: impl Layouter<F>) -> Result<(), Error> {
    layouter.assign_region(
        || "square",
        |mut region: Region<'_, F>| {
            config.s_mul.enable(&mut region, 0)?;
            region.assign_advice(|| "a", config.advice[0], 0, || self.a)?;
            region.assign_advice(|| "a * a", config.advice[1], 0, || self.a.map(|a| a * a))?;
            Ok(())
        },
    )
}
```

### 2. Major Components

#### Columns

- **Advice**: Private inputs (witness)
- **Instance**: Public inputs
- **Fixed**: Constant values

#### Selectors

- Enable/disable gates at specific rows
- Implement conditional constraints

#### Gates

- Polynomial constraints
- Rules applied per row

## 🔧 Testing with MockProver

### Basic Testing Pattern

```rust
#[test]
fn test_square_circuit() {
    let k = 4;  // Circuit size parameter
    let a = Fp::from(5);
    let b = a * a; // 25

    let circuit = SquareCircuit {
        a: Value::known(a),
        _marker: PhantomData,
    };

    let public_input = vec![b];
    let prover = MockProver::run(k, &circuit, vec![public_input]).unwrap();
    prover.assert_satisfied();
}
```

### Test Results Analysis

- **MockProver**: Verifies constraint satisfaction
- **k parameter**: Determines circuit size (2^k rows)
- **Public inputs**: Values visible to verifier

## 🐛 Common Issues & Solutions

### 1. API Compatibility Errors

**Error**: `unresolved import halo2_proofs::arithmetic::FieldExt`
**Solution**: Use `ff::Field` instead:

```rust
use ff::Field;
// Instead of: use halo2_proofs::arithmetic::FieldExt;
```

### 2. Benchmark Configuration Issues

**Error**: `can't find 'square_circuit' bench`
**Solution**: Remove benchmark configuration from Cargo.toml:

```toml
# Remove this section:
# [[bench]]
# name = "square_circuit"
# harness = false
```

### 3. Missing Dependencies

**Error**: `unresolved import ff`
**Solution**: Add to Cargo.toml:

```toml
[dependencies]
ff = "0.13"
pasta_curves = "0.5"
```

## 📊 Performance Characteristics

### Test Performance

- **Compilation**: ~1-2 seconds
- **Test execution**: <0.01 seconds
- **Memory usage**: Minimal for basic circuits

### Circuit Efficiency

The square circuit is highly optimized:

- **Gates**: Single multiplication gate
- **Constraints**: One polynomial constraint
- **Rows**: Minimal circuit size

## 🎯 Learning Path

### Beginner (Current Implementation)

1. **Square Circuit**: Basic arithmetic constraint
2. **MockProver Testing**: Verification methods
3. **Value Assignment**: Understanding witness generation

### Intermediate (Next Steps)

1. **Multiple Gates**: Complex constraint combinations
2. **Lookup Tables**: Optimization techniques
3. **Custom Chips**: Reusable circuit components

### Advanced

1. **ECDSA Verification**: Signature verification circuits
2. **Merkle Tree**: Inclusion proof circuits
3. **Hash Functions**: SHA-256, Poseidon implementations

## 🚀 Real-World Applications

1. **Zcash**: Private transactions using Halo2
2. **Scroll**: zk-EVM implementation for Ethereum scaling
3. **Polygon Hermez**: Layer 2 scaling solution
4. **Mina Protocol**: Blockchain compression technology

## 🔗 Useful Resources

- [Halo2 Book](https://zcash.github.io/halo2/) - Comprehensive guide
- [Halo2 GitHub](https://github.com/zcash/halo2) - Source code and examples
- [PLONKish Arithmetization](https://zcash.github.io/halo2/concepts/arithmetization.html) - Theory
- [0xPARC Halo2 Tutorial](https://learn.0xparc.org/) - Practical examples

## 💡 Development Tips

### Debugging Strategies

1. **Start Simple**: Begin with basic arithmetic circuits
2. **Use MockProver**: Test constraints thoroughly before optimization
3. **Incremental Development**: Add complexity gradually
4. **Constraint Visualization**: Use dev-graph feature when available

### Code Organization

```rust
// Recommended structure:
mod circuits {
    mod square;
    mod multiply;
    // ... other circuits
}

mod utils {
    mod helpers;
    mod test_utils;
}
```

## ⚠️ Important Notes

### Complexity Warning

- **Steepest Learning Curve**: Among all ZK frameworks
- **Mathematical Background**: Requires understanding of finite fields
- **Debugging Difficulty**: Constraint errors can be hard to trace
- **Performance Sensitivity**: Circuit design greatly affects performance

### Best Practices

- Always start with MockProver testing
- Understand constraint costs before optimizing
- Use lookup tables for repeated computations
- Profile your circuits for bottlenecks

## 🔄 Migration from Earlier Versions

If upgrading from Halo2 v0.2 or earlier:

1. Update `FieldExt` to `ff::Field`
2. Add `pasta_curves` and `ff` dependencies
3. Update import statements
4. Review constraint system API changes

---

**Ready to dive deep into zero-knowledge circuit design!** 🚀

Start with the basic square circuit and gradually explore more complex constructions.
