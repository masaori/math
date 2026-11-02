# 対象ラベル: cosh_monotone_on_nonnegative
# 準備（a := (t+u)/2、b := (t-u)/2 で a+b = t、a-b = u、a, b ≥ 0、c ≥ 0 なら sinh c ≥ 0）、
# 鎖 cosh t - cosh u = cosh(a+b) - cosh(a-b) = (cosh a cosh b + sinh a sinh b) - (cosh a cosh b - sinh a sinh b)
#   = 2 sinh a sinh b ≥ 0 と、帰結 cosh u ≤ cosh t を確かめる。
# 帰属: a+b = t、a-b = u は QQ[t,u] で。2 行目（cosh_addition_formula）は QQ[a,b] の形式冪級数として全次数 14 以下で。
#   3 行目は cosh a, cosh b, sinh a, sinh b を QQ 上の独立な不定元に置いて。不等号の行と帰結は 0 ≤ u ≤ t の 8 組の点で
#   本文の exp のボール（RealBallField(512)）で。
load("../../_shared/hyperbolic_by_definition.sage")
Ptu.<t, u> = PolynomialRing(QQ)
a_, b_ = (t + u) / 2, (t - u) / 2
assert a_ + b_ == t and a_ - b_ == u
Pab.<a, b> = PolynomialRing(QQ)
T = lambda p: truncate_total_degree(p, D_SERIES)
l1 = cosh_series(Pab, a + b) - cosh_series(Pab, a - b)
l2 = T((cosh_series(Pab, a) * cosh_series(Pab, b) + sinh_series(Pab, a) * sinh_series(Pab, b))
       - (cosh_series(Pab, a) * cosh_series(Pab, b) - sinh_series(Pab, a) * sinh_series(Pab, b)))
assert l1 == l2
R.<Ca, Cb, Sa, Sb> = PolynomialRing(QQ)
assert (Ca * Cb + Sa * Sb) - (Ca * Cb - Sa * Sb) == 2 * Sa * Sb
print(f"準備の等号、2 行目（形式冪級数の全次数 {D_SERIES} 以下）、3 行目（不定元）が厳密に成り立つ")
assert sinh_ball(0).contains_exact(0)
for c0 in [QQ(1)/10^9, QQ(1)/3, QQ(2), QQ(30)]:
    assert sinh_ball(c0) > 0
pts = [(QQ(0), QQ(0)), (QQ(0), QQ(1)), (QQ(1)/2, QQ(1)/2), (QQ(1)/10^6, QQ(2)/10^6), (QQ(1), QQ(3)), (QQ(5), QQ(20)), (QQ(1)/4, QQ(1)/2), (QQ(7), QQ(7) + QQ(1)/10^9)]
for u0, t0 in pts:
    assert 0 <= u0 <= t0
    A, B = (t0 + u0) / 2, (t0 - u0) / 2
    assert A >= 0 and B >= 0
    diff_ = cosh_ball(t0) - cosh_ball(u0)
    assert diff_.overlaps(2 * sinh_ball(A) * sinh_ball(B))
    pa, pb = sinh_ball(A), sinh_ball(B)
    assert all(v >= 0 or v.contains_exact(0) for v in (pa, pb, pa * pb, 2 * pa * pb))   # 含意の鎖の三行
    assert cosh_ball(u0) <= cosh_ball(t0) or cosh_ball(u0).overlaps(cosh_ball(t0))
    if u0 < t0:
        assert cosh_ball(u0) < cosh_ball(t0)
assert not (cosh_ball(-2) <= cosh_ball(1))    # 対照: 0 ≤ u を外すと成り立たない
print(f"0 ≤ u ≤ t の {len(pts)} 組で不等号の行と帰結が成り立ち、u = -2, t = 1 では成り立たない（対照）")
print("RESULT: PASS")
