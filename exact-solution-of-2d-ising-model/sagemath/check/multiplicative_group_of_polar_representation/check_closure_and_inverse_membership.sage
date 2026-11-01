# 対象ラベル: multiplicative_group_of_polar_representation
# 証明の三つの段
#   積で閉じること: r, r' ∈ R_{>=0}, r, r' ≠ 0 ⟹ r > 0, r' > 0 ⟹ rr' > 0 ⟹ rr' ≠ 0、
#                   [(r,θ)]·[(r',θ')] = [(rr', θ+θ')] ≠ [(0,0)]
#   単位元を含むこと: e = [(1,0)] ≠ [(0,0)]
#   逆元をもつこと: [(1/r,-θ)] ∈ (極座標表現)^×（1/r ≠ 0）
# 積の定義の行は、本文の行が定義どおりに写されているかの確認に留まる。
load("../../_shared/polar_representation.sage")

for p in NONZERO:
    assert not polar_equiv(p, ZERO)
    for q in NONZERO:
        a, b = p[0], q[0]
        assert a >= 0 and a != 0 and a > 0 and b > 0
        assert a * b > 0 and a * b != 0
        rep = mul_rep(p, q)
        assert rep == (a * b, p[1] + q[1])
        assert not polar_equiv(rep, ZERO)
    c = (1 / p[0], -p[1])
    assert 1 / p[0] != 0 and not polar_equiv(c, ZERO)
assert QQ(1) != 0 and not polar_equiv(E, ZERO)
# 対照: 半径が零の元を因子にもつ積は [(0,0)] に入る（(極座標表現)^× の外へ出るのは零の因子があるときだけ）
assert polar_equiv(mul_rep(SAMPLE[1], NONZERO[0]), ZERO)
print(f"closure on {len(NONZERO)**2} pairs; e and the {len(NONZERO)} inverses lie in (polar)^x")
print("RESULT: PASS")
