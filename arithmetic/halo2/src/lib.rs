use ff::Field;
use halo2_proofs::{
    circuit::{Layouter, Region, SimpleFloorPlanner, Value},
    plonk::{Advice, Circuit, Column, ConstraintSystem, Error, Instance, Selector},
    poly::Rotation,
};
use pasta_curves::Fp;
use std::marker::PhantomData;

// Simple square circuit example
#[derive(Debug, Clone)]
pub struct SquareConfig {
    pub advice: [Column<Advice>; 2],
    pub instance: Column<Instance>,
    pub s_mul: Selector,
}

#[derive(Default)]
pub struct SquareCircuit<F: Field> {
    pub a: Value<F>,
    _marker: PhantomData<F>,
}

impl<F: Field> Circuit<F> for SquareCircuit<F> {
    type Config = SquareConfig;
    type FloorPlanner = SimpleFloorPlanner;

    fn without_witnesses(&self) -> Self {
        Self::default()
    }

    fn configure(meta: &mut ConstraintSystem<F>) -> Self::Config {
        let advice = [meta.advice_column(), meta.advice_column()];
        let instance = meta.instance_column();
        let s_mul = meta.selector();

        meta.enable_equality(advice[0]);
        meta.enable_equality(advice[1]);
        meta.enable_equality(instance);

        // Constraint: a * a = b
        meta.create_gate("square", |meta| {
            let lhs = meta.query_advice(advice[0], Rotation::cur());
            let rhs = meta.query_advice(advice[1], Rotation::cur());
            let s_mul = meta.query_selector(s_mul);

            vec![s_mul * (lhs.clone() * lhs - rhs)]
        });

        SquareConfig {
            advice,
            instance,
            s_mul,
        }
    }

    fn synthesize(
        &self,
        config: Self::Config,
        mut layouter: impl Layouter<F>,
    ) -> Result<(), Error> {
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
}

#[cfg(test)]
mod tests {
    use super::*;
    use halo2_proofs::dev::MockProver;

    #[test]
    fn test_square_circuit() {
        let k = 4;
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

    #[test]
    fn test_different_values() {
        let k = 4;
        let a = Fp::from(3);
        let b = a * a; // 9

        let circuit = SquareCircuit {
            a: Value::known(a),
            _marker: PhantomData,
        };

        let public_input = vec![b];
        let prover = MockProver::run(k, &circuit, vec![public_input]).unwrap();
        prover.assert_satisfied();
    }
}
