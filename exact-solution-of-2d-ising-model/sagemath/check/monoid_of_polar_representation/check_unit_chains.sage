# 対象ラベル: monoid_of_polar_representation
# 単位元の二つの鎖
#   [(r,θ)]·e = [(r,θ)]·[(1,0)] = [(r·1, θ+0)] = [(r, θ+0)] = [(r,θ)]
#   e·[(r,θ)] = [(1,0)]·[(r,θ)] = [(1·r, 0+θ)] = [(r, 0+θ)] = [(r,θ)]
# (一般の点) 変わる成分が多項式として等しいこと。(具体の点) 各行を成分から別々に組み立て、定義の行は代表元の積と一致すること。
load("../../_shared/polar_representation.sage")

assert r * 1 == r and th + 0 == th and 1 * r == r and 0 + th == th
assert is_pair(E)                                       # e ∈ (極座標表現)（1 ∈ R_{>=0}）
for p in SAMPLE:
    a, t = p
    # [(r,θ)]·e
    factors = (p, (AA(1), Ang(0)))                       # e の定め方: e = [(1,0)]
    assert factors[1] == E
    rows = [(a * 1, t + 0), (a, t + 0), (a, t)]
    assert mul_rep(*factors) == rows[0]                   # 積の定義
    assert rows[0][1] == rows[1][1] and rows[0][0] == rows[1][0]
    assert rows[1][0] == rows[2][0] and rows[1][1] == rows[2][1]
    assert polar_equiv(rows[2], p)
    # e·[(r,θ)]
    factors = ((AA(1), Ang(0)), p)
    assert factors[0] == E
    rows = [(1 * a, 0 + t), (a, 0 + t), (a, t)]
    assert mul_rep(*factors) == rows[0]
    assert rows[0][1] == rows[1][1] and rows[0][0] == rows[1][0]
    assert rows[1][0] == rows[2][0] and rows[1][1] == rows[2][1]
    assert polar_equiv(rows[2], p)
# 対照: [(1,π)] は単位元でない
assert not polar_equiv(mul_rep(NONZERO[1], (AA(1), pi_)), NONZERO[1])
print(f"unit chains as polynomial identities and on {len(SAMPLE)} elements")
print("RESULT: PASS")
