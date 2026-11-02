# 対象ラベル: half_integer_phase_antiperiodicity
# 指数の中の実数の鎖 (M)_R θ̃_μ = ⋯ = -π + 2πμ_R の 6 等号を、π・μ・M を不定元にした QQ 上の有理関数体で、
# 各行をその行の式の形のまま組んで隣の行と比べる。不定元で成り立つ有理式の等号は、M ≠ 0 の代入でも成り立つ。
# 対照: 2·(1/2) = 1 の行で誤って 2·(1/2) = 1/2 とすると崩れる。
# 具体の点: M = 2..8、μ = -2M..2M で、各行から 2π を外した有理数（角度/2π）が一致することも見る。
load("../../_shared/half_integer_phase_exact.sage")
h = QQ(1) / 2
lines = [
    ("(M)_R θ̃_μ", M_ * theta_tilde_formula(mu_, M_)),
    ("(M)_R·2π(μ_R-1/2)/(M)_R", M_ * (2 * pi_ * (mu_ - h) / M_)),
    ("2π(μ_R-1/2)", 2 * pi_ * (mu_ - h)),
    ("2πμ_R - 2π·(1/2)", 2 * pi_ * mu_ - 2 * pi_ * h),
    ("2πμ_R - π(2·(1/2))", 2 * pi_ * mu_ - pi_ * (2 * h)),
    ("2πμ_R - π", 2 * pi_ * mu_ - pi_),
    ("-π + 2πμ_R", -pi_ + 2 * pi_ * mu_),
]
check_adjacent(lines, "角度の鎖")
assert lines[4][1] != 2 * pi_ * mu_ - pi_ * h
print("  角度の鎖の 6 等号が有理関数体で成り立つ。2·(1/2) を 1/2 に替えると 2·(1/2) = 1 の行が崩れる")
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        vals = [x.subs(pi_=1, mu=mu, M=M) / 2 for _, x in lines]
        assert len(set(vals)) == 1 and vals[0] == QQ(M) * theta_over_2pi(M, mu)
print("  M = 2..8、μ = -2M..2M で、各行の 角度/2π が (M)_R θ̃_μ/2π = μ - 1/2 に一致する")
print("RESULT: PASS")
