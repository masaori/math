# 対象ラベル: max_eigenvalue_of_V_plus_simple
# max_eigenvalue_of_V_plus_simple (1) の 4 行の鎖を一行ずつ確かめる。
#   Λ̌_max = (2 sinh 2K_2)^{M/2} exp(½ Σ_{μ=1}^{M} γ(θ̃_μ))                    （eigenvalues_of_V_plus (2)）
#         = (2 sinh 2K_2)^{M/2} exp(½ Σ_{μ=1}^{M} γ(2π(μ − ½)/M))             （antiperiodic_exp_sum の θ̃_μ の定義）
#         = (2 sinh 2K_2)^{M/2} exp(½ Σ_{μ=1}^{M} γ(θ^{(1/2)}_{M,μ}))         （def_Theta_delta_M（δ → ½））
#         = Λ^{(1/2)}_M                                                      （def_Lambda_delta_M（δ → ½））
# 角の行（2・3 行目）は、各項の角を π の有理数倍として QQ で厳密に比べる（θ̃_μ/π と θ^{(1/2)}_{M,μ}/π）。
# 和はすべて def_finite_sum_of_real_numbers のとおり μ = 1 から左へ順に足す。
# Λ̌_max の 1 行目は、eigenvalues_of_V_plus の Λ̌_ε の定義に ε = (1,…,1) を入れた値と比べる（Λ̌_max = Λ̌_{(1,…,1)}）。
# exp・arccosh・実数冪を含む行は RealField(200) で比べる（ℝ 脱出: 超越関数の値。差が 10^{-50} 未満であることを見る）。
# 否定コントロール: def_Lambda_delta_M を δ = 0 で取った Λ^{(0)}_M、前因子の冪を M にしたもの、和の ½ を落としたものは一致しない。

def fsum(rs):
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s

RF = RealField(200)
tol = RF(10) ** (-50)
couplings = [(QQ(1) / 3, QQ(1) / 2), (QQ(1) / 2, QQ(1) / 5), (QQ(3) / 4, QQ(3) / 4), (QQ(1) / 20, QQ(1) / 10)]
Kc = RF(log(1 + sqrt(2)) / 2)                         # 臨界点 sinh 2K_1 sinh 2K_2 = 1
angle_count = 0
line_count = 0
neg = 0
for M in range(2, 9):
    half = QQ(1) / 2
    theta_tilde_over_pi = [2 * (QQ(mu) - half) / M for mu in range(1, M + 1)]          # antiperiodic_exp_sum の θ̃_μ / π
    theta_family_over_pi = lambda delta: [2 * (QQ(mu) - delta) / M for mu in range(1, M + 1)]  # def_Theta_delta_M の θ^{(δ)}_{M,μ} / π
    assert theta_tilde_over_pi == theta_family_over_pi(half)                          # 2 行目 = 3 行目（各項の角）
    angle_count += M
    for (K1, K2) in [(RF(k1), RF(k2)) for (k1, k2) in couplings] + [(Kc, Kc)]:
        K2s = RF(atanh(exp(-2 * K2)))                  # 双対結合定数 K_2^*（tanh K_2^* = e^{−2K_2}）
        gamma = lambda t: arccosh(cosh(2 * K1) * cosh(2 * K2s) - sinh(2 * K1) * sinh(2 * K2s) * cos(t))
        pref = (2 * sinh(2 * K2)) ** (RF(M) / 2)
        g_tilde = [gamma(RF(pi) * RF(q)) for q in theta_tilde_over_pi]
        g_expanded = [gamma(2 * RF(pi) * (RF(mu) - RF(1) / 2) / RF(M)) for mu in range(1, M + 1)]
        g_family = [gamma(RF(pi) * RF(q)) for q in theta_family_over_pi(half)]
        Lambda_def = lambda delta: (2 * sinh(2 * K2)) ** (RF(M) / 2) * exp(RF(1) / 2 * fsum([gamma(RF(pi) * RF(q)) for q in theta_family_over_pi(delta)]))
        check_Lambda_top = (2 * sinh(2 * K2)) ** (RF(M) / 2) * exp(fsum([g_tilde[m] * (1 - RF(1) / 2) for m in range(M)]))  # Λ̌_{(1,…,1)}
        lines = [
            check_Lambda_top,                                   # Λ̌_max（= Λ̌_{(1,…,1)}）
            pref * exp(RF(1) / 2 * fsum(g_tilde)),              # eigenvalues_of_V_plus (2)
            pref * exp(RF(1) / 2 * fsum(g_expanded)),           # θ̃_μ の定義を各項へ
            pref * exp(RF(1) / 2 * fsum(g_family)),             # def_Theta_delta_M（δ → ½）を右辺から左辺へ
            Lambda_def(half),                                   # def_Lambda_delta_M（δ → ½）を右辺から左辺へ
        ]
        for t in range(len(lines) - 1):
            assert abs(lines[t] - lines[t + 1]) < tol * (1 + abs(lines[t])), (M, K1, K2, t)
            line_count += 1
        # 否定コントロール
        for bad in [Lambda_def(QQ(0)),
                    (2 * sinh(2 * K2)) ** RF(M) * exp(RF(1) / 2 * fsum(g_family)),
                    pref * exp(fsum(g_family))]:
            assert abs(bad - lines[-1]) > RF(10) ** (-12) * abs(lines[-1]), (M, K1, K2)
            neg += 1

print(f"(1) の鎖: 角の一致 {angle_count} 項（QQ）、隣どうしの行 {line_count} 段（RealField(200)）、否定コントロール {neg} 件")
print("RESULT: PASS")
