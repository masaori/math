# 対象ラベル: eigenvalues_of_V_plus
# eigenvalues_of_V_plus (2) の Λ̌_maxΛ̌_min の鎖を確かめる。
#   積の鎖（20 行）: Λ̌_maxΛ̌_min = (A exp(½Σγ_μ))Λ̌_min = (A exp(½Σγ_μ))(A exp(−½Σγ_μ)) = (A e^b)(A e^{−b})
#     = ((2s_2)^{M/2}e^b)((2s_2)^{M/2}e^{−b}) = (a e^b)(a e^{−b}) = a(e^b(a e^{−b})) = a((e^b a)e^{−b}) = a((a e^b)e^{−b})
#     = a(a(e^b e^{−b})) = (aa)(e^b e^{−b}) = (aa)exp(b + (−b)) = (aa)exp(0) = (aa)·1 = aa
#     = (2s_2)^{M/2}(2s_2)^{M/2} = A·A = (√(2 sinh 2K_2))^M(√(2 sinh 2K_2))^M = (√·√)^M = ((√)^2)^M = (2 sinh 2K_2)^M
#     （A := (2 sinh 2K_2)^{M/2}、b := ½Σγ_μ、a := (2s_2)^{M/2}、s_2 = sinh 2K_2）
#   c の鎖（8 行）: (Λ̌_maxΛ̌_min)_ℂ = (aa)_ℂ = a_ℂa_ℂ = ((2s_2)^{M/2})_ℂ((2s_2)^{M/2})_ℂ = cc = (1_ℂc)c = (c^0c)c = c^1c = c^2
# 確かめ方:
#   (I) 積の鎖の全 20 行を K_2・γ_μ を記号のまま SR で、行に書いた括弧どおりに組み、隣どうしの差が 0 になることを見る（M_col = 2..8）。
#   (II) 同じ 20 行を、有理数の K_2 > 0 と有理数の γ_μ（負も含む）について RealBallField（200 ビット）で、行に書いた演算の順に計算し、
#        隣どうしの差の球が 0 を含むことを見る（exp・sinh・√ は ℝ への脱出なので球で比べる）。最後の行と 1 行目の差の球の半径も見る。
#   (III) c の鎖の 4〜8 行目は、c を QQ 上の多項式環の不定元に置き、冪を def_power_of_complex_number の帰納法（z^0 := 1、z^{m+1} := z^m z）
#        で作って隣どうしを比べる。1〜4 行目は (II) と同じ数で ComplexBallField の球で比べる（c := ((2s_2)^{M/2})_ℂ）。
# 否定コントロール: (i) Λ̌_min の指数の符号を落とすと、積が (2 sinh 2K_2)^M から外れる。
#                    (ii) 20 行目の √ の 2 乗を √ にする（definition_of_sqrt_r_positive を外す）と外れる。
#                    (iii) c を a ではなく aa（c := ((2s_2)^{M})_ℂ）と取り違えると c の鎖の 4 行目が外れる。
#                    (iv) 冪の帰納法を z^{m+1} := z z^m ではなく z^{m+1} := z^m + z と誤ると 8 行目が外れる。
# 帰属: (I) は SR の記号式（厳密）、(II) は RealBallField / ComplexBallField（ℝ・ℂ への脱出）、(III) は QQ[c]（厳密）。

half = QQ(1) / 2
R = RealBallField(200)
C = ComplexBallField(200)


def fsum(rs):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


def product_chain(K2, gs, M, sinh_, exp_, sqrt_, pw_half, pw_nat, zero):
    """積の鎖の 20 行を、行に書いた括弧どおりに組む。"""
    s2 = sinh_(2 * K2)                       # def_indexed_hyperbolic_abbreviations（i → 2）
    A = pw_half(2 * sinh_(2 * K2))           # (2 sinh 2K_2)^{M/2}
    a = pw_half(2 * s2)                      # a の置き方
    S = fsum(gs)
    b = half * S                             # b の置き方
    Lmax = A * exp_(half * S)                # 上の Λ̌_max の鎖の値
    Lmin = A * exp_(-(half * S))             # 上の Λ̌_min の鎖の値
    rt = sqrt_(2 * sinh_(2 * K2))
    return [
        Lmax * Lmin,
        (A * exp_(half * S)) * Lmin,                       # 1: Λ̌_max の鎖
        (A * exp_(half * S)) * (A * exp_(-(half * S))),    # 2: Λ̌_min の鎖
        (A * exp_(b)) * (A * exp_(-b)),                    # 3: b の置き方
        (pw_half(2 * s2) * exp_(b)) * (pw_half(2 * s2) * exp_(-b)),   # 4: s_2
        (a * exp_(b)) * (a * exp_(-b)),                    # 5: a の置き方
        a * (exp_(b) * (a * exp_(-b))),                    # 6: 結合律
        a * ((exp_(b) * a) * exp_(-b)),                    # 7: 結合律
        a * ((a * exp_(b)) * exp_(-b)),                    # 8: 交換律
        a * (a * (exp_(b) * exp_(-b))),                    # 9: 結合律
        (a * a) * (exp_(b) * exp_(-b)),                    # 10: 結合律
        (a * a) * exp_(b + (-b)),                          # 11: scalar_exp_product
        (a * a) * exp_(zero),                              # 12: b + (−b) = 0
        (a * a) * 1,                                       # 13: scalar_exp_zero
        a * a,                                             # 14: u·1 = u
        pw_half(2 * s2) * pw_half(2 * s2),                 # 15: a の置き方
        A * A,                                             # 16: s_2 = sinh 2K_2
        pw_nat(rt, M) * pw_nat(rt, M),                     # 17: def_second_transfer_matrix_prefactor
        pw_nat(rt * rt, M),                                # 18: (uv)^m = u^m v^m
        pw_nat(pw_nat(rt, 2), M),                          # 19: y^2 = yy
        pw_nat(2 * sinh_(2 * K2), M),                      # 20: definition_of_sqrt_r_positive
    ]


