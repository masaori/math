# 対象ラベル: V_plus_is_positive_definite
# 証明の Step 1〜3 の全ての行と主張そのものを厳密に確かめる。
# (a) 指数の肩の行（S_1^(+) := iK_1H_1^(+)、S_2 := iK_2^*H_2 の書き換え）と Step 2 のエルミート性は、K_1・K_2^* を
#     KG = QQ(i) 上の実の不定元にした多項式環で（任意の実数の K_1・K_2^* について成り立つ形で）確かめる。
# (b) exp を含む行は K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}）と選んで厳密に作る（共有の準備
#     transfer_matrix_factor_inverses.sage）。このとき B := exp((1/2)S_1^(+)) = Σ_λ y^λ P_λ は QQ、
#     A := exp(S_2) = Σ_λ (√t)^{-λ} P_λ（t = tanh K_2）と係数 (2s_2)^{M/2} = (√(2s_2))^M は AA、V_2 は成分の定義で QQ に乗る。
#     ℝ への脱出は K_1・K_2 の選び方の一点だけで、以後の等号・不等号は全て AA の厳密計算である。
#     exp の値は def_exp の級数ではなく固有値の射影から作る（独立な経路。def_exp の部分和による値は
#     check_balls_by_partial_sums.sage が受け持つ）。
# 正定値性は def_hermitian_positive_definite の x^*Ax > 0（∀x ≠ 0）を、エルミート性の厳密な等号と、
# 首座小行列式が全て正・特性多項式の係数の符号が交代するの二つの判定（一致を確かめる）で確かめ、具体の x での x^*Ax も見る。
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


P.<K1, K2s, L> = PolynomialRing(KG)   # 実の不定元（係数の共役で複素共役を取る）
iP = P(i_K)

for M in range(2, 6):
    n = 2**M
    H1 = H1_plus(M).change_ring(P)
    H2m = H2(M).change_ring(P)
    # Step 1 の (V_1^(+))^{1/2} の鎖: 肩 (i/2)K_1H_1^(+)（def_V1_plus_square_root）= (1/2)S_1^(+)（S_1^(+) = iK_1H_1^(+)）
    S1 = body_scalar(iP * K1, H1)
    eq(body_scalar(iP / 2 * K1, H1), body_scalar(P(1) / 2, S1), f"M={M}: (i/2)K_1H_1 = (1/2)S_1")
    # Step 1 の V_2 の鎖の 2 行目（S_2 = iK_2^*H_2）は S_2 の定義を書くだけの行で、確かめる中身が無い（比べない）
    S2 = body_scalar(iP * K2s, H2m)
    # Step 2: S_1^(+)・S_2 は実対称（成分の係数の虚部が 0、転置で不変）、よってエルミート。(1/2)S_1^(+) もエルミート。
    for (name, S) in [("S_1", S1), ("S_2", S2)]:
        assert all(c.imag() == 0 for z in S.list() for c in z.coefficients()), name
        eq(body_transpose(S), S, f"M={M}: {name} の転置")
        eq(conj_transpose_exact(S), S, f"M={M}: {name}^* = {name}")
    half_S1 = body_scalar(P(1) / 2, S1)
    eq(conj_transpose_exact(half_S1), half_S1, f"M={M}: ((1/2)S_1)^* = (1/2)S_1")
    # 否定コントロール: i を掛けない H_1^(+) はエルミートでない（H_1^* = -H_1）
    neq(conj_transpose_exact(H1), H1, f"M={M}: H_1 はエルミートでない")
    # K_1 := 2L（L = log y）のとき (1/2)S_1^(+) = L·(iH_1^(+))（下の厳密な exp の肩）
    eq(half_S1.subs(K1=2 * L), body_scalar(L, body_scalar(iP, H1)), f"M={M}: (1/2)S_1 = L·iH_1")
print(f"(a) M_col = 2..5: 肩の書き換えと Step 2 のエルミート性を KG[K_1, K_2^*] で厳密に確かめた（等号 {n_steps} 個）")

