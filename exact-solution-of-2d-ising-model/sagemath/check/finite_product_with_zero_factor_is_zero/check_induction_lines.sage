# 対象ラベル: finite_product_with_zero_factor_is_zero
# 証明の帰納法の各行:
#   m = 1:            ∏_{j=1}^{1} z_j = z_1 = 0
#   n = m+1 のとき:   ∏_{j=1}^{m+1} z_j = (∏_{j=1}^{m} z_j) z_{m+1} = (∏_{j=1}^{m} z_j)·0 = 0
#   n ≤ m のとき:     ∏_{j=1}^{m+1} z_j = (∏_{j=1}^{m} z_j) z_{m+1} = 0·z_{m+1} = 0
# z_1,…,z_{m+1} を QQ 上の多項式環の不定元に置き、z_n だけを 0 に代入する。有限積は
# def_finite_product_of_complex_numbers の帰納法どおり左から掛け、Sage の prod とも比べる。
# 不定元の多項式の等号は厳密に決まり、任意の複素数を代入しても保たれる。帰属: QQ[z_1,…]。m = 1,…,8。
def left_to_right_product(zs):
    acc = zs[0]
    for z in zs[1:]:
        acc = acc * z
    return acc

count = 0
# m = 1
R = PolynomialRing(QQ, "z", 1)
z = list(R.gens())
zs = [R(0)]                                  # n = 1、z_1 = 0
assert left_to_right_product(zs) == zs[0] == 0
count += 1
for m in range(1, 8):
    R = PolynomialRing(QQ, "z", m + 1)
    z = list(R.gens())
    for n in range(1, m + 2):
        zs = [R(0) if j == n else z[j - 1] for j in range(1, m + 2)]
        line1 = left_to_right_product(zs)
        line2 = left_to_right_product(zs[:m]) * zs[m]
        assert line1 == line2 == prod(zs)
        if n == m + 1:
            line3 = left_to_right_product(zs[:m]) * 0
        else:
            assert left_to_right_product(zs[:m]) == 0         # 帰納法の仮定（m 個の積）
            line3 = 0 * zs[m]
        assert line2 == line3 == 0
        count += 1
# 対照: 0 の因子が無ければ積は 0 でない
R = PolynomialRing(QQ, "z", 4)
assert left_to_right_product(list(R.gens())) != 0
print(f"checked {count} (m, n) cases")
print("RESULT: PASS")
