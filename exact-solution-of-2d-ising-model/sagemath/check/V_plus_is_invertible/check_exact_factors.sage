# 対象ラベル: V_plus_is_invertible
# 証明の Step 1〜3 の全ての行と主張そのものを、実際の指数行列 E_± := exp(±(1/2)S_1^(+))、A_± := exp(±S_2) で厳密に確かめる。
# (a) Step 1 の肩の行 −(−X_1) = X_1、−(−S_2) = S_2（matrix_double_negation）は、K_1・K_2^* を
#     KG = QQ(i) 上の実の不定元にした多項式環で（任意の実数の K_1・K_2^* について成り立つ形で）確かめる。
#     符号反転は def_matrix_negation の成分の式（body_negation）で組む。
# (b) exp を含む行は K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選んで厳密に作る（共有の準備
#     transfer_matrix_factor_inverses.sage。V_plus_is_positive_definite の検算と同じ置き方）。
#     X_1 = (log y)·S（S := iH_1^(+) は整数の固有値をもつ整数行列）なので、exp(X_1)・exp(−X_1)・exp(−(−X_1)) を、
#     肩の行列 S・−S・−(−S)（body_negation で組む）の固有値 λ の射影に y^λ を掛けて QQ で作る（−S の射影は実際に計算する。
#     −(−S) は S と成分まで同じ行列なので exp(−(−X_1)) = exp(X_1) は構成上一致し、その行の中身は (a) の −(−A) = A が受け持つ）。A_± も S' := iH_2 で同じく (√t)^{−λ}（t = tanh K_2）を掛けて AA で。
#     作った E_±・A_± が共有の準備の exp_V1_half_exact・exp_iK2star_H2_exact と一致することも確かめる。
#     a := (2s_2)^{M/2} = (√(2s_2))^M は AA、a^{-1} は主張の置き方どおり a の ℝ の逆数で、別の経路の √((2s_2)^{-M}) と一致することも見る。
#     ℂ の係数 a_C・(a^{-1})_C は inclusion_rr_to_cc の (r, 0) を確かめた QQbar の元で、鎖の行列は QQbar で持つ。
#     ℝ への脱出は K_1・K_2 の選び方の一点だけで、以後の等号は全て厳密計算である。
#     exp の値は def_exp の級数ではなく固有値の射影から作る（独立な経路。def_exp の部分和による値は
#     check_balls_by_partial_sums.sage が受け持つ）。積は mat_mult の成分の式（body_product）で、本文の括弧どおりに組む。
load("_prelude.sage")

n_steps = 0
n_neg = 0


def eq(a, b, what):
    global n_steps
    assert a == b, what
    n_steps += 1


def neq(a, b, what):
    global n_neg
    assert a != b, what
    n_neg += 1


def check_chain(lines, what):
    for r in range(len(lines) - 1):
        eq(lines[r], lines[r + 1], f"{what}: {r + 1} 行目 → {r + 2} 行目")


# (a) Step 1 の肩の行 −(−X_1) = X_1、−(−S_2) = S_2
P.<K1, K2s> = PolynomialRing(KG)
iP = P(i_K)
for M in range(2, 6):
    n = 2**M
    S1 = body_scalar(iP * K1, H1_plus(M).change_ring(P))
    S2 = body_scalar(iP * K2s, H2(M).change_ring(P))
    X1 = body_scalar(P(1) / 2, S1)
    eq(body_negation(body_negation(X1)), X1, f"M={M}: −(−X_1) = X_1")
    eq(body_negation(body_negation(S2)), S2, f"M={M}: −(−S_2) = S_2")
    # E_- の肩 −X_1 は主張の −(1/2)S_1^(+)（def_matrix_negation の符号反転）。(−1/2) 倍のスカラー倍とも一致する
    eq(body_negation(X1), body_scalar(P(-1) / 2, S1), f"M={M}: −((1/2)S_1) = (−1/2)S_1")
    # 否定コントロール: −X_1 ≠ X_1、−S_2 ≠ S_2（符号反転を一回だけ施すと元に戻らない）
    neq(body_negation(X1), X1, f"M={M}: −X_1 ≠ X_1")
    neq(body_negation(S2), S2, f"M={M}: −S_2 ≠ S_2")
print(f"(a) M_col = 2..5: Step 1 の二重符号反転の行を KG[K_1, K_2^*] で厳密に確かめた（等号 {n_steps} 個）")

