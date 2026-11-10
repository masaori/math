# 対象ラベル: anticommutator_of_check_Z_Y
# 準備 2 の二つの鎖を一行ずつ確かめる。
# - 実数の鎖（20 等号）: π・μ・ν・M・j を不定元にした QQ 上の有理関数体で各行を組み、隣と比べる。
#   1/2 は QQ の元、κ_R = -(μ_R + ν_R - 1_R) は ι_{Z→R} が和・零・単位元を保つことによる像の式。
#   κ_R をこの式で作るので、κ_R を置く行（-(-(μ+ν-1)) = -κ_R）の比較は作り方で自明である。
#   有理関数体は結合律・交換律で並べ替えた式を同じ元にするので、並べ替えだけの行の比較も中身を持たない。
# - 複素数の鎖（5 等号）: ℂ を本文どおり実数の対で持ち（complex_as_real_pairs.sage）、同じ有理関数体の上で各行を組み、隣と比べる。
#   -1_C は 1_C + w = 0_C の解として作り、-i := (-1_C)i を組むのに使う。
# 対照: θ̃ の定義の 1/2 を落とすと（整数運動量）、実数の鎖の右辺 -(2πjκ/M) と一致しない。
load("../../_shared/complex_as_real_pairs.sage")

F = FractionField(PolynomialRing(QQ, ['pi_', 'mu', 'nu', 'M', 'j']))
pi_, mu, nu, M, j = F.gens()
h = QQ(1) / 2
th = lambda m: 2 * pi_ * (m - h) / M          # antiperiodic_exp_sum の θ̃_m（m の像は不定元のまま）
kappa_R = -(mu + nu - 1)                       # κ_R（ι_{Z→R} は和・零・単位元を保つ）
y = 2 * pi_ * j * kappa_R / M                  # y_j

real_lines = [
    j * th(mu) + j * th(nu),
    j * (th(mu) + th(nu)),
    j * (2 * pi_ * (mu - h) / M + 2 * pi_ * (nu - h) / M),
    j * ((2 * pi_ * (mu - h) + 2 * pi_ * (nu - h)) / M),
    j * (2 * pi_ * ((mu - h) + (nu - h)) / M),
    j * (2 * pi_ * ((mu + (-h)) + (nu + (-h))) / M),
    j * (2 * pi_ * (mu + ((-h) + (nu + (-h)))) / M),
    j * (2 * pi_ * (mu + ((nu + (-h)) + (-h))) / M),
    j * (2 * pi_ * (mu + (nu + ((-h) + (-h)))) / M),
    j * (2 * pi_ * ((mu + nu) + ((-h) + (-h))) / M),
    j * (2 * pi_ * ((mu + nu) + (-(h + h))) / M),
    j * (2 * pi_ * ((mu + nu) + (-1)) / M),
    j * (2 * pi_ * (mu + nu - 1) / M),
    j * (2 * pi_ * (-(-(mu + nu - 1))) / M),
    j * (2 * pi_ * (-kappa_R) / M),
    (j * (2 * pi_ * (-kappa_R))) / M,
    (j * (-(2 * pi_ * kappa_R))) / M,
    (-(j * (2 * pi_ * kappa_R))) / M,
    (-((j * 2 * pi_) * kappa_R)) / M,
    (-((2 * pi_ * j) * kappa_R)) / M,
    -(2 * pi_ * j * kappa_R / M),
]
assert len(real_lines) == 21   # 証明の 20 等号
for t in range(len(real_lines) - 1):
    assert real_lines[t] == real_lines[t + 1], ("real", t)
assert h + h == 1
# 対照: 整数運動量 2πμ/M では右辺と一致しない
assert j * (2 * pi_ * mu / M) + j * (2 * pi_ * nu / M) != -(2 * pi_ * j * kappa_R / M)
print("  real chain: 20 equalities hold in QQ(pi, mu, nu, M, j)")

iF = (F(0), F(1))
oneF = iota(1, F)
# -1_C を 1_C + w = 0_C の解 w = (w0, w1) として作る（実部・虚部の一次方程式 1 + w0 = 0、0 + w1 = 0）
minus_one = (F(-1) - F(0), F(0) - F(0))
assert cc_add(oneF, minus_one) == (F(0), F(0))
assert minus_one == iota(-1, F)                 # cc_neg が使う (-1_R)_C と同じ -1_C であること
minus_i = cc_mul(minus_one, iF)                 # multiply_by_minus_one: -i := (-1_C)i
xm, xn = j * th(mu), j * th(nu)
cx_lines = [
    cc_add(cc_mul(minus_i, iota(xm, F)), cc_mul(minus_i, iota(xn, F))),
    cc_mul(minus_i, cc_add(iota(xm, F), iota(xn, F))),
    cc_mul(minus_i, iota(xm + xn, F)),
    cc_mul(minus_i, iota(-y, F)),
    cc_neg(cc_mul(iF, iota(-y, F)), F),           # negative_i_times_complex_is_negation_of_i_times（z → (-y_j)_C）
    cc_mul(iF, iota(y, F)),
]
assert len(cx_lines) == 6    # 証明の 5 等号
for t in range(len(cx_lines) - 1):
    assert cx_lines[t] == cx_lines[t + 1], ("complex", t)
# 対照: 符号を落とした (-i)(y_j)_C は i(y_j)_C と違う
assert cc_mul(minus_i, iota(y, F)) != cx_lines[-1]
print("  complex chain: 5 equalities hold on real pairs over QQ(pi, mu, nu, M, j)")
print("RESULT: PASS")
