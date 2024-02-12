// These paramas from:
// https://hackmd.io/@jpw/bn254

const X: u64 = 4965661367192848881;
const ORDER: u256 = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

// 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
const FIELD: u256 = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

// 0x4689e957a1242c84a50189c6d96cadca602072d09eac1013b5458a2275d69b1
const FIELDSQLOW: u256 =
    1994097994880475507519040458855034912025718176994801861240415525295080958385;

// 0x925c4b8763cbf9c599a6f7c0348d21cb00b85511637560626edfa5c34c6b38d
const FIELDSQHIGH: u256 =
    4137546694012196313615514819619774299549115026185221663042307357682442875789;

const B: u256 = 3;

const ATE_LOOP_COUNT: u128 = 29793968203157093288;
const LOG_ATE_LOOP_COUNT: u128 = 63;

#[inline(always)]
fn x_naf() -> Array<(bool, bool)> {
    // https://codegolf.stackexchange.com/questions/235319/convert-to-a-non-adjacent-form#answer-235327
    // JS function, f=n=>n?f(n+n%4n/3n>>1n)+'OPON'[n%4n]:''
    // When run with X, f(4965661367192848881n)
    // returns POOOPOPOONOPOPONOOPOPONONONOPOOOPOOPOPOPONOPOOPOOOOPOPOOOONOOOP
    // Reverse and output tt for P and tf for N,
    // f(4965661367192848881n).split('').reverse().join(',');
    let O = (false, false);
    let P = (true, true);
    let N = (true, false);
    array![
        P,
        O,
        O,
        O,
        N,
        O,
        O,
        O,
        O,
        P,
        O,
        P,
        O,
        O,
        O,
        O,
        P,
        O,
        O,
        P,
        O,
        N,
        O,
        P,
        O,
        P,
        O,
        P,
        O,
        O,
        P,
        O,
        O,
        O,
        P,
        O,
        N,
        O,
        N,
        O,
        N,
        O,
        P,
        O,
        P,
        O,
        O,
        N,
        O,
        P,
        O,
        P,
        O,
        N,
        O,
        O,
        P,
        O,
        P,
        O,
        O,
        O,
        P,
    ]
}

#[inline(always)]
fn six_u_plus_2_naf() -> Array<(bool, bool)> {
    // sixuPlus2NAF is 6u+2 in non-adjacent form.
    let O = (false, false);
    let P = (true, true);
    let N = (true, false);
    array![
        O,
        O,
        O,
        P,
        O,
        P,
        O,
        N,
        O,
        O,
        P,
        N,
        O,
        O,
        P,
        O,
        O,
        P,
        P,
        O,
        N,
        O,
        O,
        P,
        O,
        N,
        O,
        O,
        O,
        O,
        P,
        P,
        P,
        O,
        O,
        N,
        O,
        O,
        P,
        O,
        O,
        O,
        O,
        O,
        N,
        O,
        O,
        P,
        P,
        O,
        O,
        N,
        O,
        O,
        O,
        P,
        P,
        O,
        N,
        O,
        O,
        P,
        O,
        P,
        P
    ]
}