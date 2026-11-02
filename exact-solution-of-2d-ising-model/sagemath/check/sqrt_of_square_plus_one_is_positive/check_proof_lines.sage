# 対象ラベル: sqrt_of_square_plus_one_is_positive
# 鎖 y²+1 ≥ 0+1 = 1 > 0、s := √(y²+1) の s ≥ 0・s² = y²+1、背理法の鎖 s = 0 ⇒ s² = 0 ⇒ y²+1 = 0、主張 √(y²+1) > 0 を確かめる。
# 帰属: y の 9 点（±10^6、±10^{-6} を含む）で、s を AA（実代数的数）の √(y²+1) として厳密に。
#   背理法の鎖は、同じ 9 点で 0² = 0 ≠ y²+1 を確かめ、あわせて y²+1 が実数の根を持たないこと（QQ[y] の多項式の AA での根）を確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
points = [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(10)^6, QQ(-10)^6, QQ(1)/10^6, QQ(-1)/10^6, QQ(-12345)/7]
for y0 in points:
    assert y0^2 >= 0 and y0^2 + 1 >= 0 + 1 and 0 + 1 == 1 and 1 > 0
    s0 = AA(y0^2 + 1).sqrt()
    assert s0 >= 0 and s0^2 == y0^2 + 1
    assert s0 != 0 and s0 > 0
    assert AA(0)^2 == 0 and AA(0)^2 != y0^2 + 1        # s = 0 なら s² = 0 ≠ y²+1
print(f"{len(points)} 点で鎖・s ≥ 0・s² = y²+1・背理法の鎖・主張が AA で厳密に成り立つ")
Py.<y> = PolynomialRing(QQ)
assert (y^2 + 1).roots(AA) == []          # y²+1 = 0 は実数解を持たない（背理法の結論の別の確かめ）
print("y²+1 は実数の根を持たない")
print("RESULT: PASS")
