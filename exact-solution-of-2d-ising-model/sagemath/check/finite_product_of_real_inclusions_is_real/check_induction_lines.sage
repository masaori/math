# 対象ラベル: finite_product_of_real_inclusions_is_real
# 証明の帰納法の各行:
#   m = 1:   ∏_{j=1}^{1} z_j = z_1 = (r_1)_C
#   m → m+1: ∏_{j=1}^{m+1} z_j = (∏_{j=1}^{m} z_j) z_{m+1} = s_C z_{m+1} = s_C (r_{m+1})_C = (s r_{m+1})_C
# ℂ を実数の対として持ち（definition_of_cc）、r_j を QQ 上の多項式環の不定元に置く（任意の実数を代入しても等号は保たれる）。
# 有限積は def_finite_product_of_complex_numbers の帰納法どおり左から掛ける。帰属: QQ[r_1, …, r_m]。m = 1..8。
def incl(r, R):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (R(r), R(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def left_to_right_product(zs):
    acc = zs[0]
    for z in zs[1:]:
        acc = pair_mul(acc, z)
    return acc

M = 8
R = PolynomialRing(QQ, ['r%d' % j for j in range(1, M + 2)])
r = R.gens()
z = [incl(r[j], R) for j in range(M + 1)]
# m = 1 の行
assert left_to_right_product(z[:1]) == z[0] == incl(r[0], R)
count = 1
for m in range(1, M):
    s = prod(r[:m])                                  # 帰納法の仮定で取る s（s_C = ∏_{j≤m} z_j）
    assert left_to_right_product(z[:m]) == incl(s, R)
    line1 = left_to_right_product(z[:m + 1])
    line2 = pair_mul(left_to_right_product(z[:m]), z[m])
    line3 = pair_mul(incl(s, R), z[m])
    line4 = pair_mul(incl(s, R), incl(r[m], R))
    line5 = incl(s * r[m], R)
    assert line1 == line2 == line3 == line4 == line5
    count += 1
# 対照: 虚部が 0 でない因子を一つ含むと、積は実数の包含にならない
w = left_to_right_product([z[0], (R(0), R(1)), (R(0), R(1))])
assert w == (-r[0], R(0))             # i·i = -1 なので実数に戻る（i が偶数個）
w3 = left_to_right_product([z[0], (R(0), R(1))])
assert w3[1] != 0                     # i が 1 個なら虚部が残る
print(f"checked m = 1..{count} with indeterminates r_1..r_{count}")
print("RESULT: PASS")
