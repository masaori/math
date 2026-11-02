# 対象ラベル: V2_invertible
# 二つの鎖のうち、スカラー倍を外へ出す行（(a_C exp(Y))((a^{-1})_C exp(-Y)) から (a_C (a^{-1})_C)(exp(Y)exp(-Y)) までの三等号と、1_C を外す行。exp の値に依らない）を一般の行列で確かめる。
# exp(Y)・exp(-Y) を成分が独立な不定元の行列 E・F に、a_C・(a^{-1})_C を独立な不定元 a・b に置き、
# 各行を書かれた括弧の形どおりに本文の定め方（mat_mult の成分の式の積、def_matrix_scalar_multiple の成分の式）で組んで、
# 隣り合う行が QQ 上の多項式として等しいことを見る（厳密）。a と b を独立に置くので、ab = 1 を使う行は
# a_C (a^{-1})_C → (aa^{-1})_C → (1)_C → 1_C の三行だけであることが分かる。その三行は AA の具体の a で、
# 実数の対で持った ℂ の積と、ℝ の積の像が等しいことを確かめる。
load("_prelude.sage")
for n in [2, 4]:
    P, (a, b), (E, F) = generic_ring([('e', n, n), ('f', n, n)], scalars=('a', 'b'))
    for (s, t, U, W, name) in [(a, b, E, F, 'V_2 h'), (b, a, F, E, 'h V_2')]:
        L1 = body_product(body_scalar(s, U), body_scalar(t, W))
        L2 = body_scalar(s, body_product(U, body_scalar(t, W)))
        L3 = body_scalar(s, body_scalar(t, body_product(U, W)))
        L4 = body_scalar(s * t, body_product(U, W))
        assert L1 == L2, f"{name}: 係数を左の因子から出す行"
        assert L2 == L3, f"{name}: 係数を右の因子から出す行"
        assert L3 == L4, f"{name}: 係数をまとめる行"
        # 1_C を外す行: 1_C (UW) = UW（scalar_multiple_by_one）
        assert body_scalar(1, body_product(U, W)) == body_product(U, W)
        # 比べる側: Sage の行列積・スカラー倍
        assert L1 == (s * U) * (t * W) and L4 == (s * t) * (U * W)
    # 対照: ab = 1 を課さないと (ab)(EF) は EF と一致しない
    assert body_scalar(a * b, body_product(E, F)) != body_product(E, F)
# a_C (a^{-1})_C → (aa^{-1})_C → (1)_C → 1_C の三行は、本文の ℂ を実数の対で持つ共通の準備 complex_as_real_pairs.sage（definition_of_cc の積
# (p,q)(r,s) = (pr - qs, ps + qr) と inclusion_rr_to_cc の r_C = (r, 0)）で確かめる。Sage の QQbar の型変換は使わない。
load("../../_shared/complex_as_real_pairs.sage")
for M in range(1, 5):
    for x in [QQ(2), QQ(3), QQ(3)/2]:
        a = prefactor_exact(M, x)
        ainv = a**(-1)                                   # ℝ（AA）の逆数
        for (u, v) in [(a, ainv), (ainv, a)]:            # 二つの鎖
            L4 = cc_mul(iota(u, AA), iota(v, AA))        # u_C v_C（ℂ の積）
            L5 = iota(u * v, AA)                         # (uv)_C（real_inclusion_preserves_product）
            L6 = iota(AA(1), AA)                         # (1)_C（ℝ で uv = 1）
            L7 = iota(1, AA)                             # 1_C
            assert L4 == L5, "積の像の行"
            assert u * v == AA(1), "ℝ の uv = 1"
            assert L5 == L6 == L7, "(1)_C = 1_C の行"
print("  n = 2, 4 で係数を出す行が不定元の多項式として一致、M_col = 1..4 で包含の三行が実数の対（成分は AA）で一致")
print("RESULT: PASS")
