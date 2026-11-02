# 対象ラベル: sinh_at_least_argument
# 証明の鎖の各行を確かめる。
# 帰属:
# - 積分の値の行（(R4) の当てはめ。2・4 行目）は、SR の記号積分で ∫_0^t 1 du = t - 0、∫_0^t cosh u du = sinh t - sinh 0 を
#   記号のまま比べ、あわせて (R4) に渡す導関数（u ↦ u の導関数 1、sinh' = cosh）を
#   QQ[u] の形式冪級数の項ごとの微分で確かめる（本文の sinh・cosh は部分和の極限なので）。
# - 不等号の行（(R3) の単調性）は、t > 0 の 6 点で、被積分関数の各点の大小を [0,t] の 40 等分点で本文の exp のボールで確かめ、
#   鎖の両端をボールで比べる（RealBallField(512)。値が QQ に収まらないため）。
# - t = 0 の場合と sinh 0 = 0 の行は、ボールが 0 を含むこと（QQ での厳密な確認は sinh_zero の検算）。
load("../../_shared/hyperbolic_by_definition.sage")
WHICH = "least"
uu, tt = SR.var('uu tt')
assert bool(integrate(1, uu, 0, tt) == tt - 0)                        # 2 行目
assert bool(integrate(cosh(uu), uu, 0, tt) == sinh(tt) - sinh(0))     # 4 行目
P.<u> = PolynomialRing(QQ)
T = lambda p, d: truncate_total_degree(p, d)
assert u.derivative(u) == 1
assert T(sinh_series(P, u).derivative(u), D_SERIES - 1) == T(cosh_series(P, u), D_SERIES - 1)
print("積分の値の二つの行が SR で、(R4) に渡す導関数が QQ[u] の形式冪級数で成り立つ")
assert sinh_ball(0).contains_exact(0)
points = [QQ(0), QQ(1)/10^6, QQ(1)/4, QQ(1)/2, QQ(1), QQ(3), QQ(20)]
for t0 in points:
    st, ct = sinh_ball(t0), cosh_ball(t0)
    if t0 == 0:
        assert st.contains_exact(0)
        continue
    grid = [t0 * k / 40 for k in range(41)]
    if WHICH == "least":
        assert all(cosh_ball(g) >= 1 or cosh_ball(g).contains_exact(1) for g in grid)     # 1 ≤ cosh u
        assert RBF512(t0) < st                                                                # t ≤ sinh t（t > 0 では狭義）
    else:
        assert all(cosh_ball(g) <= ct or cosh_ball(g).overlaps(ct) for g in grid)          # cosh u ≤ cosh t
        assert st < t0 * ct                                                                   # sinh t ≤ t cosh t（t > 0 では狭義）
if WHICH == "least":
    assert not (RBF512(-1) <= sinh_ball(-1))      # 対照: t < 0 では t ≤ sinh t が成り立たない
else:
    assert not (sinh_ball(-1) <= -1 * cosh_ball(-1))   # 対照: t < 0 では sinh t ≤ t cosh t が成り立たない
print(f"t = 0 と t > 0 の {len(points) - 1} 点で被積分関数の各点の大小と鎖の両端の大小がボールで成り立ち、t = -1 では成り立たない（対照）")
print("RESULT: PASS")
