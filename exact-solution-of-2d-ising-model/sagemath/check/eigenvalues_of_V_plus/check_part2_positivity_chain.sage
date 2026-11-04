# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (2) の正値性の前置きと 5 行の鎖
#   a > 0（a := (2s_2)^{M_col/2}、所属は def_second_transfer_matrix_prefactor）、exp(ǧ(ε)) > 0（real_exp_positive）
#   Λ̌_ε = (2 sinh 2K_2)^{M_col/2} exp(Σ_μ γ_μ(ε_μ − 1/2))
#       = (2s_2)^{M_col/2} exp(Σ_μ γ_μ(ε_μ − 1/2))     （s_2 = sinh 2K_2 を右辺から左辺へ）
#       = (2s_2)^{M_col/2} exp(ǧ(ε))                    （ǧ(ε) の定義を右辺から左辺へ）
#       = a exp(ǧ(ε))                                    （a の置き方を右辺から左辺へ）
#       > 0                                              （ℝ で u > 0, v > 0 なら uv > 0。u → a、v → exp(ǧ(ε))）
# を確かめる。
# 1〜4 行目の等号は、K_2・γ_μ・s_2 を記号のまま SR で組み、各行の式を書いたとおりに作って隣どうしの差が 0 に簡約されることを見る
# （s_2 を sinh(2K_2) へ戻す代入だけを使う）。a は def_second_transfer_matrix_prefactor のとおり (sqrt(2s_2))^{M_col} で作る。
# 5 行目と前置きの 2 つの不等号は値の比較で、値は ℝ への脱出なので RealBallField（区間演算、精度 200 ビット）で、
# 有理数の K_2 > 0 と有理数の γ_μ（負も含める。正値性の鎖は γ_μ の符号を使わない）について、球が 0 より真に大きいことを確かめる。
# M_col = 2..5、ε は全列挙。
# 否定コントロール: exp(ǧ(ε)) の代わりに ǧ(ε) そのもの（前置きの real_exp_positive が無い）を掛けると、
# 正の a でも a·ǧ(ε) > 0 が成り立たない ε があることを確かめる（前置きの不等号を外すと 5 行目が外れる）。
# 帰属: 1〜4 行目は SR の記号式（厳密）、値の比較は RealBallField（ℝ への脱出。区間の包含で厳密に判定）。

RBF200 = RealBallField(200)

def chain_symbolic(M, eps):
    K2, s2 = var("K2 s2")
    gam = [var("gamma%d" % mu) for mu in range(M)]
    gsum = sum(gam[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
    gcheck = gsum                                       # ǧ(ε) の定義
    a = sqrt(2 * s2) ** M                               # a の置き方（def_second_transfer_matrix_prefactor の (sqrt(2s_2))^{M_col}）
    lines = [
        sqrt(2 * sinh(2 * K2)) ** M * exp(gsum),        # Λ̌_ε の定義
        sqrt(2 * s2) ** M * exp(gsum),                  # s_2 = sinh 2K_2 を右辺から左辺へ
        sqrt(2 * s2) ** M * exp(gcheck),                # ǧ(ε) の定義を右辺から左辺へ
        a * exp(gcheck),                                # a の置き方を右辺から左辺へ
    ]
    back = {s2: sinh(2 * K2)}
    n = 0
    for x, y in zip(lines, lines[1:]):
        assert bool((x.subs(back) - y.subs(back)).simplify_full() == 0), (M, eps, x, y)
        n += 1
    return n

def values(M, eps, K2, gam):
    s2 = RBF200(2 * K2).sinh()                          # s_2 = sinh 2K_2
    a = (2 * s2).sqrt() ** M                            # a = (sqrt(2s_2))^{M_col}
    gcheck = sum(RBF200(gam[mu]) * (eps[mu] - QQ(1) / 2) for mu in range(M))
    return a, gcheck, gcheck.exp()

eq_count = 0
ineq_count = 0
neg_count = 0
samples_K2 = [QQ(1) / 10, QQ(1) / 2, QQ(1), QQ(3)]
samples_gam = {
    M: [[QQ(j + 1) / 3 for j in range(M)], [QQ((-1) ** j * (j + 2)) / 5 for j in range(M)]]
    for M in range(2, 6)
}
for M in range(2, 6):
    for eps in cartesian_product([[0, 1]] * M):
        eps = tuple(eps)
        eq_count += chain_symbolic(M, eps)
        for K2 in samples_K2:
            for gam in samples_gam[M]:
                a, g, e = values(M, eps, K2, gam)
                assert a > 0 and e > 0, (M, eps, K2, gam)          # 前置きの 2 つの不等号
                Lam = a * e                                       # 4 行目の値 a·exp(ǧ(ε))
                Lam_def = (2 * RBF200(2 * K2).sinh()).sqrt() ** M * e  # 1 行目の値（Λ̌_ε の定義）
                assert Lam.overlaps(Lam_def)
                assert Lam > 0, (M, eps, K2, gam)                 # 5 行目
                ineq_count += 3

# 否定コントロール: ǧ(ε) を exp に通さずに掛けると、a·ǧ(ε) > 0 は成り立たない ε がある
for M in range(2, 6):
    for K2 in samples_K2:
        for gam in samples_gam[M]:
            found = False
            for eps in cartesian_product([[0, 1]] * M):
                a, g, e = values(M, tuple(eps), K2, gam)
                if not (a * g > 0):
                    found = True
                    break
            assert found, (M, K2, gam)
            neg_count += 1

print("eigenvalues_of_V_plus (2) の正値性: 等号 %d 段、不等号 %d 件、否定コントロール %d 組 PASS" % (eq_count, ineq_count, neg_count))
