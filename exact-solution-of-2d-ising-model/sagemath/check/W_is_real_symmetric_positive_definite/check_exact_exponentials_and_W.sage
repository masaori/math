# 対象ラベル: W_is_real_symmetric_positive_definite
# exp を含む行（Step 2・Step 3・可逆性）と主張そのものを、K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選んで厳密に確かめる。
# このとき（共有の準備 transfer_matrix_factor_inverses.sage）
#   B := exp((1/2)K_1D) = Σ_λ y^λ P_λ(D)、B' := exp(−(1/2)K_1D) = Σ_λ y^{−λ} P_λ(D) は QQ（D の固有値 λ は整数）、
#   A := exp(S_2) = exp(K_2^*·iH_2) = Σ_λ (√t)^{−λ} P_λ(iH_2)（t = tanh K_2）と c := (2s_2)^{M/2} = (√(2s_2))^M は AA、
#   V_1・V_2 は def_transfer_matrix の成分 exp(K_1n) = y^{2n}、exp(K_2n) = x^n で QQ
# に乗る。AA の式の木が深くなるのを避けるため、√t・√(2s_2) を含む AA への埋め込みを持つ数体 F（real_field_for）で計算する。
# ℝ への脱出は K_1・K_2 の選び方の一点だけで、以後の等号・不等号は全て AA（と QQbar）の厳密計算である。
# exp の値は def_exp の級数ではなく固有値の射影から作る（独立な経路。部分和の実対称性は check_symbolic_exponents.sage）。
# 正定値性は def_hermitian_positive_definite の x^*Ax ∈ ℝ_{>0}（∀x ≠ 0）を、エルミート性の厳密な等号と、
# 首座小行列式が全て正・特性多項式の係数の符号が交代するの二つの判定（一致を確かめる）で確かめ、具体の x での x^*Ax も見る。
load("_prelude.sage")

