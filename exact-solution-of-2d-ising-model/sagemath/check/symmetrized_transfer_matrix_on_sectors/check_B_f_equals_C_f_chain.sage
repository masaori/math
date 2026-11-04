# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# 証明の最初の鎖（f ∈ F^{(+)} について Bf = Cf）の 12 等号を、M_col = 2..4、K_1 ∈ {1/4, 1/2, 1} で一行ずつ確かめる。
#   第 1 行 Bf、第 2 行 exp((1/2)K_1D)f、第 3 行 V_1'f、第 4 行 end(V_1')(f)、
#   第 5 行 end(exp(i((1/2)K_1)(Y_1Z_2+⋯+Y_{M-1}Z_M - Y_MZ_1)))(f)、第 6 行 end(exp(i((1/2)K_1)H_1^{(+)}))(f)、
#   第 7 行 exp(i((1/2)K_1)H_1^{(+)})f、第 8 行 exp((i((1/2)_C(K_1)_C))H_1^{(+)})f（実数の積の像を ℂ の積に）、
#   第 9 行 exp(((i(1/2)_C)(K_1)_C)H_1^{(+)})f（結合律）、第 10 行 exp(((i·2_C^{-1})(K_1)_C)H_1^{(+)})f
#   （real_inclusion_of_one_half_is_inverse_of_two）、第 11 行 exp(((i/2)(K_1)_C)H_1^{(+)})f（def_V1_plus_square_root の i/2 の読み）、
#   第 12 行 exp((i/2)K_1H_1^{(+)})f（スカラー倍の読み）、第 13 行 Cf。
# 厳密: 第 2→3 行は exp((1/2)K_1 n) を不定元 q の冪 q^n に置き、exp((1/2)K_1D) を D の固有値 n ごとの射影子の和
#   Σ q^n P_n で、V_1' を def_transfer_matrix の成分の式で組んで一致を見る。第 5→6 行の和の形と H_1^{(+)}（def_H1_plus）、
#   第 7→8 行の実数の積の像 ((1/2)K_1)_C = (1/2)_C(K_1)_C（QQ → KG の包含で）と、第 8→9・9→10・10→11 行のスカラーの等号は KG で厳密。
# ボール（ℝ への脱出）: exp の値は本文の部分和と尾の上界のボール。各行の数ベクトルのボールが全成分で隣の行と重なることを見る。
#   第 4 行・第 5 行・第 6 行の end は def_end_iso の文言どおりに組んだ写像で計算する。
# 対照: f を εf = -f の数ベクトルに替えると、第 4→5 行（V1_restriction_to_eigenspaces の仮定 f ∈ F^{(+)}）が交わらない成分を持つ。
load("_prelude.sage")
for M in range(2, 5):
    n = 2 ** M
    D = bond_sum(M)
    H = H1_plus(M)
    # 第 5→6 行: 和の形 Y_1Z_2 + ⋯ + Y_{M-1}Z_M - Y_MZ_1 を Sage の `*`・`+`・`-` で組み、H_1^{(+)} と比べる
    S_explicit = sum((jw(M, m, 'y') * jw(M, m + 1, 'z') for m in range(1, M)), matrix(KG, n, n, 0)) - jw(M, M, 'y') * jw(M, 1, 'z')
    assert S_explicit == H
    # 第 2→3 行の厳密版: exp((1/2)K_1 D) = Σ_n q^n P_n と V_1'（成分 q^{Σμ(m)μ(m+1)}）
    Rq = FractionField(PolynomialRing(KG, 'q'))
    q = Rq.gen()
    B_exact = exp_by_spectral_projectors(D.change_ring(QQ), lambda lam: q ** lam, Rq)
    V1p_exact = V1_by_components(M, lambda m: q ** m, Rq)
    assert B_exact == V1p_exact
    END = EndByDefinition(M)
    for K1 in [QQ(1) / 4, QQ(1) / 2, QQ(1)]:
        half_K1 = K1 / 2
        # 第 7→8 行: 実数の積 (1/2)K_1 の像は像どうしの積（QQ ⊂ KG の包含）
        assert KG(QQ(1) / 2 * K1) == KG(QQ(1) / 2) * KG(K1)
        # 第 8→9 行: i((1/2)·K_1) = (i·(1/2))K_1（ℂ の結合律。KG で厳密）
        assert i_K * (KG(QQ(1) / 2) * KG(K1)) == (i_K * KG(QQ(1) / 2)) * KG(K1)
        # 第 9→10 行: (1/2)_C = 2_C^{-1}（real_inclusion_of_one_half_is_inverse_of_two。2_C^{-1} は KG の逆元）
        assert (i_K * KG(QQ(1) / 2)) * KG(K1) == (i_K * KG(2)**(-1)) * KG(K1)
        # 第 10→11 行: i·2_C^{-1} は def_V1_plus_square_root の i/2
        assert (i_K * KG(2)**(-1)) * KG(K1) == (i_K / 2) * KG(K1)
        Bm = exp_ball(KG(half_K1) * D)                                   # 第 2 行の行列 exp((1/2)K_1 D)
        V1p = V1_by_components(M, lambda m: (RB(half_K1) * m).exp(), CB)  # 第 3 行の V_1'（成分の式、exp の値は Sage の実数のボール）
        assert balls_overlap(Bm, V1p)
        R5 = exp_ball(i_K * KG(half_K1) * S_explicit)                     # 第 5 行の exp(i((1/2)K_1)(和の形))
        R6 = exp_ball(i_K * KG(half_K1) * H)                              # 第 6・7 行
        Cm = exp_ball((i_K / 2) * KG(K1) * H)                              # 第 9 行と C（def_V1_plus_square_root）
        for f in even_vectors(M):
            fc = f.change_ring(CB)
            lines = [
                Bm * fc,                    # 1: Bf（B := V_1^{1/2} = exp((1/2)K_1D)）
                Bm * fc,                    # 2: exp((1/2)K_1D)f
                V1p * fc,                   # 3: V_1'f
                END.apply(V1p, fc),         # 4: end(V_1')(f)
                END.apply(R5, fc),          # 5
                END.apply(R6, fc),          # 6
                R6 * fc,                    # 7
                exp_ball(i_K * (KG(QQ(1) / 2) * KG(K1)) * H) * fc,   # 8
                exp_ball((i_K * KG(QQ(1) / 2)) * KG(K1) * H) * fc,   # 9: 結合律
                exp_ball((i_K * KG(2)**(-1)) * KG(K1) * H) * fc,     # 10: (1/2)_C = 2_C^{-1}
                exp_ball(((i_K / 2) * KG(K1)) * H) * fc,            # 11: def_V1_plus_square_root の i/2 の読み
                Cm * fc,                    # 12: スカラー倍の読み
                Cm * fc,                    # 13: Cf
            ]
            for k in range(1, len(lines)):
                assert vec_balls_overlap(lines[k - 1], lines[k]), (M, K1, k)
        # 対照: εf = -f の数ベクトルでは end(V_1')(f) と end(exp(i(K_1/2)H_1^{(+)}))(f) が交わらない成分を持つ
        assert any(vec_balls_disjoint_somewhere(END.apply(V1p, f.change_ring(CB)), END.apply(R5, f.change_ring(CB)))
                   for f in odd_vectors(M))
    print(f"  M_col={M}: 12 等号のボールが F^(+) を張る全ての f で重なる（第 2→3・5→6・7→8・8→9・9→10・10→11 行は厳密に一致）。εf = -f の f では第 4→5 行が崩れる")
print("RESULT: PASS")
