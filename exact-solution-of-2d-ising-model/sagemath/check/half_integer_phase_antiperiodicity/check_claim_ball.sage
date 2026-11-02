# 対象ラベル: half_integer_phase_antiperiodicity
# 主張 exp(-i((M)_R θ̃_μ)_C) = -1_C を本文の exp で確かめる。ℝ への脱出はここだけ（π と exp の値）。
# θ̃_μ は定義の式 2π(μ_R - 1/2)/(M)_R のまま、π を Arb のボールにして組む。M = 2..8、μ = -2M..2M。
# あわせて、check_exp_chain.sage の第 0 行の E(-q0)（1 の冪根）が本文の exp のボールに入ることを確かめる。
# 対照: 整数運動量 θ_μ = 2πμ_R/(M)_R に替えると、値は +1 になり -1 と交わらない。
load("../../_shared/half_integer_phase_exact.sage")
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        th = 2 * PI * (RB(mu) - RB(1) / 2) / RB(M)
        lhs = body_exp_i_ball(-(RB(M) * th))
        assert lhs.overlaps(CB(-1))
        assert qqbar_ball(E(-QQ(M) * theta_over_2pi(M, mu))).overlaps(lhs)
        th_int = 2 * PI * RB(mu) / RB(M)
        assert not body_exp_i_ball(-(RB(M) * th_int)).overlaps(CB(-1))
print("  M = 2..8、μ = -2M..2M で、本文の exp(-i((M)_R θ̃_μ)_C) のボールが -1 と重なり、E(-q0) を含む。整数運動量では -1 と交わらない")
print("RESULT: PASS")
