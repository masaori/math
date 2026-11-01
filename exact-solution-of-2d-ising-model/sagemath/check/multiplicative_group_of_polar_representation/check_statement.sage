# 対象ラベル: multiplicative_group_of_polar_representation
# 主張そのもの: (極座標表現)^× は · について群をなす。
# 具体の非零の元の有限集合の上で、積での閉性・結合律・単位元・逆元の存在を類の等号で確かめる。[(0,0)] が逆元を持たないことも。
load("../../_shared/polar_representation.sage")

assert not polar_equiv(E, ZERO)
for p in NONZERO:
    for q in NONZERO:
        assert not polar_equiv(mul_rep(p, q), ZERO)
        for s in NONZERO:
            assert polar_equiv(mul_rep(mul_rep(p, q), s), mul_rep(p, mul_rep(q, s)))
    assert polar_equiv(mul_rep(p, E), p) and polar_equiv(mul_rep(E, p), p)
    inv = [q for q in NONZERO + [(1 / p[0], -p[1])] if polar_equiv(mul_rep(p, q), E) and polar_equiv(mul_rep(q, p), E)]
    assert len(inv) >= 1 and all(not polar_equiv(q, ZERO) for q in inv)
for q in SAMPLE:
    assert not polar_equiv(mul_rep(ZERO, q), E)
print(f"group axioms on {len(NONZERO)} nonzero elements; [(0,0)] has no inverse")
print("RESULT: PASS")
