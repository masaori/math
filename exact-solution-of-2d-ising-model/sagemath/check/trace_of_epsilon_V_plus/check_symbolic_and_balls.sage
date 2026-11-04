# 対象ラベル: trace_of_epsilon_V_plus
# (1) 準備 (P1)〜(P4) と、exp(κ(εG)) の級数の偶奇の分け方を、κ := (K_1)_ℂ を不定元に置いた QQ(i)[κ] で厳密に確かめる
#     （K_1 の値によらない）。M_col = 2, 3, 4。
# (2) 主張を、K_1 = log p の形に選ばない結合定数で、Sage の tensor_product・`*`・ComplexBallField の行列の exp だけで
#     組んだ V^{(+)} から独立に確かめる（ボール。exp は ℝ への脱出なので浮動小数点の区間演算を使う）。M_col = 2..5。
load("_prelude.sage")

rep = Report("trace_of_epsilon_V_plus: 準備の記号計算と、主張のボールによる独立の確かめ")

Rk = PolynomialRing(KG, "kappa")
kap = Rk.gen()


def over_Rk(A):
    return matrix(Rk, A)


for M in [2, 3, 4]:
    tag = f"M={M}"
    eps = over_Rk(epsilon(M))
    sz = [None] + [over_Rk(site(M, k, 'z')) for k in range(1, M + 1)]
    D0 = body_finite_sum([P_(sz[m], sz[m + 1]) for m in range(1, M)])
    G = P_(sz[M], sz[1])
    H1 = over_Rk(H1_plus(M))
    I = body_identity(Rk, 2**M)
    epsG = P_(eps, G)
    iK = Rk(i_K)
    # (P1)
    rep.chain([
        ("(iκ)H", S_(iK * kap, H1)),
        ("(κi)H", S_(kap * iK, H1)),
        ("κ(iH)", S_(kap, S_(iK, H1))),
        ("κ(D_0 + εG)", S_(kap, A_(D0, epsG))),
        ("κD_0 + κ(εG)", A_(S_(kap, D0), S_(kap, epsG))),
    ], f"{tag}: (P1)")
    # (P2)
    rep.chain([
        ("D_0(εG)", P_(D0, epsG)),
        ("(D_0ε)G", P_(P_(D0, eps), G)),
        ("(εD_0)G", P_(P_(eps, D0), G)),
        ("ε(D_0G)", P_(eps, P_(D0, G))),
        ("ε(GD_0)", P_(eps, P_(G, D0))),
        ("(εG)D_0", P_(epsG, D0)),
    ], f"{tag}: (P2)")
    kD0, kEG = S_(kap, D0), S_(kap, epsG)
    # Step 3 (a): κD_0 は対角行列で、対角成分は κ(E(s))_ℂ（= (K_1E(s))_ℂ。κ が (K_1)_ℂ なので、不定元では κ·E(s)）
    ok = all(kD0[r, c] == 0 for r in range(2**M) for c in range(2**M) if r != c)
    for s in configs(M):
        k = ord_(s) - 1
        ok &= (D0[k, k] == Rk(incl(energy(s)))) and (kD0[k, k] == kap * Rk(incl(energy(s))))
    rep.check(ok, f"{tag}: Step 3 (a) κD_0 の対角性と対角成分 κ(E(s))_ℂ")
    # real_inclusion_preserves_product の個々の場合: K_1 を有理数に置いて (K_1)_ℂ(E(s))_ℂ = (K_1E(s))_ℂ
    rep.check(all(incl(QQ(7) / 4) * incl(energy(s)) == incl(QQ(7) / 4 * energy(s)) for s in configs(M)),
              f"{tag}: Step 3 (a) κ(E(s))_ℂ = (K_1E(s))_ℂ（K_1 = 7/4）")
    rep.check(P_(D0, kEG) == P_(kEG, D0), f"{tag}: (P2) D_0(κ(εG)) = (κ(εG))D_0")
    rep.check(P_(kEG, kD0) == P_(kD0, kEG), f"{tag}: (P2) (κ(εG))(κD_0) = (κD_0)(κ(εG))")
    rep.check(P_(eps, kD0) == P_(kD0, eps), f"{tag}: (P2) ε(κD_0) = (κD_0)ε")
    # (P3)、(P4): 冪は A^0 := I、A^{n+1} := A^nA
    pw = {0: I}
    pk = {0: I}
    for n in range(1, 11):
        pw[n] = P_(pw[n - 1], epsG)
        pk[n] = P_(pk[n - 1], kEG)
    for j in range(0, 5):
        rep.chain([
            ("(εG)^{2j+1}", pw[2 * j + 1]),
            ("(εG)^{2j}(εG)", P_(pw[2 * j], epsG)),
            ("I(εG)", P_(I, epsG)),
            ("εG", epsG),
        ], f"{tag}, j={j}: (P3) 奇数の冪")
        rep.chain([
            ("(εG)^{2j+2}", pw[2 * j + 2]),
            ("(εG)^{2j+1}(εG)", P_(pw[2 * j + 1], epsG)),
            ("(εG)(εG)", P_(epsG, epsG)),
            ("I", I),
        ], f"{tag}, j={j}: (P3) 偶数の冪")
    for n in range(0, 10):
        X = epsG
        rep.chain([
            ("(κX)^{n+1}", pk[n + 1]),
            ("(κX)^n(κX)", P_(pk[n], kEG)),
            ("(κ^nX^n)(κX)", P_(S_(kap**n, pw[n]), kEG)),
            ("κ^n(X^n(κX))", S_(kap**n, P_(pw[n], kEG))),
            ("κ^n(κ(X^nX))", S_(kap**n, S_(kap, P_(pw[n], X)))),
            ("(κ^nκ)(X^nX)", S_(kap**n * kap, P_(pw[n], X))),
            ("κ^{n+1}X^{n+1}", S_(kap**(n + 1), pw[n + 1])),
        ], f"{tag}, n={n}: (P4)")
    # exponential_series_of_even_odd_power_terms の仮定（A = I、B = εG、c = 1_ℂ）と部分和の分け方
    for n in range(0, 11):
        Tn = pk[n]
        if n % 2 == 0:
            rep.check(Tn == S_(kap**n, I), f"{tag}, n={n}: T_n = κ^nI")
        else:
            rep.check(Tn == S_(Rk(1) * kap**n, epsG), f"{tag}, n={n}: T_n = (1_ℂκ^n)(εG)")
    N = 10
    partial = body_finite_sum([S_(Rk(1 / factorial(n)), pk[n]) for n in range(N + 1)])
    even = sum(kap**n / factorial(n) for n in range(0, N + 1, 2))
    odd = sum(kap**n / factorial(n) for n in range(1, N + 1, 2))
    rep.check(partial == A_(S_(even, I), S_(odd, epsG)), f"{tag}: 部分和 Σ_{{n≤{N}}} (1/n!)T_n = (偶数次)I + (奇数次)εG")
    # 否定コントロール: G だけの冪は (εG)^n の型にならない（G^n の奇数冪は G で εG と違う）
    rep.negative(pk[1] != S_(kap, G), f"{tag}: κ(εG) と κG は違う")
    rep.negative(P_(D0, eps) != P_(eps, epsG), f"{tag}: D_0ε と ε(εG) は違う")

