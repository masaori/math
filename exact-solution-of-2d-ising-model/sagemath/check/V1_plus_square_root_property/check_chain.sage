# 対象ラベル: V1_plus_square_root_property（((V_1^{(+)})^{1/2})^2 = V_1^{(+)}、A^2 := AA）
# 証明の準備（XX = XX、c + c = iκ の 10 行）と主張の鎖（9 行）の全ての行を、
# 行に書かれた形のとおりに組んで隣どうしを比べる。
#   - 係数の行と、exp の中身の行列の行は、κ := (K_1)_C を不定元にした KG[κ]（KG = QQ(i)）で厳密に、M_col = 2..5。
#   - exp を含む行（冪の定義・def_V1_plus_square_root・theorem_exp_product・V1_plus_exponential_representation）は、
#     K_1 を有理数 1/3, 1, 7/4 に置き、exp を複素数のボールの行列で囲んで重なりを見る（M_col = 2..4）。
#     exp の値は ℝ への脱出を含む（def_exp は部分和の極限）ので厳密には比べられない。
#   - theorem_exp_product を X, X に当てた行の中身（exp(X)exp(X) と exp(X+X) の t^n の係数が一致すること、
#     Σ_{p+q=n} X^pX^q/(p!q!) = (X+X)^n/n!）は、κ を不定元にしたまま n ≤ 8 で厳密に確かめる。
#   - 主張は Sage の tensor_product・`*`・`-`・ComplexBallField の exp だけの独立な経路でも、M_col = 2..5 で確かめる。
load("_prelude.sage")

rep = Report("V1_plus_square_root_property: 準備と主張の鎖")
i = i_
R = PolynomialRing(KG, 'kappa')
kappa = R.gen()
inv2 = KG(2)**(-1)                                          # complex_numbers_form_a_field の 2_C の逆元
rep.check(KG(2) * inv2 == KG(1) and inv2 * KG(2) == KG(1), "2_C 2_C^{-1} = 2_C^{-1} 2_C = 1_C")
rep.check(iota(QQ(1) / 2) == inv2, "real_inclusion_of_one_half_is_inverse_of_two: (1/2)_C = 2_C^{-1}")

# ---- c + c = iκ の 5 行目が引く one_plus_one_is_two_in_cc（その鎖は sagemath/check/one_plus_one_is_two_in_cc/）
one_C = KG([1, 0])
two_C = iota(2)                                             # 2_C := (2_R)_C（def_V1_plus_square_root）
rep.check(cc_add_pairs(one_C, one_C) == two_C, "one_plus_one_is_two_in_cc: 1_C + 1_C = 2_C")

# ---- 準備: c + c = iκ（κ は不定元）
c = (i * inv2) * kappa
L = [("c + c", c + c),
     ("(i2^{-1})κ + (i2^{-1})κ", (i * inv2) * kappa + (i * inv2) * kappa),
     ("(i2^{-1})(κ + κ)", (i * inv2) * (kappa + kappa)),
     ("(i2^{-1})(κ1 + κ1)", (i * inv2) * (kappa * 1 + kappa * 1)),
     ("(i2^{-1})(κ(1 + 1))", (i * inv2) * (kappa * cc_add_pairs(one_C, one_C))),
     ("(i2^{-1})(κ2_C)", (i * inv2) * (kappa * two_C)),
     ("(i2^{-1})(2_Cκ)", (i * inv2) * (two_C * kappa)),
     ("i(2^{-1}(2_Cκ))", i * (inv2 * (two_C * kappa))),
     ("i((2^{-1}2_C)κ)", i * ((inv2 * two_C) * kappa)),
     ("i(1_Cκ)", i * (one_C * kappa)),
     ("iκ", i * kappa)]
rep.chain(L, "準備 c + c = iκ")
rep.negative(c != i * kappa, "c ≠ iκ（足す前の c は iK でない）")
rep.negative((i * two_C) * kappa + (i * two_C) * kappa != i * kappa, "2^{-1} を 2_C に替えると iκ にならない")

