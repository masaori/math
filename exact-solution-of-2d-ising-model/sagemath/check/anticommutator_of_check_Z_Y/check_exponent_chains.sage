# 対象ラベル: anticommutator_of_check_Z_Y
# 準備 2 の二つの鎖を一行ずつ確かめる。
# - 実数の鎖（24 等号）: π・μ・ν・M・j を不定元にした QQ 上の有理関数体で各行を組み、隣と比べる。
#   1/2 は QQ の元。不定元の μ・ν は像 μ_R・ν_R を表すので、ι_{Z→R} を引く 4 行（inclusion_zz_to_rr_of_one・
#   inclusion_zz_to_rr_preserves_sum・inclusion_zz_to_rr_preserves_difference・inclusion_zz_to_rr_preserves_negation）と
#   κ_R を置く行は、不定元の上では同じ元になり比較は中身を持たない。
#   この 5 行は、μ, ν ∈ ℤ を -20..20 で動かし、ι_{Z→R} を定義の再帰（inclusion_zz_to_rr_by_definition.sage）で計算して別に比べる。
#   有理関数体は結合律・交換律で並べ替えた式を同じ元にするので、並べ替えだけの行の比較も中身を持たない。
# - 複素数の鎖（5 等号）: ℂ を本文どおり実数の対で持ち（complex_as_real_pairs.sage）、同じ有理関数体の上で各行を組み、隣と比べる。
#   -1_C は 1_C + w = 0_C の解として作り、-i := (-1_C)i を組むのに使う。
# 対照: θ̃ の定義の 1/2 を落とすと（整数運動量）、実数の鎖の右辺 -(2πjκ/M) と一致しない。
load("../../_shared/complex_as_real_pairs.sage")
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")

F = FractionField(PolynomialRing(QQ, ['pi_', 'mu', 'nu', 'M', 'j']))
pi_, mu, nu, M, j = F.gens()
h = QQ(1) / 2
th = lambda m: 2 * pi_ * (m - h) / M          # antiperiodic_exp_sum の θ̃_m（m の像は不定元のまま）
kappa_R = -(mu + nu - 1)                       # κ_R（不定元の上での ι(-(μ+ν-1))）
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
    j * (2 * pi_ * (-(-(mu + nu - 1))) / M),     # inclusion_zz_to_rr_of_one を右辺から左辺へ（不定元の上では同じ元）
    j * (2 * pi_ * (-(-((mu + nu) - 1))) / M),   # inclusion_zz_to_rr_preserves_sum を右辺から左辺へ（同上）
    j * (2 * pi_ * (-(-((mu + nu) - 1))) / M),   # inclusion_zz_to_rr_preserves_difference を右辺から左辺へ（同上）
    j * (2 * pi_ * (-(-((mu + nu) - 1))) / M),   # inclusion_zz_to_rr_preserves_negation を右辺から左辺へ（同上）
    j * (2 * pi_ * (-kappa_R) / M),
    (j * (2 * pi_ * (-kappa_R))) / M,
    (j * (-(2 * pi_ * kappa_R))) / M,
    (-(j * (2 * pi_ * kappa_R))) / M,
    (-((j * 2 * pi_) * kappa_R)) / M,
    (-((2 * pi_ * j) * kappa_R)) / M,
    -(2 * pi_ * j * kappa_R / M),
]
assert len(real_lines) == 25   # 証明の 24 等号
for t in range(len(real_lines) - 1):
    assert real_lines[t] == real_lines[t + 1], ("real", t)
assert h + h == 1
# 対照: 整数運動量 2πμ/M では右辺と一致しない
assert j * (2 * pi_ * mu / M) + j * (2 * pi_ * nu / M) != -(2 * pi_ * j * kappa_R / M)
print("  real chain: 24 equalities hold in QQ(pi, mu, nu, M, j)")

# ι_{Z→R} を引く 4 行と κ_R を置く行を、整数の μ, ν と定義の再帰の ι で比べる（π・M・j は不定元のまま）。
io = iota_zz_to_rr
Fpm = FractionField(PolynomialRing(QQ, ['pi_', 'M', 'j']))
piP, MP, jP = Fpm.gens()
wrap = lambda X: jP * (2 * piP * (-X) / MP)
cnt_iota = 0
for m_ in range(-20, 21):
    for n_ in range(-20, 21):
        m_, n_ = ZZ(m_), ZZ(n_)
        kap = -(m_ + n_ - 1)                                   # κ := -(μ+ν-1) ∈ ℤ
        iota_lines = [
            wrap(-(io(m_) + io(n_) - QQ(1))),                   # -(-(μ_R+ν_R-1_R))
            wrap(-(io(m_) + io(n_) - io(1))),                   # inclusion_zz_to_rr_of_one を右辺から左辺へ
            wrap(-(io(m_ + n_) - io(1))),                       # inclusion_zz_to_rr_preserves_sum を右辺から左辺へ
            wrap(-io((m_ + n_) - 1)),                           # inclusion_zz_to_rr_preserves_difference を右辺から左辺へ
            wrap(io(-((m_ + n_) - 1))),                         # inclusion_zz_to_rr_preserves_negation を右辺から左辺へ
            wrap(io(kap)),                                      # κ の置き方（κ_R = ι(κ)）
        ]
        for t in range(len(iota_lines) - 1):
            assert iota_lines[t] == iota_lines[t + 1], ("iota", m_, n_, t)
            cnt_iota += 1
# 対照: ι の符号反転の節を取り違えた写像（ι''(n) = |n|）では、符号反転の行が崩れる対がある
iota_wrong = lambda n: QQ(abs(n))
assert any(wrap(-iota_wrong((ZZ(a) + ZZ(b)) - 1)) != wrap(iota_wrong(-((ZZ(a) + ZZ(b)) - 1)))
           for a in range(-3, 4) for b in range(-3, 4))
print(f"  iota lines: {cnt_iota} equalities hold for mu, nu in -20..20")

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
