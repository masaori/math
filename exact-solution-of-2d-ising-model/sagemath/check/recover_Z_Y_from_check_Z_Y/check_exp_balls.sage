# 対象ラベル: recover_Z_Y_from_check_Z_Y
# ℝ への脱出を含む行を、本文の exp（def_scalar_exp。部分和の極限）のボールで確かめる（512 bit。π は RB.pi()）。
# - 1 の冪根による位相の表し方: f_{j,μ} = exp(i(j_R θ̃_μ)_C)・e_{k,μ} = exp(-i(k_R θ̃_μ)_C) の本文の exp のボールが、
#   check_two_chains.sage の 1 の冪根（QQbar の E(±j(μ-1/2)/M)）と重なる。
# - 主鎖の scalar_exp_product の行: f_{j,μ}e_{k,μ} のボールと、本文の形の指数 i(j_Rθ̃_μ)_C + (-i)(k_Rθ̃_μ)_C の exp のボールが重なる。
# - 準備 2 の行: 指数の和の exp のボールと exp(i((j-k)_R θ̃_μ)_C) のボールが重なる。
# - antiperiodic_exp_sum の「とくに」の行: Σ_μ exp(i((j-k)_R θ̃_μ)_C) のボールが、j = k なら M、j ≠ k なら 0 を含む。
# - 主張: (1/M)Σ_μ f_{j,μ}e_{k,μ} のボールが δ_{jk} を含む（Z_j の係数の取り出し）。
# 重なりは等号の必要条件であって証明ではない。範囲: M = 2..8、j, k, μ ∈ {1..M}。
# 対照: θ̃ の 1/2 を落とした整数運動量の角度でも同じ和の値になる（復元は整数運動量でも成り立つ）ので、対照は
#   f の符号を反転した場合（Σ_μ e_{j,μ}e_{k,μ} が δ_{jk}M にならない組がある）とする。
load("../../_shared/half_integer_phase_exact.sage")


def body_exp_ball_c(z, N=None):
    """本文の exp（def_scalar_exp）の値 exp(z)（z は複素数のボール）を、部分和 Σ_{p=0}^{N} z^p/p! に
    尾 Σ_{p>N} r^p/p! ≤ 2r^{N+1}/(N+1)!（N + 2 ≥ 2r、r は |z| の上界）を半径として足したボールで囲む。"""
    r = z.abs().upper()
    if N is None:
        N = 4 * ceil(r) + 60
    assert N + 2 >= 2 * r
    S = CB(0)
    power = CB(1)
    for p in range(N + 1):
        S = S + power / factorial(p)
        power = power * z
    out = S.add_error((2 * RB(r) ** (N + 1) / factorial(N + 1)).upper())
    assert RR(out.rad()) < RR(2) ** -100
    return out


def th_b(M, lam):
    return 2 * PI * (RB(lam) - RB(1) / 2) / RB(M)


count = 0
broken = 0
for M in range(2, 9):
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            S = CB(0)
            Sprod = CB(0)
            Sbad = CB(0)
            for mu in range(1, M + 1):
                fb = body_exp_i_ball(RB(j) * th_b(M, mu))
                eb = body_exp_i_ball(-(RB(k) * th_b(M, mu)))
                assert fb.overlaps(CB(E(QQ(j) * theta_over_2pi(M, mu))))
                assert eb.overlaps(CB(E(-QQ(k) * theta_over_2pi(M, mu))))
                # scalar_exp_product の右辺 exp(i(j_Rθ̃)_C + (-i)(k_Rθ̃)_C) を、本文の形の複素数の指数から部分和で組む
                e_sum = body_exp_ball_c(CB(0, 1) * CB(RB(j) * th_b(M, mu)) + (-CB(0, 1)) * CB(RB(k) * th_b(M, mu)))
                assert (fb * eb).overlaps(e_sum)                                   # scalar_exp_product
                e_jk = body_exp_i_ball(RB(j - k) * th_b(M, mu))
                assert e_sum.overlaps(e_jk)                                         # 準備 2
                S = S + e_jk
                Sprod = Sprod + fb * eb
                Sbad = Sbad + body_exp_i_ball(-(RB(j) * th_b(M, mu))) * eb
            assert S.contains_exact(ZZ(M if j == k else 0))                         # antiperiodic_exp_sum の「とくに」
            assert (Sprod / RB(M)).contains_exact(ZZ(1 if j == k else 0))           # 係数の取り出し
            if not Sbad.contains_exact(ZZ(M if j == k else 0)):
                broken += 1
            count += 1
assert broken > 0
print(f"checked phases, scalar_exp_product, preparation 2 and the antiperiodic sums for M = 2..8 ({count} pairs (j, k)); control broke {broken} times")
print("RESULT: PASS")
