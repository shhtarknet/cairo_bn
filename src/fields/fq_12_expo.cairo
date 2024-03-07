use bn::curve::U512Fq2OpsTrait;
use core::starknet::secp256_trait::Secp256PointTrait;
use core::traits::TryInto;
use bn::traits::FieldShortcuts;
use bn::traits::FieldMulShortcuts;
use core::array::ArrayTrait;
use bn::curve::{t_naf, FIELD, FIELD_X2};
use bn::curve::{u512, mul_by_xi_nz, mul_by_v, U512BnAdd, U512BnSub, Tuple2Add, Tuple2Sub,};
use bn::curve::{u512_add, u512_sub, u512_high_add, u512_high_sub, U512Fq2Ops};
use bn::fields::{FieldUtils, FieldOps, fq, Fq, Fq2, Fq6, Fq12, fq12, Fq12Frobenius, Fq12Squaring};
use bn::fields::{TFqAdd, TFqSub, TFqMul, TFqDiv, TFqNeg, TFqPartialEq,};
use bn::fields::print::{Fq2Display, FqDisplay, u512Display};

// Sparse Fp12 element containing only c3 and c4 Fq2s (c0 is 1)
// Equivalent to,
// Fq12{
//   c0: Fq6{c0: 1, c1: 0, c2: 0},
//   c1: Fq6{c0: c3, c1: c4, c2: 0},
// }
#[derive(Copy, Drop,)]
struct Fq12Sparse034 {
    c3: Fq2,
    c4: Fq2,
}

// Sparse Fp12 element containing c0, c1, c2, c3 and c4 Fq2s
#[derive(Copy, Drop,)]
struct Fq12Sparse01234 {
    c0: Fq2,
    c1: Fq2,
    c2: Fq2,
    c3: Fq2,
    c4: Fq2,
}

// Computes FQ12 exponentiated by -t = -4965661367192848881 = 0x44e992b44a6909f1
// Function generated by addchain. DO NOT EDIT.
#[inline(always)]
fn addchain_exp_by_neg_t(x: Fq12, field_nz: NonZero<u256>) -> Fq12 {
    internal::revoke_ap_tracking();
    // Inversion computation is derived from the addition chain:
    //
    //      _10     = 2*1
    //      _100    = 2*_10
    //      _1000   = 2*_100
    //      _10000  = 2*_1000
    //      _10001  = 1 + _10000
    //      _10011  = _10 + _10001
    //      _10100  = 1 + _10011
    //      _11001  = _1000 + _10001
    //      _100010 = 2*_10001
    //      _100111 = _10011 + _10100
    //      _101001 = _10 + _100111
    //      i27     = (_100010 << 6 + _100 + _11001) << 7 + _11001
    //      i44     = (i27 << 8 + _101001 + _10) << 6 + _10001
    //      i70     = ((i44 << 8 + _101001) << 6 + _101001) << 10
    //      return    (_100111 + i70) << 6 + _101001 + _1000
    //
    // Operations: 62 squares 17 multiplies
    //
    // Generated by github.com/mmcloughlin/addchain v0.4.0.

    let t3 = x.cyclotomic_sqr(field_nz); // Step 1: t3 = x^0x2
    let t5 = t3.cyclotomic_sqr(field_nz); // Step 2: t5 = x^0x4
    let z = t5.cyclotomic_sqr(field_nz); // Step 3: z = x^0x8
    let t0 = z.cyclotomic_sqr(field_nz); // Step 4: t0 = x^0x10
    let t2 = x * t0; // Step 5: t2 = x^0x11
    let t0 = t3 * t2; // Step 6: t0 = x^0x13
    let t1 = x * t0; // Step 7: t1 = x^0x14
    let t4 = z * t2; // Step 8: t4 = x^0x19
    let t6 = t2.cyclotomic_sqr(field_nz); // Step 9: t6 = x^0x22
    let t1 = t0 * t1; // Step 10: t1 = x^0x27
    let t0 = t3 * t1; // Step 11: t0 = x^0x29
    let t6 = t6.sqr_6_times(field_nz); // Step 17: t6 = x^0x880
    let t5 = t5 * t6; // Step 18: t5 = x^0x884
    let t5 = t4 * t5; // Step 19: t5 = x^0x89d
    let t5 = t5.sqr_7_times(field_nz); // Step 26: t5 = x^0x44e80
    let t4 = t4 * t5; // Step 27: t4 = x^0x44e99
    let t4 = t4.sqr_8_times(field_nz); // Step 35: t4 = x^0x44e9900
    let t4 = t0 * t4; // Step 36: t4 = x^0x44e9929
    let t3 = t3 * t4; // Step 37: t3 = x^0x44e992b
    let t3 = t3.sqr_6_times(field_nz); // Step 43: t3 = x^0x113a64ac0
    let t2 = t2 * t3; // Step 44: t2 = x^0x113a64ad1
    let t2 = t2.sqr_8_times(field_nz); // Step 52: t2 = x^0x113a64ad100
    let t2 = t0 * t2; // Step 53: t2 = x^0x113a64ad129
    let t2 = t2.sqr_6_times(field_nz); // Step 59: t2 = x^0x44e992b44a40
    let t2 = t0 * t2; // Step 60: t2 = x^0x44e992b44a69
    let t2 = t2.sqr_10_times(field_nz); // Step 70: t2 = x^0x113a64ad129a400
    let t1 = t1 * t2; // Step 71: t1 = x^0x113a64ad129a427
    let t1 = t1.sqr_6_times(field_nz); // Step 77: t1 = x^0x44e992b44a6909c0
    let t0 = t0 * t1; // Step 78: t0 = x^0x44e992b44a6909e9
    let z = z * t0; // Step 79: z = x^0x44e992b44a6909f1

    z.conjugate()
}

