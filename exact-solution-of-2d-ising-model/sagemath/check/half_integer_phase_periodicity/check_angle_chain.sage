# 対象ラベル: half_integer_phase_periodicity
# 二つの角度の鎖を、π・μ・M・j を不定元にした QQ 上の有理関数体で、各行をその行の式の形のまま組んで隣と比べる。
# (1) θ̃_{μ+M} = ⋯ = θ̃_μ + 2π の 11 等号（交換律・差の定義・結合律・差の定義・交換律を 1 行ずつ）。第 1 行は θ̃ の定義の式に μ+M を入れたもの（ι_{Z→R} の和の保存の前）。
# (2) j_R θ̃_{μ+M} = j_R(θ̃_μ + 2π) = j_R θ̃_μ + j_R·2π = j_R θ̃_μ + 2πj_R の 3 等号。
# 対照: θ̃ の定義の 1/2 を外して整数運動量にしても (1) は成り立つ（周期性は 1/2 に依らない）が、
#   添字を M+1 ずらすと最後の等号が崩れる。
# 具体の点: M = 2..8、μ = -2M..2M、j = -2M..2M で、各行の 角度/2π が一致することも見る。
load("../../_shared/half_integer_phase_exact.sage")
h = QQ(1) / 2
chain1 = [
    ("θ̃_{μ+M}", theta_tilde_formula(mu_ + M_, M_)),
    ("2π((μ+M)_R - 1/2)/(M)_R", 2 * pi_ * ((mu_ + M_) - h) / M_),
    ("2π((μ_R+(M)_R) - 1/2)/(M)_R", 2 * pi_ * ((mu_ + M_) - h) / M_),
    ("2π(((M)_R+μ_R) - 1/2)/(M)_R", 2 * pi_ * ((M_ + mu_) - h) / M_),
    ("2π(((M)_R+μ_R) + (-1/2))/(M)_R", 2 * pi_ * ((M_ + mu_) + (-h)) / M_),
    ("2π((M)_R+(μ_R+(-1/2)))/(M)_R", 2 * pi_ * (M_ + (mu_ + (-h))) / M_),
    ("2π((M)_R+(μ_R-1/2))/(M)_R", 2 * pi_ * (M_ + (mu_ - h)) / M_),
    ("2π((μ_R-1/2)+(M)_R)/(M)_R", 2 * pi_ * ((mu_ - h) + M_) / M_),
    ("(2π(μ_R-1/2) + 2π(M)_R)/(M)_R", (2 * pi_ * (mu_ - h) + 2 * pi_ * M_) / M_),
    ("2π(μ_R-1/2)/(M)_R + 2π(M)_R/(M)_R", 2 * pi_ * (mu_ - h) / M_ + 2 * pi_ * M_ / M_),
    ("θ̃_μ + 2π(M)_R/(M)_R", theta_tilde_formula(mu_, M_) + 2 * pi_ * M_ / M_),
    ("θ̃_μ + 2π", theta_tilde_formula(mu_, M_) + 2 * pi_),
]
check_adjacent(chain1, "θ̃_{μ+M} の鎖")
assert theta_tilde_formula(mu_ + M_ + 1, M_) != theta_tilde_formula(mu_, M_) + 2 * pi_
print("  θ̃_{μ+M} の 11 等号が有理関数体で成り立つ。添字を M+1 ずらすと θ̃_μ + 2π にならない")
th_shift = chain1[-1][1]
chain2 = [
    ("j_R θ̃_{μ+M}", j_ * theta_tilde_formula(mu_ + M_, M_)),
    ("j_R(θ̃_μ + 2π)", j_ * th_shift),
    ("j_R θ̃_μ + j_R·2π", j_ * theta_tilde_formula(mu_, M_) + j_ * (2 * pi_)),
    ("j_R θ̃_μ + 2πj_R", j_ * theta_tilde_formula(mu_, M_) + 2 * pi_ * j_),
]
check_adjacent(chain2, "j_R θ̃_{μ+M} の鎖")
print("  j_R θ̃_{μ+M} の 3 等号が有理関数体で成り立つ")
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        v = [x.subs(pi_=1, mu=mu, M=M) / 2 for _, x in chain1]
        assert len(set(v)) == 1 and v[0] == theta_over_2pi(M, mu + M) and v[-1] == theta_over_2pi(M, mu) + 1
        for j in range(-2 * M, 2 * M + 1):
            w = [x.subs(pi_=1, mu=mu, M=M, j=j) / 2 for _, x in chain2]
            assert len(set(w)) == 1 and w[0] == j * theta_over_2pi(M, mu + M)
print("  M = 2..8、μ = -2M..2M、j = -2M..2M で、各行の 角度/2π が一致する")
print("RESULT: PASS")
