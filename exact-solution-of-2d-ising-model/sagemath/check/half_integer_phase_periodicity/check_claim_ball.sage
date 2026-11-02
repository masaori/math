# 対象ラベル: half_integer_phase_periodicity
# 主張 exp(-i(j_R θ̃_{μ+M})_C) = exp(-i(j_R θ̃_μ)_C) を本文の exp で確かめる。ℝ への脱出はここだけ（π と exp の値）。
# θ̃ は定義の式 2π(μ_R - 1/2)/(M)_R のまま、π を Arb のボールにして組む。M = 2..6、μ = -M..2M、j = -M..2M。
# あわせて、check_exp_chain.sage の両端の E（1 の冪根）が本文の exp のボールに入ることを確かめる。
# 対照: 添字を M+1 ずらすと、M ∤ j の組で交わらない。
load("../../_shared/half_integer_phase_exact.sage")


def th(M, mu):
    return 2 * PI * (RB(mu) - RB(1) / 2) / RB(M)


n = 0
broke = 0
for M in range(2, 7):
    for mu in range(-M, 2 * M + 1):
        for j in range(-M, 2 * M + 1):
            lhs = body_exp_i_ball(-(RB(j) * th(M, mu + M)))
            rhs = body_exp_i_ball(-(RB(j) * th(M, mu)))
            assert lhs.overlaps(rhs)
            assert qqbar_ball(E(-QQ(j) * theta_over_2pi(M, mu + M))).overlaps(lhs)
            assert qqbar_ball(E(-QQ(j) * theta_over_2pi(M, mu))).overlaps(rhs)
            if j % M != 0:
                assert not body_exp_i_ball(-(RB(j) * th(M, mu + M + 1))).overlaps(rhs)
                broke += 1
            n += 1
print(f"  {n} 組の (M, μ, j) で、本文の exp の両辺のボールが重なり、E の値を含む。添字を M+1 ずらすと {broke} 組で交わらない")
print("RESULT: PASS")
