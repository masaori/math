# 式ペア: 周期の冪等式が強制する指数等式 (1-E_L)(L+p)^3 = (1-E_{L+p})L^3 について、
#         左辺から右辺を引いた式が (L+p)^3 - L^3 + 3 p L^2 (L+p)^2 に等しく（分配法則）、
#         L>0, p>0 のもとで正であること。
# 帰属: ZZ と ZZ[L,p]。有限の多項式計算だけを使う。
load("_prelude.sage")
R = PolynomialRing(ZZ, ["L", "p"])
L, p = R.gens()

left = (ZZ(1) - ZZ(3) * L ** 2 * (L - ZZ(1))) * (L + p) ** 3
right = (ZZ(1) - ZZ(3) * (L + p) ** 2 * (L + p - ZZ(1))) * L ** 3
difference = (L + p) ** 3 - L ** 3 + ZZ(3) * p * L ** 2 * (L + p) ** 2

# 分配法則の段（本文の等号）が多項式の恒等式であること。
assert left - right == difference

# 差の全ての単項式の係数が正であること（L>0, p>0 での正値性はこれで足りる）。
expanded = difference.monomial_coefficients()
assert len(expanded) > 0
for coefficient in expanded.values():
    assert coefficient > 0

# 実際の自由境界の箱の辺数でも、差が正であること。
for box_width in BOX_WIDTHS:
    for period in [ZZ(1), ZZ(2), ZZ(3)]:
        inner = free_edge_count(box_width)
        outer = free_edge_count(box_width + period)
        assert inner == ZZ(3) * box_width ** 2 * (box_width - ZZ(1))
        value = (ZZ(1) - inner) * site_count(box_width + period) - (ZZ(1) - outer) * site_count(box_width)
        assert value == difference(box_width, period)
        assert value > 0
print("RESULT: PASS")
