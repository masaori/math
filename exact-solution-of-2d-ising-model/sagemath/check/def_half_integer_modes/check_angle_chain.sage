# 対象ラベル: def_half_integer_modes
# 証明の鎖 θ̃_{1-μ} = ⋯ = -θ̃_μ の 14 等号を、π・μ・M を不定元にした QQ 上の有理関数体で、
# 各行をその行の式の形のまま組んで隣の行と比べる。不定元で成り立つ有理式の等号は、M ≠ 0 の代入でも成り立つ。
# 整数の像の行（(1-μ)_R = ι(1) - μ_R、ι(1) = 1_R）は antiperiodic_exp_sum の仮定（包含は零・単位元・和を保つ）を
# そのまま使う行で、有理関数体の上では両辺が同じ式になり、検算は中身を持たない。
# 具体の点: M = 2..8、μ = -2M..2M で、各行の 角度/2π が一致し、θ̃_{1-μ}/2π = -θ̃_μ/2π であることも見る。
# 対照: 共役添字を -μ に替える（整数運動量のときの共役添字）と、θ̃_{-μ} ≠ -θ̃_μ。
load("../../_shared/half_integer_phase_exact.sage")
h = QQ(1) / 2
lines = [
    ("θ̃_{1-μ}", theta_tilde_formula(1 - mu_, M_)),
    ("2π((1-μ)_R - 1/2)/(M)_R", 2 * pi_ * ((1 - mu_) - h) / M_),
    ("2π((ι(1) - μ_R) - 1/2)/(M)_R", 2 * pi_ * ((1 - mu_) - h) / M_),
    ("2π((1_R - μ_R) - 1/2)/(M)_R", 2 * pi_ * ((1 - mu_) - h) / M_),
    ("2π((1_R + (-μ_R)) - 1/2)/(M)_R", 2 * pi_ * ((1 + (-mu_)) - h) / M_),
    ("2π((1_R + (-μ_R)) + (-1/2))/(M)_R", 2 * pi_ * ((1 + (-mu_)) + (-h)) / M_),
    ("2π(1_R + ((-μ_R) + (-1/2)))/(M)_R", 2 * pi_ * (1 + ((-mu_) + (-h))) / M_),
    ("2π(1_R + ((-1/2) + (-μ_R)))/(M)_R", 2 * pi_ * (1 + ((-h) + (-mu_))) / M_),
    ("2π((1_R + (-1/2)) + (-μ_R))/(M)_R", 2 * pi_ * ((1 + (-h)) + (-mu_)) / M_),
    ("2π((1_R - 1/2) + (-μ_R))/(M)_R", 2 * pi_ * ((1 - h) + (-mu_)) / M_),
    ("2π((1_R - 1/2) - μ_R)/(M)_R", 2 * pi_ * ((1 - h) - mu_) / M_),
    ("2π(1/2 - μ_R)/(M)_R", 2 * pi_ * (h - mu_) / M_),
    ("2π(-(μ_R - 1/2))/(M)_R", 2 * pi_ * (-(mu_ - h)) / M_),
    ("-(2π(μ_R - 1/2)/(M)_R)", -(2 * pi_ * (mu_ - h) / M_)),
    ("-θ̃_μ", -theta_tilde_formula(mu_, M_)),
]
check_adjacent(lines, "共役添字の鎖")
assert theta_tilde_formula(-mu_, M_) != -theta_tilde_formula(mu_, M_)
print("  鎖の 14 等号が有理関数体で成り立つ。共役添字を -μ に替えると θ̃_{-μ} ≠ -θ̃_μ")
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        vals = [x.subs(pi_=1, mu=mu, M=M) / 2 for _, x in lines]
        assert len(set(vals)) == 1
        assert theta_over_2pi(M, 1 - mu) == -theta_over_2pi(M, mu)
        assert vals[0] == theta_over_2pi(M, 1 - mu)
        if theta_over_2pi(M, -mu) == -theta_over_2pi(M, mu):
            raise AssertionError("対照が崩れない")
print("  M = 2..8、μ = -2M..2M で、各行の 角度/2π が一致し θ̃_{1-μ} = -θ̃_μ")
print("RESULT: PASS")
