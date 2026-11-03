# 対象ラベル: gamma1_gt_1_theta_tilde
# 具体の結合定数と全ての μ で、準備の各段・g^2 の鎖の各行・主張の二つの不等式を厳密に確かめる。
# g = γ_1(θ~_μ)、γ_2(θ~_μ) は円分体の元として定義式から作り、AA（実代数的数）へ移して順序を比べる。
# cosh(2K_1 - 2K_2^*) は exp(2K_1 - 2K_2^*) = Y/X から def_cosh_sinh の式で独立に作る。浮動小数点なし。
load("_prelude.sage")

rep = Report("gamma1_gt_1_theta_tilde: 具体の値と主張")
n_cases = 0
fail = {}
def tick(ok, key):
    fail[key] = fail.get(key, 0) + (0 if ok else 1)

for (Yq, Zq) in COUPLINGS:
    k = couplings(Yq, Zq)
    E = k['Y'] / k['X']
    ch = (E + 1 / E) / 2                      # cosh(2K_1 - 2K_2^*)
    for M in M_RANGE:
        for mu in range(1, M + 1):
            n_cases += 1
            F, I_, Ep, Em, co, si = cyclotomic_angle(M, mu)
            g1, g2 = gamma1_gamma2(k, I_, Ep, co, si)
            tick(g1 == g1.conjugate(), "γ_1(θ~_μ) は実数（複素共役で不変）")
            g = to_AA(g1)
            # 準備の第一の鎖
            tick(g >= ch and ch >= 1, "準備: g ≥ cosh(2K_1 - 2K_2^*) かつ cosh(2K_1 - 2K_2^*) ≥ 1（gamma1_lower_bound_all_theta の当てはめ）")
            tick(g >= 1, "準備: g ≥ 1")
            tick(g > 0, "準備: g > 0")
            # 準備の第二の鎖
            tick(g2 != 0, "準備: γ_2(θ~_μ) ≠ 0（gamma_2_theta_tilde_nonzero の当てはめ）")
            N = to_AA(g2 * g2.conjugate())
            r = N.sqrt()
            tick(r >= 0 and r**2 == N, "r = |γ_2| は非負で r^2 = γ_2 conj(γ_2)")
            tick(r != 0 and r > 0, "準備: r ≠ 0、r > 0")
            tick(r * r > 0 * r and r * r > 0 and r**2 > 0, "準備: r·r > 0·r、r·r > 0、r^2 > 0")
            # g^2 の鎖
            rows = [g**2, 1 + r**2, AA(1 + 0), AA(1)]
            tick(rows[0] == rows[1], "g^2 の鎖 第 1 行 = 第 2 行（γ_1^2 = 1 + |γ_2|^2）")
            tick(rows[1] > rows[2], "g^2 の鎖 第 2 行 > 第 3 行")
            tick(rows[2] == rows[3], "g^2 の鎖 第 3 行 = 第 4 行")
            # 背理の鎖の仮定 g ≤ 1 は成り立たない
            tick(not (g <= 1), "背理の仮定 g ≤ 1 は成り立たない")
            # 主張
            tick(g >= 1 and g > 1, "主張: γ_1(θ~_μ) ≥ 1 かつ γ_1(θ~_μ) > 1")

for key, nf in fail.items():
    rep.check(nf == 0, f"{key}（{n_cases} 組のうち不一致 {nf}）")
rep.check(n_cases == len(COUPLINGS) * sum(M for M in M_RANGE), f"組の数 {n_cases}")

# 対照: 臨界点 (Y, Z) = (2, 3)（X = Y）で θ = 0（半整数運動量ではない）を取ると γ_2(0) = 0 で γ_1(0) = 1 となり、
# 狭義の不等号は成り立たない。狭義の不等号が γ_2(θ~_μ) ≠ 0 に依ることを示す。
k = couplings(2, 3)
K.<ii> = QuadraticField(-1)
g1_0, g2_0 = gamma1_gamma2(k, ii, K(1), K(1), K(0))
rep.check(k['X'] == k['Y'], "対照: (Y, Z) = (2, 3) は臨界点（exp(2K_2^*) = exp(2K_1)）")
rep.check(g2_0 == 0 and g1_0 == 1, "対照: θ = 0 では γ_2(0) = 0、γ_1(0) = 1（狭義の不等号は成り立たない）")

rep.finish()