for M in range(2, 5):
    n = 2**M
    Id = body_identity(AA, n)
    D = bond_sum(M)
    DQ = matrix(QQ, n, n, [QQ(z) for z in D.list()])   # D の成分は整数（Step 1 で実であることを確かめた）
    for y in [QQ(2), QQ(3)]:
        B = exp_by_spectral_projectors(DQ, lambda lam: y**lam, QQ).change_ring(AA)
        Bp = exp_by_spectral_projectors(DQ, lambda lam: y**(-lam), QQ).change_ring(AA)
        V1 = V1_by_components(M, lambda m: y**(2 * m), AA)
        # def_transfer_matrix_square_root: B = V_1^{1/2}、すなわち BB = V_1（V_1 は成分の定義から、B を経由せずに作る）
        eq(body_product(B, B), V1, f"M={M}, y={y}: BB = V_1")
        # Step 2: B は実対称、エルミート、正定値。B'B = I
        assert entries_are_real(B)
        eq(body_transpose(B), B, f"M={M}, y={y}: B^⊤ = B")
        eq(conj_transpose_exact(B), B, f"M={M}, y={y}: B^* = B")
        assert is_positive_definite_exact(B), (M, y)
        eq(body_product(Bp, B), Id, f"M={M}, y={y}: B'B = I")
        # 可逆性の BB' の鎖: BB' = exp((1/2)K_1D)exp(−(1/2)K_1D)（置き方）
        #   = exp(−(−(1/2)K_1D))exp(−(1/2)K_1D)（matrix_double_negation）= I（exp_of_negative_is_left_inverse）
        DD = body_negation(body_negation(DQ))
        eq(DD, DQ, f"M={M}: −(−D) = D")
        B_line2 = exp_by_spectral_projectors(DD, lambda lam: y**lam, QQ).change_ring(AA)
        eq(body_product(B, Bp), body_product(B_line2, Bp), f"M={M}, y={y}: BB' の鎖の 1→2 行")
        eq(body_product(B_line2, Bp), Id, f"M={M}, y={y}: BB' の鎖の 2→3 行")
        # 否定コントロール: 平方根でない V_1 は BB = V_1 を満たさない（V_1V_1 ≠ V_1）
        neq(body_product(V1, V1), V1, f"M={M}, y={y}: V_1V_1 ≠ V_1")
        # 否定コントロール: 指数の符号を取り違えた B' = exp(−(1/2)K_1D) は B'B' = V_1 を満たさない
        neq(body_product(Bp, Bp), V1, f"M={M}, y={y}: B'B' ≠ V_1")
    for x in [QQ(2), QQ(3)]:
        s2, t = second_coupling_exact(x)
        F, rt, rs = real_field_for(x)
        IdF = body_identity(F, n)
        c = rs**M                                                            # (2s_2)^{M/2} := (√(2s_2))^M
        assert AA(c) == prefactor_exact(M, x)
        SH = iH2_integer_matrix(M)
        A = exp_by_spectral_projectors(SH, lambda lam: rt**(-lam), F)        # exp(K_2^*λ) = (√t)^{−λ}
        Am = exp_by_spectral_projectors(SH, lambda lam: rt**lam, F)          # exp(−K_2^*λ)
        assert A.change_ring(AA) == exp_iK2star_H2_exact(M, x, +1) if M <= 3 else True
        V2 = V2_by_components(M, lambda m: QQ(x)**m, F)
        # Step 2: A は実対称で正定値
        assert entries_are_real(A)
        eq(body_transpose(A), A, f"M={M}, x={x}: A^⊤ = A")
        assert is_positive_definite_exact(A), (M, x)
        # Step 3 の 1 行目の根拠（V2_exponential_representation）: V_2 = ((2s_2)^{M/2})_ℂ A
        eq(V2, body_scalar(c, A), f"M={M}, x={x}: V_2 = cA")
        neq(V2, body_scalar(c**2, A), f"M={M}, x={x}: 係数 (2s_2)^M では外れる")
        # Step 3 の (2s_2)^{M/2} > 0（K_2 > 0 から s_2 > 0）
        assert x > 1 and s2 > 0 and c > 0 and c**2 == (2 * s2)**M
        # Step 3 の V_2^⊤ の鎖 4 行: V_2^⊤ = ((2s_2)^{M/2}A)^⊤ = (2s_2)^{M/2}A^⊤ = (2s_2)^{M/2}A = V_2
        v1 = body_transpose(V2)
        v2 = body_transpose(body_scalar(c, A))
        v3 = body_scalar(c, body_transpose(A))
        v4 = body_scalar(c, A)
        eq(v1, v2, f"M={M}, x={x}: V_2^⊤ の鎖 1→2（V2_exponential_representation）")
        eq(v2, v3, f"M={M}, x={x}: V_2^⊤ の鎖 2→3（transpose_of_matrix_scalar_multiple）")
        eq(v3, v4, f"M={M}, x={x}: V_2^⊤ の鎖 3→4（Step 2 の A^⊤ = A）")
        eq(v4, V2, f"M={M}, x={x}: V_2^⊤ の鎖 4→5（V2_exponential_representation）")
        # Step 3 の成分の実性: V_2 = (2s_2)^{M/2}A（real_scalar_multiple_of_real_entry_matrix_has_real_entries）
        assert entries_are_real(V2)
        # V2_invertible: V_2^{-1} = (c^{-1})_ℂ exp(−S_2)
        V2inv = body_scalar(c**(-1), Am)
        eq(body_product(V2, V2inv), IdF, f"M={M}, x={x}: V_2V_2^{{-1}} = I")
        eq(body_product(V2inv, V2), IdF, f"M={M}, x={x}: V_2^{{-1}}V_2 = I")
        for y in [QQ(2), QQ(3)]:
            B = exp_by_spectral_projectors(DQ, lambda lam: y**lam, QQ).change_ring(F)
            Bp = exp_by_spectral_projectors(DQ, lambda lam: y**(-lam), QQ).change_ring(F)
            W = body_product(body_product(B, V2), B)                          # def_symmetrized_transfer_matrix: W = (BV_2)B
            # Step 3 の W の鎖: W = BV_2B = B(cA)B = c(BAB) = c(B^*AB)
            l1 = W
            l2 = body_product(body_product(B, body_scalar(c, A)), B)
            l3 = body_scalar(c, body_product(body_product(B, A), B))
            l4 = body_scalar(c, body_product(body_product(conj_transpose_exact(B), A), B))
            eq(l1, l2, f"M={M}: W の鎖 1→2（V_2 = cA を代入）")
            eq(l2, l3, f"M={M}: W の鎖 2→3（スカラー倍と行列積の結合則）")
            eq(l3, l4, f"M={M}: W の鎖 3→4（B^* = B）")
            # 続く段落: B^*(AB)（mat_mult_associative で (B^*A)B と同じ行列）は正定値（congruence_preserves_positive_definite）
            BsAB = body_product(conj_transpose_exact(B), body_product(A, B))
            eq(BsAB, body_product(body_product(conj_transpose_exact(B), A), B), f"M={M}: B^*(AB) = (B^*A)B")
            assert is_positive_definite_exact(BsAB), (M, x, y)
            # positive_real_multiple_preserves_positive_definite: W = c(B^*(AB)) は正定値（主張の正定値性）
            assert is_positive_definite_exact(W), (M, x, y)
            # Step 3 の W^⊤ の鎖 7 行:
            # W^⊤ = ((BV_2)B)^⊤ = B^⊤(BV_2)^⊤ = B^⊤(V_2^⊤B^⊤) = B(V_2^⊤B) = B(V_2B) = (BV_2)B = W
            t1 = body_transpose(W)
            t2 = body_transpose(body_product(body_product(B, V2), B))
            t3 = body_product(body_transpose(B), body_transpose(body_product(B, V2)))
            t4 = body_product(body_transpose(B), body_product(body_transpose(V2), body_transpose(B)))
            t5 = body_product(B, body_product(body_transpose(V2), B))
            t6 = body_product(B, body_product(V2, B))
            t7 = body_product(body_product(B, V2), B)
            eq(t1, t2, f"M={M}: 転置の鎖 1→2（W の定義）")
            eq(t2, t3, f"M={M}: 転置の鎖 2→3（transpose_of_matrix_product、A → BV_2, B → B）")
            eq(t3, t4, f"M={M}: 転置の鎖 3→4（transpose_of_matrix_product、A → B, B → V_2）")
            eq(t4, t5, f"M={M}: 転置の鎖 4→5（B^⊤ = B を 2 箇所へ）")
            eq(t5, t6, f"M={M}: 転置の鎖 5→6（V_2^⊤ = V_2）")
            eq(t6, t7, f"M={M}: 転置の鎖 6→7（mat_mult_associative）")
            eq(t7, W, f"M={M}: 転置の鎖 7→8（W の定義）")
            # Step 3 の成分の実性: BV_2、W = (BV_2)B（product_of_real_entry_matrices_has_real_entries を 2 回）
            assert entries_are_real(body_product(B, V2))
            # 積の転置の行が並びの逆転を使っていることの対照: 並びを逆にしない (BV_2)^⊤ ≠ B^⊤V_2^⊤
            neq(body_transpose(body_product(B, V2)), body_product(body_transpose(B), body_transpose(V2)),
                f"M={M}: (BV_2)^⊤ ≠ B^⊤V_2^⊤")
            # 主張: W は成分が実（def_matrix_with_real_entries）で転置について対称
            assert entries_are_real(W)
            # 可逆性: BV_2 ∈ R^×（逆元 V_2^{-1}B'）、W = (BV_2)B ∈ R^×（逆元 B'(V_2^{-1}B')）。def_invertible_elements_of_R (ii)
            BV2 = body_product(B, V2)
            BV2inv = body_product(V2inv, Bp)
            eq(body_product(BV2, BV2inv), IdF, f"M={M}: (BV_2)(V_2^{{-1}}B') = I")
            eq(body_product(BV2inv, BV2), IdF, f"M={M}: (V_2^{{-1}}B')(BV_2) = I")
            eq(W, body_product(BV2, B), f"M={M}: W = (BV_2)B")
            Winv = body_product(Bp, BV2inv)
            eq(body_product(W, Winv), IdF, f"M={M}: WW^{{-1}} = I")
            eq(body_product(Winv, W), IdF, f"M={M}: W^{{-1}}W = I")
            assert W.det() != 0
            # 主張の正定値性を具体の x = u + iv で: x^*Wx ∈ ℝ_{>0}（虚部 0、実部 > 0）
            for (u, v) in [(vector(F, [k + 1 for k in range(n)]), vector(F, [k % 3 - 1 for k in range(n)])),
                           (vector(F, [(-1)**k for k in range(n)]), vector(F, [0] * n)),
                           (vector(F, [0] * n), vector(F, [0] * (n - 1) + [1]))]:
                re, im = quadratic_form_value_split(u, v, W)
                assert im == 0 and re > 0
            # 否定コントロール（直した可逆性の段の理由）: 旧い段の x^⊤Wx = 0 からは x = 0 が従わない。
            # u := e_1、v' := e_2 − (u^⊤We_2 / u^⊤Wu)u、v := v'·√(u^⊤Wu / v'^⊤Wv') とすると u^⊤Wv = 0、v^⊤Wv = u^⊤Wu で、
            # x := u + iv ≠ 0 について x^⊤Wx = u^⊤Wu − v^⊤Wv + 2i u^⊤Wv = 0（一方 x^*Wx > 0）。
            # 平方根を取るので AA で作る（AA の式の木の深さのため M_col ≤ 3）。
            if M <= 3:
                WA = W.change_ring(AA)
                e = [vector(AA, [AA(1) if j == k else AA(0) for j in range(n)]) for k in range(2)]
                u = e[0]
                vp = e[1] - (u * WA * e[1]) / (u * WA * u) * u
                v = vp * ((u * WA * u) / (vp * WA * vp)).sqrt()
                xc = vector(QQbar, [QQbar(a) + QQbar(I) * QQbar(b) for a, b in zip(u, v)])
                assert xc != 0
                assert bilinear_transpose_value(xc, WA.change_ring(QQbar)) == 0
                re, im = quadratic_form_value_split(u, v, WA)
                assert im == 0 and re > 0
                n_neg += 1
            # 否定コントロール: 合同でない BV_2 は対称でない。B(−A)B は正定値でない
            neq(body_transpose(BV2), BV2, f"M={M}: BV_2 は対称でない")
            assert not is_positive_definite_exact(body_product(body_product(B, body_scalar(-1, A)), B))
            n_neg += 1
    print(f"M_col = {M}: x, y ∈ {{2, 3}} で Step 2・Step 3・可逆性の行と主張を厳密に確かめた（累計の等号 {n_steps} 個）")
print(f"等号 {n_steps} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
