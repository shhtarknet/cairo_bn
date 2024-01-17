use bn::fields::{Fq, Fq2, fq2};

// Twisted BN curve
// E'/Fq2 : y^2 = x^3 + b/xi

#[derive(Copy, Drop)]
struct AffineG2 {
    x: Fq2,
    y: Fq2
}


fn pt(x1: u256, x2: u256, y1: u256, y2: u256) -> AffineG2 {
    AffineG2 { x: fq2(x1, x2), y: fq2(y1, y2) }
}


#[inline(always)]
fn one() -> AffineG2 {
    pt(
        10857046999023057135944570762232829481370756359578518086990519993285655852781,
        11559732032986387107991004021392285783925812861821192530917403151452391805634,
        8495653923123431417604973247489272438418190587263600148770280649306958101930,
        4082367875863433681332203403145435568316851327593401208105741076214120093531
    )
}
