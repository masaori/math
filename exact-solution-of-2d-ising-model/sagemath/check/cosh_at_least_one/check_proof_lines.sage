# 対象ラベル: cosh_at_least_one
# 証明の鎖 cosh x = 1 + 2 sinh²(x/2) ≥ 1 + 2·0 = 1、不等号の根拠の含意の鎖（平方 ≥ 0 ⇒ 2 倍 ≥ 0 ⇒ 1 を足す）、主張 cosh x ≥ 1 を確かめる。
# 帰属: 1 行目（cosh_half_angle_formula）は QQ[x] の形式冪級数として全次数 14 以下で、
#   2 行目の不等号と主張は x の 9 点で本文の exp のボール（RealBallField(512)）で、3 行目は QQ で。
load("../../_shared/hyperbolic_by_definition.sage")
P = PolynomialRing(QQ, 'x'); x = P.gen()
T = lambda p: truncate_total_degree(p, D_SERIES)
assert cosh_series(P, x) == T(1 + 2 * sinh_series(P, x / 2)^2)
assert 1 + 2 * 0 == 1
points = [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(10), QQ(-25), QQ(1)/10^6, QQ(-1)/10^9, QQ(40)]
for x0 in points:
    sq = sinh_ball(x0 / 2)^2
    assert sq >= 0 or sq.contains_exact(0)
    c = cosh_ball(x0)
    assert c.overlaps(1 + 2 * sq)
    assert c >= 1 or c.contains_exact(1)
    if x0 != 0:
        assert c > 1
    assert 2 * sq >= 0 or (2 * sq).contains_exact(0)            # 含意の 1 行目
    assert 1 + 2 * sq >= 1 or (1 + 2 * sq).contains_exact(1)    # 含意の 2 行目
print(f"1 行目が形式冪級数で、2 行目と主張が {len(points)} 点のボールで成り立つ（x ≠ 0 では cosh x > 1）")
print("RESULT: PASS")