a_steps = n_steps
for M in range(2, 5):
    n = 2**M
    Id = body_identity(AA, n)
    for x in [QQ(2), QQ(3)]:
        s2, t = second_coupling_exact(x)
        c = prefactor_exact(M, x)
        A = exp_iK2star_H2_exact(M, x, +1)
        V2 = V2_components_exact(M, x)
        # Step 1 の V_2 の鎖の 1 行目（V2_exponential_representation）: V_2 = ((2s_2)^{M/2})_ℂ exp(iK_2^*H_2)
        eq(V2, body_scalar(c, A), f"M={M}, x={x}: V_2 = c exp(S_2)")
        # 否定コントロール: K_2^* の代わりに K_2 を肩に置いた exp(K_2·iH_2) = Σ x^λ P_λ では一致しない
        A_wrong = exp_by_spectral_projectors(iH2_integer_matrix(M), lambda lam: x**lam, QQ).change_ring(AA)
        neq(V2, body_scalar(c, A_wrong), f"M={M}, x={x}: K_2 を肩に置くと外れる")
        # Step 3 の係数: s_2 > 0、(2s_2)^{M/2} > 0、c^2 = (2s_2)^M
        assert s2 > 0 and c > 0 and c**2 == (2 * s2)**M
        # Step 2: A は正定値
        assert is_positive_definite_exact(A), (M, x)
        for y in [QQ(2), QQ(3)]:
            B = exp_V1_half_exact(M, y, +1).change_ring(AA)
            Bp = exp_V1_half_exact(M, y, -1).change_ring(AA)
            # Step 2: B はエルミートで正定値、B'B = I
            eq(conj_transpose_exact(B), B, f"M={M}, y={y}: B^* = B")
            assert is_positive_definite_exact(B), (M, y)
            eq(body_product(Bp, B), Id, f"M={M}, y={y}: B'B = I")
            # Step 1 の最後の段落（def_V_plus の積から主張の表示へ。c はスカラーなので前へ出る）
            Vp = body_product(body_product(B, V2), B)                         # def_V_plus
            line1 = body_product(body_product(B, body_scalar(c, A)), B)       # V_2 の鎖を代入
            line2 = body_product(body_scalar(c, body_product(B, A)), B)       # scalar_multiple_factors_out_of_right_factor（B(cA) = c(BA)）
            line3 = body_scalar(c, body_product(body_product(B, A), B))       # scalar_multiple_factors_out_of_left_factor（(cX)B = c(XB)）
            eq(Vp, line1, f"M={M}: def_V_plus → 代入")
            eq(line1, line2, f"M={M}: B(cA) = c(BA)")
            eq(line2, line3, f"M={M}: (c(BA))B = c((BA)B)")
            # Step 3 の鎖: exp(S_1/2)exp(S_2)exp(S_1/2) = BAB = B^*AB
            BAB = body_product(body_product(B, A), B)
            BsAB = body_product(body_product(conj_transpose_exact(B), A), B)
            eq(BAB, BsAB, f"M={M}: BAB = B^*AB")
            # congruence_preserves_positive_definite の B^*(AB)（mat_mult_associative）と正定値性
            BsAB2 = body_product(conj_transpose_exact(B), body_product(A, B))
            eq(BsAB, BsAB2, f"M={M}: (B^*A)B = B^*(AB)")
            assert is_positive_definite_exact(BsAB2), (M, x, y)
            # positive_real_multiple_preserves_positive_definite: V^(+) = c B^*AB は正定値（主張）
            eq(Vp, body_scalar(c, BsAB2), f"M={M}: V^(+) = c B^*AB")
            assert is_positive_definite_exact(Vp), (M, x, y)
            # 主張そのものを具体の x で: x^*V^(+)x ∈ ℝ_{>0}
            for xv in [vector(QQbar, [QQbar(k + 1) + QQbar(I) * (k % 3 - 1) for k in range(n)]),
                       vector(QQbar, [QQbar((-1)**k) for k in range(n)]),
                       vector(QQbar, [QQbar(0)] * (n - 1) + [QQbar(I)])]:
                v = quadratic_form_value(xv, Vp.change_ring(QQbar))
                assert v.imag() == 0 and v.real() > 0
            # 否定コントロール
            neq(Vp, body_scalar(c**2, BAB), f"M={M}: 係数 (2s_2)^{{M}} では外れる")
            neq(Vp, body_scalar(c, body_product(body_product(B, B), A)), f"M={M}: exp(S_1)exp(S_2) では外れる")
            BA = body_product(B, A)
            neq(conj_transpose_exact(BA), BA, f"M={M}: BA はエルミートでない")
            assert not is_positive_definite_exact(body_product(conj_transpose_exact(B), body_product(body_scalar(-1, A), B)))
            n_neg += 1
            # 不定値の対照: A − λI（λ は A の最小と 2 番目に小さい固有値の間の有理数）を合同で移したものはエルミートだが正定値でない
            ev = sorted(A.charpoly().roots(AA, multiplicities=False))
            lam = QQ(RR((ev[0] + ev[1]) / 2))
            assert ev[0] < lam < ev[1]
            Ind = body_product(conj_transpose_exact(B), body_product(A - lam * Id, B))
            assert not is_positive_definite_exact(Ind)
            n_neg += 1
    print(f"(b) M_col = {M}: x, y ∈ {{2, 3}} で Step 1〜3 の行と主張を AA で厳密に確かめた")
print(f"等号 {n_steps} 個（うち (b) {n_steps - a_steps} 個）、否定コントロール {n_neg} 件")
print("RESULT: PASS")
