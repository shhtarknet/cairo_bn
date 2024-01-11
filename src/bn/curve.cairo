use cairo_ec::traits::{ECOperations};
use cairo_ec::fast_mod::{add, sub, div, mul, add_inverse};

type Fq = u256;
type Fq2 = (Fq, Fq);

#[derive(Copy, Drop)]
struct AffineG1 {
    x: Fq,
    y: Fq
}

#[derive(Copy, Drop)]
struct AffineG2 {
    x: Fq2,
    y: Fq2
}

fn aff_pt(x: Fq, y: Fq) -> AffineG1 {
    AffineG1 { x, y }
}

#[derive(Copy, Drop)]
struct BNCurve {
    field: u256,
    b: u256,
}

const FIELD: u256 = 21888242871839275222246405745257275088696311157297823662689037894645226208583;
const B: u256 = 3;

fn bn254() -> BNCurve {
    BNCurve { field: FIELD, b: B }
// fq2_Modulus_coeffs: (1, 0),
// fq12_Modulus_coeffs: (82, 0, 0, 0, 0, 0, -18, 0, 0, 0, 0, 0),  // Implied + [1]

}

impl AffineG1Ops of ECOperations<AffineG1> {
    fn add(self: AffineG1, rhs: AffineG1) -> AffineG1 {
        let AffineG1{x: x1, y: y1 } = self;
        let AffineG1{x: x2, y: y2 } = rhs;

        // λ = (y2 - y1) / (x2 - x1)
        let lambda = div(sub(y2, y1, FIELD), sub(x2, x1, FIELD), FIELD);

        // v = y - λx
        let v = sub(y1, mul(lambda, x1, FIELD), FIELD);

        // x = λλ - x1 - x2
        let x = sub(sub(mul(lambda, lambda, FIELD), x1, FIELD), x2, FIELD);
        // y = - λx - v
        let y = sub(add_inverse(mul(lambda, x, FIELD), FIELD), v, FIELD);
        AffineG1 { x, y }
    }

    fn double(self: AffineG1) -> AffineG1 {
        let AffineG1{x, y } = self;

        // λ = (3x^2 + a) / 2y
        // let lambda = div(
        //     add(mul(3, mul(x, x, FIELD), FIELD), a, FIELD),
        //     mul(2, y, FIELD),
        //     FIELD
        // );
        // But BN curve has a == 0 so that's one less addition
        // λ = 3x^2 / 2y
        let x_2 = mul(x, x, FIELD);
        let lambda = div( //
            (x_2 + x_2 + x_2) % FIELD, // Numerator
             y + y % FIELD, // Denominator
             FIELD
        );

        // v = y - λx
        let v = sub(y, mul(lambda, x, FIELD), FIELD);

        // New point
        // x = λλ - x1 - x2
        let x = sub(sub(mul(lambda, lambda, FIELD), x, FIELD), x, FIELD);
        // y = - λx - v
        let y = sub(add_inverse(mul(lambda, x, FIELD), FIELD), v, FIELD);
        AffineG1 { x, y }
    }

    fn scalar_mul(self: AffineG1, multiplier: u256) -> AffineG1 {
        AffineG1 { x: 0, y: 0 }
    }
}
// bn254_tests::test_double ... ok (gas usage est.: 537470)
// bn254_tests::test_add ... ok (gas usage est.: 364780)


