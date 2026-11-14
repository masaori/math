# 対象ラベル: eigenvector_of_A_theta_tilde（Step 1 の det(A(θ) − λI) の鎖の
# (λ^2 − (2_ℂg_1)λ) + (g_1^2 + ab) から (λ^2 − (2_ℂg_1)λ) + (g_1^2 − (r_ℂ)^2) までの 8 個の式・7 行）。
# ℂ 側は QQ(i) 上の多項式環 K[λ, g1, a, b, r] を relation_of_gamma_2_theta_tilde (2) の ab = (−r^2)_ℂ
# （ab + r^2 = 0）で割った商環、ℝ 側は QQ 上の多項式環 QQ[s]（s が実数 r）とし、包含 ι_{ℝ→ℂ} を
# s ↦ r の環準同型で表す。浮動小数点は使わない。
K = QuadraticField(-1, 'i')
P.<lam, g1, a, b, r> = PolynomialRing(K)
I = P.ideal(a*b + r**2)
R = P.quotient(I)
lam_, g1_, a_, b_, r_ = [R(v) for v in (lam, g1, a, b, r)]
S.<s> = PolynomialRing(QQ)
iota = S.hom([r_], R)           # ι_{ℝ→ℂ}: s ↦ r_ℂ
m1 = R(-1)                      # −1_ℂ
T = (R(2)*g1_)*lam_
H = lam_**2 - T                 # λ^2 − (2_ℂ g_1)λ

rows = [
    ("H + (g1² + ab)",              H + (g1_**2 + a_*b_)),
    ("H + (g1² + (−s²)_ℂ)",         H + (g1_**2 + iota(-(s**2)))),          # relation (2)
    ("H + (g1² + ((−1)s²)_ℂ)",      H + (g1_**2 + iota((-1)*s**2))),        # ℝ で (−1)x = −x（右→左）
    ("H + (g1² + (−1)_ℂ(s²)_ℂ)",    H + (g1_**2 + iota(S(-1))*iota(s**2))), # real_inclusion_preserves_product（右→左）
    ("H + (g1² + (−1_ℂ)(s²)_ℂ)",    H + (g1_**2 + m1*iota(s**2))),          # inclusion_rr_to_cc の −1_ℂ = (−1)_ℂ
    ("H + (g1² + (−1_ℂ)(r_ℂ)²)",    H + (g1_**2 + m1*r_**2)),               # real_inclusion_preserves_power（m → 2）
    ("H + (g1² + (−(r_ℂ)²))",       H + (g1_**2 + (-(r_**2)))),             # multiply_by_minus_one（右→左）
    ("H + (g1² − (r_ℂ)²)",          H + (g1_**2 - r_**2)),                  # def_complex_difference（右→左）
]
assert len(rows) == 8
for t in range(len(rows) - 1):
    assert rows[t][1] == rows[t + 1][1], (t, rows[t][0], rows[t + 1][0])
    print(f"PASS: {rows[t][0]} = {rows[t + 1][0]}")
# 個々の行で当てた事実
assert a_*b_ == iota(-(s**2))                         # relation (2): ab = (−r^2)_ℂ（商環の関係）
assert -(s**2) == (-1)*s**2                           # ℝ で (−1)x = −x
assert iota(S(-1)*s**2) == iota(S(-1))*iota(s**2)     # real_inclusion_preserves_product
assert iota(S(-1)) == m1                              # −1_ℂ = (−1)_ℂ
assert iota(s**2) == iota(s)**2                       # real_inclusion_preserves_power（m → 2）
assert -(r_**2) == m1*r_**2                           # multiply_by_minus_one
# 否定コントロール: 商を取らない多項式環では ab を −r^2 に置き換えられない。ab = +r^2 とした式とも一致しない
assert P(a*b) != P(-r**2)
assert rows[0][1] != H + (g1_**2 + r_**2)
print("否定コントロール: 商を取らなければ ab ≠ −r^2、+r^2 とした式とは一致しない")
print("ALL PASS")