def npow(z, m, one):
    """def_power_of_complex_number（ℝ の冪も同じ帰納法）: z^0 := 1、z^{m+1} := z^m z。"""
    p = one
    for _ in range(m):
        p = p * z
    return p


eq_sr = 0
eq_ball = 0
eq_c = 0
neg = 0
K2s = [QQ(1) / 3, QQ(1) / 2, QQ(7) / 5]
for M in range(2, 9):
    # (I) SR
    K2 = var("K2")
    gs = [var("gamma%d" % mu) for mu in range(M)]
    lines = product_chain(K2, gs, M, sinh, exp, sqrt,
                          lambda x: sqrt(x) ** M, lambda x, m: npow(x, m, 1), SR(0))
    for x, y in zip(lines, lines[1:]):
        assert bool((x - y).simplify_full() == 0), ("SR", M)
        eq_sr += 1
    # 否定コントロール (v): 19→20 行目の比較に、指数を 1 つずらした行を差し込むと SR の比較が落ちる
    assert not bool((lines[19] - npow(2 * sinh(2 * K2), M + 1, 1)).simplify_full() == 0), ("neg v", M)
    neg += 1
    # (II) RealBallField
    for K2v in K2s:
        for seed in range(3):
            gv = [R(QQ((-1) ** (mu + seed) * (mu + 1 + seed)) / (mu + 2)) for mu in range(M)]
            k2 = R(K2v)
            L = product_chain(k2, gv, M, lambda x: x.sinh(), lambda x: x.exp(), lambda x: x.sqrt(),
                              lambda x: x.sqrt() ** M, lambda x, m: npow(x, m, R(1)), R(0))
            for x, y in zip(L, L[1:]):
                assert (x - y).contains_zero(), ("ball", M, K2v)
                eq_ball += 1
            assert (L[0] - L[-1]).rad() < RR(2) ** (-150)
            # 否定コントロール (i): Λ̌_min の指数の符号を落とす
            Sg = fsum(gv)
            A = (2 * (2 * k2).sinh()).sqrt() ** M
            wrong = (A * (half * Sg).exp()) * (A * (half * Sg).exp())
            if Sg != 0:
                assert not (wrong - L[-1]).contains_zero(), ("neg i", M)
                neg += 1
            # 否定コントロール (ii): √ の 2 乗を √ にする
            rt = (2 * (2 * k2).sinh()).sqrt()
            assert not (npow(rt, M, R(1)) - L[-1]).contains_zero(), ("neg ii", M)
            neg += 1
            # (III) c の鎖の 1〜4 行目（ComplexBallField）
            a = (2 * (2 * k2).sinh()).sqrt() ** M          # a = (2s_2)^{M/2}
            c = C(a)                                        # constant_c_value_even_sector: c = a_ℂ
            cl = [
                C(L[0]),                     # (Λ̌_maxΛ̌_min)_ℂ
                C(a * a),                    # 1: Λ̌_maxΛ̌_min = aa
                C(a) * C(a),                 # 2: real_inclusion_preserves_product
                C(a) * C(a),                 # 3: a の置き方（同じ式）
                c * c,                       # 4: constant_c_value_even_sector
            ]
            for x, y in zip(cl, cl[1:]):
                assert (x - y).contains_zero(), ("cball", M)
                eq_ball += 1
            # 否定コントロール (iii): c を aa と取り違える
            cw = C(a * a)
            assert not (cw * cw - cl[1]).contains_zero(), ("neg iii", M)
            neg += 1
    # (III) c の鎖の 4〜8 行目（QQ[c]）
    P = PolynomialRing(QQ, "c")
    cc = P.gen()
    one = P(1)
    cl = [
        cc * cc,                                   # 4
        (one * cc) * cc,                           # 5: 1_ℂ z = z を右辺から左辺へ
        (npow(cc, 0, one) * cc) * cc,              # 6: z^0 := 1_ℂ
        npow(cc, 1, one) * cc,                     # 7: z^{m+1} := z^m z（m → 0）
        npow(cc, 2, one),                          # 8: z^{m+1} := z^m z（m → 1）
    ]
    for x, y in zip(cl, cl[1:]):
        assert x == y
        eq_c += 1
    # 否定コントロール (iv): 冪の帰納法を z^{m+1} := z^m + z と誤る
    wrong_pow = lambda z, m: (one if m == 0 else wrong_pow(z, m - 1) + z)
    assert wrong_pow(cc, 2) != cl[0]
    neg += 1

print("eigenvalues_of_V_plus (2) の Λ̌_maxΛ̌_min の鎖: SR の等号 %d 段、球の比較 %d 段、QQ[c] の等号 %d 段、否定コントロール %d 件 PASS"
      % (eq_sr, eq_ball, eq_c, neg))
print("RESULT: PASS")
