// test bn::fields::tests::bench::fq01::add ... ok (gas usage est.: 12360)
// test bn::fields::tests::bench::fq01::div ... ok (gas usage est.: 86000)
// test bn::fields::tests::bench::fq01::mul ... ok (gas usage est.: 52130)
// test bn::fields::tests::bench::fq01::sqr ... ok (gas usage est.: 47900)
// test bn::fields::tests::bench::fq01::sub ... ok (gas usage est.: 15710)
// test bn::fields::tests::bench::fq02::add ... ok (gas usage est.: 24420)
// test bn::fields::tests::bench::fq02::div ... ok (gas usage est.: 419640)
// test bn::fields::tests::bench::fq02::mul ... ok (gas usage est.: 155690)
// test bn::fields::tests::bench::fq02::sqr ... ok (gas usage est.: 121190)
// test bn::fields::tests::bench::fq02::sub ... ok (gas usage est.: 31420)
// test bn::fields::tests::bench::fq06::add ... ok (gas usage est.: 72660)
// test bn::fields::tests::bench::fq06::div ... ok (gas usage est.: 3865380)
// test bn::fields::tests::bench::fq06::mul ... ok (gas usage est.: 1376360)
// test bn::fields::tests::bench::fq06::sqr ... ok (gas usage est.: 1150210)
// test bn::fields::tests::bench::fq06::sub ... ok (gas usage est.: 94260)
// test bn::fields::tests::bench::fq12::add ... ok (gas usage est.: 145020)
// test bn::fields::tests::bench::fq12::div ... ok (gas usage est.: 12497840)
// test bn::fields::tests::bench::fq12::mul ... ok (gas usage est.: 4653310)
// test bn::fields::tests::bench::fq12::sqr ... ok (gas usage est.: 3374880)
// test bn::fields::tests::bench::fq12::sub ... ok (gas usage est.: 188520)

use bn::math::fast_mod as m;
use debug::PrintTrait;

mod fq01 {
    use bn::traits::{FieldOps, FieldShortcuts,};
    use bn::fields::{fq, Fq};
    use debug::PrintTrait;
    #[test]
    #[available_gas(2000000)]
    fn add() {
        let a = fq(645);
        let b = fq(45);
        a + b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sub() {
        let a = fq(645);
        let b = fq(45);
        a - b;
    }

    #[test]
    #[available_gas(2000000)]
    fn mul() {
        let a = fq(645);
        let b = fq(45);
        a * b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sqr() {
        let a = fq(645);
        a.sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn div() {
        let a = fq(645);
        let b = fq(45);
        a / b;
    }
}

mod fq02 {
    use bn::traits::{FieldOps, FieldShortcuts,};
    use bn::fields::{fq2, Fq2};
    use debug::PrintTrait;
    #[test]
    #[available_gas(2000000)]
    fn add() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a + b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sub() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a - b;
    }

    #[test]
    #[available_gas(2000000)]
    fn mul() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a * b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sqr() {
        let a = fq2(34, 645);
        a.sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn div() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a / b;
    }
}

mod fq06 {
    use bn::traits::{FieldOps, FieldShortcuts,};
    use bn::fields::{fq6, Fq6};
    use debug::PrintTrait;
    use bn::fields::fq_generics::{TFqAdd, TFqSub, TFqMul, TFqDiv, TFqNeg, TFqPartialEq,};
    #[test]
    #[available_gas(20000000)]
    fn add() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a + b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sub() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a - b;
    }

    #[test]
    #[available_gas(20000000)]
    fn mul() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a * b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sqr() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        a.sqr();
    }

    #[test]
    #[available_gas(20000000)]
    fn div() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a / b;
    }
}

mod fq12 {
    use bn::traits::{FieldOps, FieldShortcuts,};
    use bn::fields::{fq12, fq6, Fq12};
    use debug::PrintTrait;
    use bn::fields::fq_generics::{TFqAdd, TFqSub, TFqMul, TFqDiv, TFqNeg, TFqPartialEq,};
    #[test]
    #[available_gas(20000000)]
    fn add() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a + b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sub() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a - b;
    }

    #[test]
    #[available_gas(20000000)]
    fn mul() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a * b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sqr() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        a.sqr();
    }

    #[test]
    #[available_gas(30000000)]
    fn div() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a / b;
    }
}