# ---- exp の中身の行列の鎖（厳密、κ は不定元）
for M in range(2, 6):
    H = H1_plus(M).change_ring(R)                           # def_H1_plus
    X = S_(c, H)                                            # X := cH_1^{(+)}
    rep.check(P_(X, X) == P_(X, X), f"M={M} 準備 XX = XX")
    c1, c2 = c, c
    L = [("X + X", A_(X, X)),
         ("cH + cH", A_(S_(c, H), S_(c, H))),
         ("Σ_{j=1}^{2}(c_jH)", F_([S_(c1, H), S_(c2, H)])),
         ("(Σ_{j=1}^{2}c_j)H", S_(complex_finite_sum([c1, c2]), H)),
         ("(c + c)H", S_(c + c, H)),
         ("(iκ)H", S_(i * kappa, H))]
    rep.chain(L, f"M={M} exp の中身の鎖")
    # def_finite_sum_of_matrices の r = 2 の段: Σ_{j=1}^{2}X_j = (Σ_{j=1}^{1}X_j) + X_2 = X_1 + X_2
    rep.check(F_([S_(c1, H), S_(c2, H)]) == A_(F_([S_(c1, H)]), S_(c2, H)), f"M={M} def_finite_sum_of_matrices (r=2)")
    # finite_sum_of_scalar_multiples_of_one_matrix の r = 2 を、関係の無い二つの不定元の係数でも確かめる
    R2 = PolynomialRing(KG, 'a,b')
    a, b = R2.gens()
    H2 = H1_plus(M).change_ring(R2)
    rep.check(F_([S_(a, H2), S_(b, H2)]) == S_(complex_finite_sum([a, b]), H2), f"M={M} finite_sum_of_scalar_multiples_of_one_matrix (r=2)")
    # V1_plus_exponential_representation の右辺の中身 (iκ)H と、def_V1_plus の中身 iκ(Σ Y_mZ_{m+1} − Y_MZ_1)
    terms = [P_(jw(M, m, 'y'), jw(M, m + 1, 'z')).change_ring(R) for m in range(1, M)]
    YMZ1 = P_(jw(M, M, 'y'), jw(M, 1, 'z')).change_ring(R)
    rep.check(S_(i * kappa, D_(F_(terms), YMZ1)) == S_(i * kappa, H), f"M={M} def_V1_plus の中身 = (iκ)H_1^{{(+)}}")
    rep.negative(A_(X, X) != X, f"M={M} X + X ≠ X")
    rep.negative(S_(i * kappa, H) != S_(c, H), f"M={M} (iκ)H ≠ cH")

# ---- theorem_exp_product を X, X に当てた行の中身（厳密、κ は不定元、n ≤ 8）
for M in range(2, 4):
    H = H1_plus(M).change_ring(R)
    X = S_(c, H)
    n_ = X.nrows()
    pw = [body_identity(R, n_)]                             # X^0 := I、X^{p+1} := X^pX
    for p in range(8):
        pw.append(P_(pw[-1], X))
    Y2 = A_(X, X)
    pw2 = [body_identity(R, n_)]
    for p in range(8):
        pw2.append(P_(pw2[-1], Y2))
    for n in range(9):
        lhs = F_([S_(R(1) / (factorial(p) * factorial(n - p)), P_(pw[p], pw[n - p])) for p in range(n + 1)])
        rhs = S_(R(1) / factorial(n), pw2[n])
        rep.check(lhs == rhs, f"M={M} t^{n} の係数: Σ_{{p+q={n}}} X^pX^q/(p!q!) = (X+X)^{n}/{n}!")
    # 否定コントロール: 可換でない X, W では t^2 の係数が合わない
    W = S_(i * kappa, jw(M, 1, 'y').change_ring(R))
    rep.negative(P_(X, W) != P_(W, X), f"M={M} X と W := (iκ)Y_1 は可換でない")
    XW = A_(X, W)
    lhs2 = F_([S_(R(1) / 2, P_(X, X)), P_(X, W), S_(R(1) / 2, P_(W, W))])
    rhs2 = S_(R(1) / 2, P_(XW, XW))
    rep.negative(lhs2 != rhs2, f"M={M} 可換でない X, W では t^2 の係数が一致しない")

