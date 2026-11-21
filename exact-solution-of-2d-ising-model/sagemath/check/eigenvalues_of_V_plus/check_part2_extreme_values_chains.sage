# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (2) の Λ̌_max・Λ̌_min の値の鎖を確かめる。
#   ǧ(1,…,1) = Σ_{M̌}γ_μh((1,…,1)(μ)) = Σ_{M̌}γ_μh(1) = Σ_{μ=1}^{M}γ_μh(1) = Σγ_μ·(1/2) = Σ(1/2)γ_μ = (1/2)Σγ_μ          （6 行）
#   ǧ(0,…,0) = Σ_{M̌}γ_μh((0,…,0)(μ)) = Σ_{M̌}γ_μh(0) = Σ_{μ=1}^{M}γ_μh(0) = Σγ_μ·(−1/2) = Σ(−1/2)γ_μ = (−1/2)Σγ_μ
#            = −((1/2)Σγ_μ)                                                                                         （7 行）
#   （h は def_half_sign_of_binary_value の h(1) := ½・h(0) := −(½)、(1,…,1)・(0,…,0) は定数写像、Σ_{M̌} は def_sum_over_check_index_set）
#   Λ̌_max = Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M_col/2} exp(Σ_{M̌}γ_μh((1,…,1)(μ))) = … exp(ǧ(1,…,1)) = … exp((1/2)Σγ_μ)
#   Λ̌_min も同じ形（ε → (0,…,0)、値は exp(−((1/2)Σγ_μ))）。
# ǧ の鎖は γ_μ を QQ 上の多項式環の不定元に置き、有限和は def_finite_sum_of_real_numbers のとおり左から足して、各行を書いたとおりに作る。
# 不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
# Λ̌ の鎖は K_2・γ_μ を記号のまま SR で組み、隣どうしの差が 0 になることを見る（exp・sinh は ℝ への脱出なので記号のまま比べる）。
# M_col = 2..8。
# 否定コントロール: (i) ǧ(0,…,0) の最後の行の符号を落とす（(1/2)Σγ_μ にする）と外れる。
#                    (ii) 共通の因子を出す行で、最後の項に因子を掛け忘れると外れる。
#                    (iii) Λ̌_max の最後の行の指数を Σγ_μ（1/2 を落とす）にすると外れる。
#                    (iv) h(0) を +½ にすると h(0) := −(½) の行が外れる。
# 帰属: ǧ の鎖は QQ[γ_1, …, γ_M]（厳密）、Λ̌ の鎖は SR の記号式（厳密）。浮動小数点は使わない。

half = QQ(1) / 2


def h(e):
    return half if e == 1 else -half                              # def_half_sign_of_binary_value


def fsum(rs):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


eq_count = 0
neg_count = 0
for M in range(2, 9):
    P = PolynomialRing(QQ, [f"g{j}" for j in range(1, M + 1)])
    gam = P.gens()
    ones = [1] * M
    zeros = [0] * M
    gcheck = lambda eps: fsum([gam[mu] * h(eps[mu]) for mu in range(M)])   # ǧ(ε) の定義
    S = fsum(list(gam))
    # ǧ(1,…,1) の 6 行
    lines_max = [
        gcheck(ones),
        fsum([gam[mu] * h(ones[mu]) for mu in range(M)]),         # ǧ の定義（ε → (1,…,1)）
        fsum([gam[mu] * h(1) for mu in range(M)]),                # (1,…,1)(μ) = 1 を各項へ
        fsum([gam[mu] * h(1) for mu in range(M)]),                # def_sum_over_check_index_set（作り方で自明）
        fsum([gam[mu] * half for mu in range(M)]),                # h(1) := ½ を各項へ
        fsum([half * gam[mu] for mu in range(M)]),                # 積の交換法則を各項へ
        half * S,                                                 # finite_sum_of_real_scalar_multiples（c → 1/2）
    ]
    for x, y in zip(lines_max, lines_max[1:]):
        assert x == y, ("max", M)
        eq_count += 1
    # ǧ(0,…,0) の 7 行
    lines_min = [
        gcheck(zeros),
        fsum([gam[mu] * h(zeros[mu]) for mu in range(M)]),        # ǧ の定義（ε → (0,…,0)）
        fsum([gam[mu] * h(0) for mu in range(M)]),                # (0,…,0)(μ) = 0 を各項へ
        fsum([gam[mu] * h(0) for mu in range(M)]),                # def_sum_over_check_index_set（作り方で自明）
        fsum([gam[mu] * (-half) for mu in range(M)]),             # h(0) := −(½) を各項へ
        fsum([(-half) * gam[mu] for mu in range(M)]),             # 積の交換法則を各項へ
        (-half) * S,                                              # finite_sum_of_real_scalar_multiples（c → −1/2）
        -(half * S),                                              # real_negation_times_is_negation_of_product（x → 1/2, t → S）
    ]
    for x, y in zip(lines_min, lines_min[1:]):
        assert x == y, ("min", M)
        eq_count += 1
    # 否定コントロール (i), (ii)
    assert lines_min[0] != half * S
    neg_count += 1
    assert fsum([half * gam[mu] for mu in range(M)]) != half * fsum(list(gam[:M - 1])) + gam[M - 1]
    neg_count += 1
    assert fsum([gam[mu] * half for mu in range(M)]) != fsum([gam[mu] * (-half) for mu in range(M)])   # (iv)
    neg_count += 1

    # Λ̌ の鎖（SR）
    K2 = var("K2")
    gs = [var("gamma%d" % mu) for mu in range(M)]
    Ssr = sum(gs)
    pref = (2 * sinh(2 * K2)) ** (QQ(M) / 2)
    gsr = lambda eps: sum(gs[mu] * h(eps[mu]) for mu in range(M))
    Lam = lambda eps: pref * exp(gsr(eps))                        # Λ̌_ε の定義
    for eps, val in ((ones, half * Ssr), (zeros, -(half * Ssr))):
        lines = [
            Lam(eps),                                             # Λ̌_max（Λ̌_min）の置き方
            pref * exp(sum(gs[mu] * h(eps[mu]) for mu in range(M))),   # Λ̌_ε の定義
            pref * exp(gsr(eps)),                                 # ǧ の定義を右辺から左辺へ
            pref * exp(val),                                      # 上の ǧ の鎖
        ]
        for x, y in zip(lines, lines[1:]):
            assert bool((x - y).simplify_full() == 0), (M, eps)
            eq_count += 1
    assert not bool((Lam(ones) - pref * exp(Ssr)).simplify_full() == 0)   # (iii)
    neg_count += 1

print("eigenvalues_of_V_plus (2) の Λ̌_max・Λ̌_min の値: 等号 %d 段、否定コントロール %d 件 PASS" % (eq_count, neg_count))
print("RESULT: PASS")