a_steps = n_steps
for M in range(2, 5):
    n = 2**M
    IdQ = body_identity(KQ, n)
    S1i = iH1_plus_integer_matrix(M)            # iH_1^(+)（X_1 = (log y)·S1i）
    S2i = iH2_integer_matrix(M)                 # iH_2（S_2 = K_2^*·S2i）
    for x in [QQ(2), QQ(3)]:
        s2, t = second_coupling_exact(x)
        a = prefactor_exact(M, x)                          # (2s_2)^{M/2} ∈ ℝ
        assert a > 0                                       # a ∈ ℝ_{>0}（def_second_transfer_matrix_prefactor）
        ainv = a ** -1                                     # 主張の (2s_2)^{-M/2} := a の ℝ の逆数
        assert ainv == AA((2 * s2) ** (-M)).sqrt()         # 別の経路 √((2s_2)^{-M}) と一致
        assert a * ainv == 1 and ainv * a == 1
        aC, ainvC = iota_exact(a), iota_exact(ainv)
        assert iota_exact(a * ainv) == aC * ainvC and iota_exact(ainv * a) == ainvC * aC   # real_inclusion_preserves_product
        oneC = iota_exact(AA(1))
        assert oneC == KQ(1)                               # 1_C は (1)_C の略記
        rt = AA(t).sqrt()
        expA = lambda T: to_QQbar(exp_by_spectral_projectors(T, lambda lam: rt ** (-lam), AA))   # exp(K_2^* T)
        Ap = expA(S2i)
        Am = expA(body_negation(S2i))
        Ap_nn = expA(body_negation(body_negation(S2i)))       # exp(−(−S_2))
        assert Ap == to_QQbar(exp_iK2star_H2_exact(M, x, +1)) and Am == to_QQbar(exp_iK2star_H2_exact(M, x, -1))
        V2 = to_QQbar(V2_components_exact(M, x))
        for y in [QQ(2), QQ(3)]:
            expE = lambda T: to_QQbar(exp_by_spectral_projectors(T, lambda lam: y ** lam, QQ))      # exp((log y) T)
            Ep = expE(S1i)
            Em = expE(body_negation(S1i))
            Ep_nn = expE(body_negation(body_negation(S1i)))   # exp(−(−X_1))
            assert Ep == to_QQbar(exp_V1_half_exact(M, y, +1)) and Em == to_QQbar(exp_V1_half_exact(M, y, -1))
            # ---- Step 1 の四つの鎖
            # E_+E_- = exp(X_1)exp(−X_1) = exp(−(−X_1))exp(−X_1)（matrix_double_negation）= I（exp_of_negative_is_left_inverse）
            check_chain([body_product(Ep, Em), body_product(Ep_nn, Em), IdQ], f"M={M}, x={x}, y={y}: Step 1 の E_+E_-")
            # E_-E_+ = exp(−X_1)exp(X_1) = I（exp_of_negative_is_left_inverse）
            check_chain([body_product(Em, Ep), IdQ], f"M={M}, x={x}, y={y}: Step 1 の E_-E_+")
            check_chain([body_product(Ap, Am), body_product(Ap_nn, Am), IdQ], f"M={M}, x={x}, y={y}: Step 1 の A_+A_-")
            check_chain([body_product(Am, Ap), IdQ], f"M={M}, x={x}, y={y}: Step 1 の A_-A_+")
            # 否定コントロール: 同じ符号どうしの積は I にならない
            neq(body_product(Ep, Ep), IdQ, f"M={M}: E_+E_+ ≠ I")
            neq(body_product(Ap, Ap), IdQ, f"M={M}: A_+A_+ ≠ I")
            # ---- 主張の V^{(+)} と R^{(+)} の表示（左の 2 因子を先に掛ける）
            core_V = body_product(body_product(Ep, Ap), Ep)            # (E_+A_+)E_+
            core_R = body_product(body_product(Em, Am), Em)            # (E_-A_-)E_-
            Vp = body_scalar(aC, core_V)
            Rp = body_scalar(ainvC, core_R)
            # V^{(+)} の表示は V_plus_is_positive_definite の主張（def_V_plus の (V_1^(+))^{1/2}V_2(V_1^(+))^{1/2} と一致）
            eq(body_product(body_product(Ep, V2), Ep), Vp, f"M={M}: def_V_plus = a_C((E_+A_+)E_+)")
            # ---- Step 2 の 18 行（等号 17 個）
            X = core_V
            Y = core_R
            step2 = [
                body_product(Vp, Rp),                                                        # V^{(+)}R^{(+)}
                body_product(body_scalar(aC, X), body_scalar(ainvC, Y)),                       # 表示
                body_scalar(aC, body_product(X, body_scalar(ainvC, Y))),                       # left_factor
                body_scalar(aC, body_scalar(ainvC, body_product(X, Y))),                       # right_factor
                body_scalar(aC * ainvC, body_product(X, Y)),                                   # scalar_multiple_is_associative
                body_scalar(iota_exact(a * ainv), body_product(X, Y)),                         # real_inclusion_preserves_product
                body_scalar(iota_exact(AA(1)), body_product(X, Y)),                            # ℝ で aa^{-1} = 1
                body_scalar(KQ(1), body_product(X, Y)),                                        # 1_C の略記
                body_product(X, Y),                                                            # scalar_multiple_by_one
                body_product(body_product(X, body_product(Em, Am)), Em),                       # 結合律
                body_product(body_product(body_product(Ep, Ap), body_product(Ep, body_product(Em, Am))), Em),   # 結合律
                body_product(body_product(body_product(Ep, Ap), body_product(body_product(Ep, Em), Am)), Em),   # 結合律
                body_product(body_product(body_product(Ep, Ap), body_product(IdQ, Am)), Em),   # Step 1 の第一
                body_product(body_product(body_product(Ep, Ap), Am), Em),                      # 左単位元
                body_product(body_product(Ep, body_product(Ap, Am)), Em),                      # 結合律
                body_product(body_product(Ep, IdQ), Em),                                       # Step 1 の第三
                body_product(Ep, Em),                                                          # 右単位元
                IdQ,                                                                           # Step 1 の第一
            ]
            check_chain(step2, f"M={M}, x={x}, y={y}: Step 2")
            # ---- Step 3 の 18 行（等号 17 個）
            step3 = [
                body_product(Rp, Vp),
                body_product(body_scalar(ainvC, Y), body_scalar(aC, X)),
                body_scalar(ainvC, body_product(Y, body_scalar(aC, X))),
                body_scalar(ainvC, body_scalar(aC, body_product(Y, X))),
                body_scalar(ainvC * aC, body_product(Y, X)),
                body_scalar(iota_exact(ainv * a), body_product(Y, X)),
                body_scalar(iota_exact(AA(1)), body_product(Y, X)),
                body_scalar(KQ(1), body_product(Y, X)),
                body_product(Y, X),
                body_product(body_product(Y, body_product(Ep, Ap)), Ep),
                body_product(body_product(body_product(Em, Am), body_product(Em, body_product(Ep, Ap))), Ep),
                body_product(body_product(body_product(Em, Am), body_product(body_product(Em, Ep), Ap)), Ep),
                body_product(body_product(body_product(Em, Am), body_product(IdQ, Ap)), Ep),
                body_product(body_product(body_product(Em, Am), Ap), Ep),
                body_product(body_product(Em, body_product(Am, Ap)), Ep),
                body_product(body_product(Em, IdQ), Ep),
                body_product(Em, Ep),
                IdQ,
            ]
            check_chain(step3, f"M={M}, x={x}, y={y}: Step 3")
            # ---- 主張そのもの: def_V_plus から作った V^{(+)} と主張の R^{(+)} を Sage の `*`・inverse（独立な経路）で
            Vdef = body_product(body_product(Ep, V2), Ep)
            Rclaim = ainvC * (Em * Am * Em)
            eq(Vdef * Rclaim, identity_matrix(KQ, n), f"M={M}: V^(+)R^(+) = I（Sage の積）")
            eq(Rclaim * Vdef, identity_matrix(KQ, n), f"M={M}: R^(+)V^(+) = I（Sage の積）")
            eq(Vdef.inverse(), Rclaim, f"M={M}: (V^(+))^{{-1}} = R^(+)（Sage の inverse）")
            # 否定コントロール: 係数を a にしたもの、A_- を A_+ にしたもの、因子の順を E_-E_-A_- にしたもの
            neq(Vdef * (aC * (Em * Am * Em)), identity_matrix(KQ, n), f"M={M}: 係数 a では外れる")
            neq(Vdef * (ainvC * (Em * Ap * Em)), identity_matrix(KQ, n), f"M={M}: A_+ では外れる")
            neq(Vdef * (ainvC * (Em * Em * Am)), identity_matrix(KQ, n), f"M={M}: E_-E_-A_- では外れる")
    print(f"(b) M_col = {M}: x, y ∈ {{2, 3}} で Step 1〜3 の行と主張を厳密に確かめた")
print(f"等号 {n_steps} 個（うち (b) {n_steps - a_steps} 個）、否定コントロール {n_neg} 件")
print("RESULT: PASS")