# ---- exp を含む行（ボール）
ov = balls_overlap
for M in range(2, 5):
    H = H1_plus(M)
    for K1 in [QQ(1) / 3, QQ(1), QQ(7) / 4]:
        Kq = iota(K1)
        cq = (i * inv2) * Kq
        X = S_(cq, H)
        E = exp_ball(X)                                     # (V_1^{(+)})^{1/2} = exp(cH)（def_V1_plus_square_root）
        terms = [P_(jw(M, m, 'y'), jw(M, m + 1, 'z')) for m in range(1, M)]
        V1 = exp_ball(S_(i * Kq, D_(F_(terms), P_(jw(M, M, 'y'), jw(M, 1, 'z')))))   # def_V1_plus
        L = [("((V_1^{(+)})^{1/2})^2", E ** 2),
             ("(V_1^{(+)})^{1/2}(V_1^{(+)})^{1/2}", P_(E, E)),
             ("exp(X)exp(X)", P_(exp_ball(X), exp_ball(X))),
             ("exp(X + X)", exp_ball(A_(X, X))),
             ("exp(cH + cH)", exp_ball(A_(S_(cq, H), S_(cq, H)))),
             ("exp(Σ_{j=1}^{2}(c_jH))", exp_ball(F_([S_(cq, H), S_(cq, H)]))),
             ("exp((Σ_{j=1}^{2}c_j)H)", exp_ball(S_(complex_finite_sum([cq, cq]), H))),
             ("exp((c + c)H)", exp_ball(S_(cq + cq, H))),
             ("exp((iκ)H)", exp_ball(S_(i * Kq, H))),
             ("V_1^{(+)}", V1)]
        rep.chain(L, f"M={M} K_1={K1} 主張の鎖", eq=ov)
        rep.negative(balls_disjoint_somewhere(E, V1), f"M={M} K_1={K1} (V_1^{{(+)}})^{{1/2}} ≠ V_1^{{(+)}}")
        rep.negative(balls_disjoint_somewhere(E ** 2, exp_ball(S_(2 * i * Kq, H))), f"M={M} K_1={K1} 二乗は exp(2iκH) でない")
        W = S_(i * Kq, jw(M, 1, 'y'))
        rep.negative(balls_disjoint_somewhere(P_(exp_ball(X), exp_ball(W)), exp_ball(A_(X, W))),
                     f"M={M} K_1={K1} 可換でない X, W では exp(X)exp(W) ≠ exp(X + W)")

# ---- 主張を Sage の経路だけで（tensor_product・`*`・`-`・CB の exp）
for M in range(2, 6):
    sx = lambda k: kron_sage(site_factors(M, k, SX))
    sp = lambda k, A: kron_sage(site_factors(M, k, A))
    def jw_sage(m, A):
        P = identity_matrix(KG, 2**M)
        for k in range(1, m):
            P = P * sx(k)
        return P * sp(m, A)
    Hs = sum((jw_sage(m, SY) * jw_sage(m + 1, SZ) for m in range(1, M)), matrix(KG, 2**M, 2**M)) - jw_sage(M, SY) * jw_sage(1, SZ)
    rep.check(Hs == H1_plus(M), f"M={M} Sage の経路の H_1^{{(+)}} = 本文の経路の H_1^{{(+)}}")
    for K1 in [QQ(1) / 3, QQ(7) / 4]:
        half = (i * K1 / 2 * Hs).change_ring(CB).exp()
        full = (i * K1 * Hs).change_ring(CB).exp()
        rep.check(ov(half * half, full), f"M={M} K_1={K1} Sage の経路の主張")

rep.finish()
