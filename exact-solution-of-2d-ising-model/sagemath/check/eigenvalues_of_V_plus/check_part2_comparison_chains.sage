# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (2) の大小の比較の鎖を確かめる。
#   前置き: r_μ := γ_μ(1 − ε_μ) ≥ 0、w_μ := γ_μ ε_μ ≥ 0（γ_μ > 0、ε_μ ∈ {0,1}）
#   ǧ(1,…,1) − ǧ(ε) = Σγ_μ(1 − 1/2) − Σγ_μ(ε_μ − 1/2)        （ǧ の定義を 2 か所）
#                   = Σ(γ_μ(1 − 1/2) − γ_μ(ε_μ − 1/2))          （finite_sum_of_real_differences を右辺から左辺へ）
#                   = Σγ_μ((1 − 1/2) − (ε_μ − 1/2))              （分配法則）
#                   = Σγ_μ(1 − ε_μ)                               （(1 − 1/2) − (ε_μ − 1/2) = 1 − ε_μ）
#                   = Σ r_μ                                       （r_μ の置き方）
#                   ≥ r_1                                         （finite_sum_of_nonnegative_reals_is_at_least_each_term、k → 1）
#                   ≥ 0                                           （r_1 ≥ 0）
#   ǧ(ε) − ǧ(0,…,0) の鎖も同じ形（(ε_μ − 1/2) − (0 − 1/2) = ε_μ、w_μ）。
#   x ≤ y なら exp(x) ≤ exp(y)、Λ̌_ε = a·exp(ǧ(ε)) ≤ a·exp(ǧ(1,…,1)) = Λ̌_{(1,…,1)}、Λ̌_{(0,…,0)} ≤ Λ̌_ε の 9 行の鎖。
# ǧ の鎖は γ_μ を正の有理数に取り、各行を書いたとおりに QQ で作って等号・不等号を厳密に比べる。
# Λ̌ の鎖の等号の行は K_2・γ_μ・s_2 を記号のまま SR で組み、s_2 → sinh 2K_2 の代入だけで隣どうしの差が 0 になることを見る。
# Λ̌ の鎖の不等号の行（exp を含む値）は ℝ への脱出なので RealBallField（200 ビット）の球で判定する
# （a ≤ b は、b − a の球が 0 以上に確実に入るか、a と b が同じ式から作られて等しいときに真とする。ε = (1,…,1) では両辺が同じ値）。
# M_col = 2..5、ε は全列挙。
# 否定コントロール: (i) γ_μ に負の値を入れると r_μ ≥ 0 が外れ、ǧ(ε) ≤ ǧ(1,…,1) を満たさない ε がある。
#                    (ii) a の代わりに負の数を掛けると、Λ̌ の不等号の向きが逆になる ε がある。
#                    (iii) 鎖の「≥ r_1」を「≥ r_1 + r_2 + Σ r_μ」に替えると外れる（ε = (0,…,0)、正の γ_μ）。
# 帰属: ǧ の鎖は QQ（厳密）、Λ̌ の鎖の等号は SR の記号式（厳密）、exp を含む値の比較は RealBallField（ℝ への脱出。区間の包含で厳密に判定）。

RBF200 = RealBallField(200)
half = QQ(1) / 2

def gcheck(M, eps, gam):
    return sum(gam[mu] * (eps[mu] - half) for mu in range(M))         # ǧ(ε) の定義

def g_chain_max(M, eps, gam):
    r = [gam[mu] * (1 - eps[mu]) for mu in range(M)]
    assert all(x >= 0 for x in r)                                    # 前置き r_μ ≥ 0
    ones = tuple([1] * M)
    lines = [
        gcheck(M, ones, gam) - gcheck(M, eps, gam),                  # 左辺（ǧ の定義から作る値）
        sum(gam[mu] * (1 - half) for mu in range(M)) - sum(gam[mu] * (eps[mu] - half) for mu in range(M)),
        sum(gam[mu] * (1 - half) - gam[mu] * (eps[mu] - half) for mu in range(M)),
        sum(gam[mu] * ((1 - half) - (eps[mu] - half)) for mu in range(M)),
        sum(gam[mu] * (1 - eps[mu]) for mu in range(M)),
        sum(r),
    ]
    eq = 0
    for x, y in zip(lines, lines[1:]):
        assert x == y, (M, eps, gam)
        eq += 1
    assert sum(r) >= r[0]                                            # ≥ r_1
    assert r[0] >= 0                                                 # ≥ 0
    return eq, 2

def g_chain_min(M, eps, gam):
    w = [gam[mu] * eps[mu] for mu in range(M)]
    assert all(x >= 0 for x in w)                                    # 前置き w_μ ≥ 0
    zeros = tuple([0] * M)
    lines = [
        gcheck(M, eps, gam) - gcheck(M, zeros, gam),                 # 左辺（ǧ の定義から作る値）
        sum(gam[mu] * (eps[mu] - half) for mu in range(M)) - sum(gam[mu] * (0 - half) for mu in range(M)),
        sum(gam[mu] * (eps[mu] - half) - gam[mu] * (0 - half) for mu in range(M)),
        sum(gam[mu] * ((eps[mu] - half) - (0 - half)) for mu in range(M)),
        sum(gam[mu] * eps[mu] for mu in range(M)),
        sum(w),
    ]
    eq = 0
    for x, y in zip(lines, lines[1:]):
        assert x == y, (M, eps, gam)
        eq += 1
    assert sum(w) >= w[0]                                            # ≥ w_1
    assert w[0] >= 0                                                 # ≥ 0
    return eq, 2