# (2) ボールによる主張の独立の確かめ
for M in [2, 3, 4, 5]:
    H1s = H1_plus(M).change_ring(CB)
    n = 2**M
    eps_s = identity_matrix(KG, n)
    for k in range(1, M + 1):
        eps_s = eps_s * kron_sage(site_factors(M, k, SX))
    eps_s = eps_s.change_ring(CB)
    for (K1, K2) in [(QQ(1) / 3, QQ(2) / 5), (QQ(1), QQ(1) / 2), (QQ(7) / 4, QQ(3) / 10)]:
        tag = f"M={M}, K_1={K1}, K_2={K2}"
        iC = CB(0, 1)
        V1 = (iC * RB(K1) * H1s).exp()
        Bh = (iC * RB(K1) / 2 * H1s).exp()
        V2 = matrix(CB, n, n)
        for s in configs(M):
            for sp in configs(M):
                V2[ord_(s) - 1, ord_(sp) - 1] = CB((RB(K2) * sum(s[m] * sp[m] for m in range(M))).exp())
        V = Bh * V2 * Bh
        t = (eps_s * V).trace()
        k1, k2 = RB(K1), RB(K2)
        rhs = (2 * (-k2).exp() * k1.cosh())**M + (2 * k2.exp() * k1.sinh())**M
        rep.check(t.real().overlaps(rhs) and t.imag().contains_zero(), f"{tag}: 主張（ボール）")
        rep.check(rhs > 0, f"{tag}: 右辺 > 0（ボールの下端）")
        rep.check(RB(t.real().rad()) < RB(10)**-30 * RB(abs(rhs.mid())), f"{tag}: ボールの半径が十分小さい")
        rep.negative(not (V.trace()).real().overlaps(rhs), f"{tag}: ε を除いた tr(V^{{(+)}}) は右辺と離れる")
        rep.negative(not t.real().overlaps((2 * k2.exp() * k1.cosh())**M + (2 * (-k2).exp() * k1.sinh())**M),
                     f"{tag}: K_2 の符号を入れ替えた式とは離れる")

# (3) スペクトル射影で組んだ exp と、ComplexBallField の行列の exp（def_exp の級数の値を囲む）を直接比べる
for M in [2, 3]:
    for (p, q) in COUPLINGS:
        T = Setting(M, p, q)
        K1 = 2 * RB(p).log()
        for name, S, exact in [("V_1^{(+)} = exp(K_1(iH_1))", T.iH1, T.V1), ("B = exp((K_1/2)(iH_1))", T.iH1, T.B),
                               ("exp(κD_0)", T.D0, T.expD0), ("exp(κ(εG))", T.epsG, T.expEG)]:
            c = K1 / 2 if name.startswith("B") else K1
            ball = (S.change_ring(CB) * CB(c)).exp()
            rep.check(balls_overlap(ball, exact.change_ring(CB)), f"M={M}, p={p}: スペクトル射影の {name} と行列の exp のボールが重なる")
        rep.negative(balls_disjoint_somewhere((T.D0.change_ring(CB) * CB(K1)).exp(), T.expEG.change_ring(CB)),
                     f"M={M}, p={p}: exp(κD_0) のボールと exp(κ(εG)) は離れる")

rep.finish()