#[generate_trait]
impl Fq12Expo of PairingUtilsTrait {
    // region sparse

    // Sparse Fp12 element containing only c3 and c4 Fq2s (c0 is 1)
    // Equivalent to,
    // Fq12{
    //   c0: Fq6{c0: 1, c1: 0, c2: 0},
    //   c1: Fq6{c0: c3, c1: c4, c2: 0},
    // }
    // https://github.com/Consensys/gnark/blob/v0.9.1/std/algebra/emulated/fields_bn254/e12_pairing.go#L150
    #[inline(always)]
    fn mul_034_by_034(self: Fq12Sparse034, rhs: Fq12Sparse034) -> Fq12Sparse01234 {
        let field_nz = FIELD.try_into().unwrap();
        let Fq12Sparse034 { c3: c3, c4: c4 } = self;
        let Fq12Sparse034 { c3: d3, c4: d4 } = rhs;
        // x3 = c3 * d3
        let X3 = c3.u_mul(d3);
        // x4 = c4 * d4
        let X4 = c4.u_mul(d4);
        // x04 = c4 + d4
        let x04 = c4 + d4;
        // x03 = c3 + d3
        let x03 = c3 + d3;
        // tmp = c3 + c4
        let tmp = c3.u_add(c4);
        // x34 = d3 + d4
        let x34 = d3.u_add(d4);
        // x34 = x34 * tmp
        let X34 = x34.u_mul(tmp);
        // x34 = x34 - x3
        let X34 = X34 - X3;
        // x34 = x34 - x4
        let X34 = X34 - X4;

        // zC0B0 = ξx4
        // zC0B0 = zC0B0 + 1
        // zC0B1 = x3
        // zC0B2 = x34
        // zC1B0 = x03
        // zC1B1 = x04

        let mut zC0B0: Fq2 = X4.to_fq(field_nz).mul_by_nonresidue();
        zC0B0.c0.c0 = zC0B0.c0.c0 + 1; // POTENTIAL OVERFLOW
        Fq12Sparse01234 {
            c0: zC0B0, c1: X3.to_fq(field_nz), c2: X34.to_fq(field_nz), c3: x03, c4: x04,
        }
    }

    #[inline(always)]
    fn mul_034(self: Fq12, rhs: Fq12Sparse034) -> Fq12 {
        FieldUtils::one()
    }

    fn exp_naf(mut self: Fq12, mut naf: Array<(bool, bool)>, field_nz: NonZero<u256>) -> Fq12 {
        let mut temp_sq = self;
        let mut result = FieldUtils::one();

        loop {
            match naf.pop_front() {
                Option::Some(naf) => {
                    let (naf0, naf1) = naf;

                    if naf0 {
                        if naf1 {
                            result = result * temp_sq;
                        } else {
                            result = result * temp_sq.conjugate();
                        }
                    }

                    temp_sq = temp_sq.cyclotomic_sqr(field_nz);
                },
                Option::None => { break; },
            }
        };
        result
    }

    #[inline(always)]
    fn exp_by_neg_t(self: Fq12, field_nz: NonZero<u256>) -> Fq12 {
        addchain_exp_by_neg_t(self, field_nz)
    }

    // Software Implementation of the Optimal Ate Pairing
    // Page 9, 4.2 Final exponentiation

    #[inline(always)]
    fn final_exponentiation_easy_part(self: Fq12) -> Fq12 {
        // f^(p^6-1) = conjugate(f) · f^(-1)
        // returns cyclotomic Fp12
        let self = self.conjugate() / self;
        // Software Implementation of the Optimal Ate Pairing
        // Page 9, 4.2 Final exponentiation
        // Page 5 - 6, 3.2 Frobenius Operator
        // f^(p^2+1) = f^(p^2) * f = f.frob2() * f
        self.frob2() * self
    }

    fn final_exponentiation(self: Fq12) -> Fq12 {
        let field_nz = FIELD.try_into().unwrap();
        self.final_exponentiation_easy_part().final_exponentiation_hard_part(field_nz)
    }

    // p^4 - p^2 + 1
    // This seems to be the most efficient counting operations performed
    // https://github.com/paritytech/bn/blob/master/src/fields/fq12.rs#L75
    #[inline(always)]
    fn final_exponentiation_hard_part(self: Fq12, field_nz: NonZero<u256>) -> Fq12 {
        internal::revoke_ap_tracking();
        let field_nz = FIELD.try_into().unwrap();

        let a = self.exp_by_neg_t(field_nz);
        let b = a.cyclotomic_sqr(field_nz);
        let c = b.cyclotomic_sqr(field_nz);
        let d = c * b;

        let e = d.exp_by_neg_t(field_nz);
        let f = e.cyclotomic_sqr(field_nz);
        let g = f.exp_by_neg_t(field_nz);
        let h = d.conjugate();
        let i = g.conjugate();

        let j = i * e;
        let k = j * h;
        let l = k * b;
        let m = k * e;
        let n = self * m;

        let o = l.frob1();
        let p = o * n;

        let q = k.frob2();
        let r = q * p;

        let s = self.conjugate();
        let t = s * l;
        let u = t.frob3();
        let v = u * r;

        v
    }
}