def lam_chain_symbolic(M, eps, top):
    # top: 比べる相手の ε'（max の鎖では (1,…,1)、min の鎖では ε を右に置き、左を (0,…,0) にする）
    K2, s2 = var("K2 s2")
    gam = [var("gamma%d" % mu) for mu in range(M)]
    a = sqrt(2 * s2) ** M                                            # a の置き方（def_second_transfer_matrix_prefactor の (sqrt(2s_2))^{M_col}）
    def first_four(e):
        gs = sum(gam[mu] * (e[mu] - QQ(1) / 2) for mu in range(M))
        return [
            (2 * sinh(2 * K2)) ** (QQ(M) / 2) * exp(gs),            # Λ̌_ε の定義（本文の (2 sinh 2K_2)^{M_col/2} の形）
            (2 * s2) ** (QQ(M) / 2) * exp(gs),                       # s_2 = sinh 2K_2 を右辺から左辺へ
            (2 * s2) ** (QQ(M) / 2) * exp(gs),                       # ǧ(ε) の定義（同じ値を exp(ǧ(ε)) と読む。構成上一致）
            a * exp(gs),
        ]
    left, right = first_four(eps), first_four(top)
    lines_left = left                                                # 1〜4 行目
    lines_right = list(reversed(right))                              # 6〜9 行目（a·exp(ǧ(ε')) から Λ̌_{ε'} へ）
    back = {s2: sinh(2 * K2)}
    n = 0
    for seq in (lines_left, lines_right):
        for x, y in zip(seq, seq[1:]):
            d = (x.subs(back) - y.subs(back))
            assert bool(d.simplify_full() == 0) or bool(d.canonicalize_radical() == 0), (M, eps, top)
            n += 1
    return n

def lam_value(M, eps, K2, gam, factor=None):
    s2 = RBF200(2 * K2).sinh()
    a = (2 * s2).sqrt() ** M if factor is None else RBF200(factor)
    return a * RBF200(gcheck(M, eps, gam)).exp()

def le_ball(x, y, same):
    return same or (y - x) >= 0

eq_count = 0
ineq_count = 0
neg_count = 0
samples_K2 = [QQ(1) / 10, QQ(1) / 2, QQ(1), QQ(3)]
for M in range(2, 6):
    ones = tuple([1] * M)
    zeros = tuple([0] * M)
    samples_gam = [[QQ(j + 1) / 3 for j in range(M)], [QQ(2 * j + 1) / 7 for j in range(M)]]
    for eps in cartesian_product([[0, 1]] * M):
        eps = tuple(eps)
        for gam in samples_gam:
            e1, i1 = g_chain_max(M, eps, gam)
            e2, i2 = g_chain_min(M, eps, gam)
            eq_count += e1 + e2
            ineq_count += i1 + i2
            # 移項: ǧ(ε) ≤ ǧ(1,…,1)、ǧ(0,…,0) ≤ ǧ(ε)
            assert gcheck(M, eps, gam) <= gcheck(M, ones, gam)
            assert gcheck(M, zeros, gam) <= gcheck(M, eps, gam)
            ineq_count += 2
            for K2 in samples_K2:
                # x ≤ y なら exp(x) ≤ exp(y) と、両辺に正の a を掛ける行（5 行目）
                L, Lmax, Lmin = lam_value(M, eps, K2, gam), lam_value(M, ones, K2, gam), lam_value(M, zeros, K2, gam)
                assert le_ball(L, Lmax, eps == ones), (M, eps, K2)
                assert le_ball(Lmin, L, eps == zeros), (M, eps, K2)
                ex, exm, ex0 = [RBF200(gcheck(M, e, gam)).exp() for e in (eps, ones, zeros)]
                assert le_ball(ex, exm, eps == ones) and le_ball(ex0, ex, eps == zeros)
                ineq_count += 4
        eq_count += lam_chain_symbolic(M, eps, ones)
        eq_count += lam_chain_symbolic(M, zeros, eps)

# 否定コントロール
for M in range(2, 6):
    ones = tuple([1] * M)
    gam_neg = [QQ((-1) ** j * (j + 2)) / 5 for j in range(M)]       # (i) 負の γ_μ を含む
    assert any(not (gcheck(M, tuple(e), gam_neg) <= gcheck(M, ones, gam_neg)) for e in cartesian_product([[0, 1]] * M))
    neg_count += 1
    gam = [QQ(j + 1) / 3 for j in range(M)]
    for K2 in samples_K2:                                            # (ii) 負の数を掛けると向きが逆になる
        found = False
        for e in cartesian_product([[0, 1]] * M):
            e = tuple(e)
            if e == ones:
                continue
            if lam_value(M, e, K2, gam, factor=-1) > lam_value(M, ones, K2, gam, factor=-1):
                found = True
                break
        assert found, (M, K2)
        neg_count += 1
    zeros = tuple([0] * M)                                           # (iii) ε = (0,…,0) で「≥ r_1」を「≥ r_1 + r_2 + 1」に替えると外れる
    r = [gam[mu] * (1 - zeros[mu]) for mu in range(M)]
    assert not (sum(r) >= r[0] + r[1] + sum(r))
    neg_count += 1

print("eigenvalues_of_V_plus (2) の大小の比較: 等号 %d 段、不等号 %d 件、否定コントロール %d 組 PASS" % (eq_count, ineq_count, neg_count))
