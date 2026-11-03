# 対象ラベル: anticommutator_of_check_Z_Y
# ℝ への脱出を含む行を、本文の exp（def_scalar_exp。部分和の極限）のボールで確かめる（512 bit。π は RB.pi()）。
# - 1 の冪根による位相の表し方: e_{j,λ} = exp(-i(j_R θ̃_λ)_C) の本文の exp のボールが、check_three_chains.sage の
#   1 の冪根 ζ_{4M}^{-2j(2λ-1)}（QQbar の E(-j(λ-1/2)/M)）を含む。
# - 主鎖の scalar_exp_product の行: e_{j,μ}e_{j,ν} のボールの積と、指数の和の exp のボールが重なる。
# - 主鎖の準備 2 の行: 指数の和の exp のボールと exp(i(y_j)_C) のボールが重なる。
# - 主鎖の exp_sum の行: Σ_{j=1}^{N} exp(i(y_j)_C) のボールが (M_col)_C δ^{(M)}_{(κ,0)} を含む。
# - 主張の第 1 式の係数: Σ_j e_{j,μ}e_{j,ν} のボールの 2 倍が 2M δ_{ν,M+1-μ} を含む。
# 重なりは等号の必要条件であって証明ではない。範囲: M = 2..8、μ, ν ∈ M̌、j = 1..M。
# 対照: θ̃ の 1/2 を落とした整数運動量では、ν = M+1-μ で exp_sum の行の値が M にならない組がある。
load("../../_shared/half_integer_phase_exact.sage")


def th_b(M, lam):
    return 2 * PI * (RB(lam) - RB(1) / 2) / RB(M)


def deltaM(M, a, b):
    return 1 if (a - b) % M == 0 else 0


count = 0
broken = 0
for M in range(2, 9):
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            kappa = -(mu + nu - 1)
            S = CB(0)
            Sprod = CB(0)
            for j in range(1, M + 1):
                ej_mu = body_exp_i_ball(-RB(j) * th_b(M, mu))
                ej_nu = body_exp_i_ball(-RB(j) * th_b(M, nu))
                assert ej_mu.overlaps(CB(E(-QQ(j) * theta_over_2pi(M, mu))))   # 位相の表し方（E は QQbar の元。そのボールと重なる）
                assert ej_nu.overlaps(CB(E(-QQ(j) * theta_over_2pi(M, nu))))
                e_sum = body_exp_i_ball(-(RB(j) * th_b(M, mu) + RB(j) * th_b(M, nu)))
                assert (ej_mu * ej_nu).overlaps(e_sum)                          # scalar_exp_product
                yj = 2 * PI * RB(j) * RB(kappa) / RB(M)
                e_y = body_exp_i_ball(yj)
                assert e_sum.overlaps(e_y)                                      # 準備 2
                S = S + e_y
                Sprod = Sprod + ej_mu * ej_nu
            assert S.contains_exact(ZZ(M * deltaM(M, kappa, 0)))                      # exp_sum
            delta = 1 if nu == M + 1 - mu else 0
            assert (2 * Sprod).contains_exact(ZZ(2 * M * delta))                      # 主張の係数
            count += 1
        # 対照（整数運動量 2πμ/M）
        nu0 = M + 1 - mu
        Sint = sum(body_exp_i_ball(-(RB(j) * 2 * PI * RB(mu) / RB(M))) * body_exp_i_ball(-(RB(j) * 2 * PI * RB(nu0) / RB(M)))
                   for j in range(1, M + 1))
        if not Sint.contains_exact(ZZ(M)):
            broken += 1
assert broken > 0
print(f"checked phases, scalar_exp_product, preparation 2, exp_sum and the coefficient for M = 2..8 ({count} pairs); control broke {broken} times")
print("RESULT: PASS")
