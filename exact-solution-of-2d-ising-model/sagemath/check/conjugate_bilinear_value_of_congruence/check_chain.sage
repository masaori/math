# 対象ラベル: conjugate_bilinear_value_of_congruence
# x^*(B^*(AB))y から (Bx)^*A(By) までの 14 行を、A, B, x, y の成分を QQ 上の不定元の対に置いて厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")


def prod5(a, b, c, d, e):
    """5 つの複素数の積を左から順に掛ける（証明の約束）。"""
    return cc_mul(cc_mul(cc_mul(cc_mul(a, b), c), d), e)


for n in [1, 2, 3]:
    P, _, _, (A, B), (x, y) = generic_ring(n, mats=["A", "B"], vecs=["x", "y"])
    R = range(n)
    Bs = body_star(B)
    AB = body_prod(A, B)
    BsAB = body_prod(Bs, AB)
    Bx, By = body_matvec(B, x), body_matvec(B, y)
    lines = [
        body_cbv(x, BsAB, y),                                                                                    # x^*(B^*(AB))y
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), BsAB[k][l]), y[l]) for l in R]) for k in R]),                    # ΣΣ conj(x_k)(B^*(AB))_kl y_l   (def_conjugate_bilinear_value)
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), fsum([cc_mul(Bs[k][j], AB[j][l]) for j in R])), y[l]) for l in R]) for k in R]),   # (mat_mult)
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), fsum([cc_mul(cc_conj(B[j][k]), AB[j][l]) for j in R])), y[l]) for l in R]) for k in R]),   # (def_hermitian_positive_definite)
        fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), fsum([cc_mul(cc_conj(B[j][k]), fsum([cc_mul(A[j][m], B[m][l]) for m in R])) for j in R])), y[l]) for l in R]) for k in R]),   # (mat_mult)
        fsum([fsum([fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), cc_mul(cc_conj(B[j][k]), cc_mul(A[j][m], B[m][l]))), y[l]) for m in R]) for j in R]) for l in R]) for k in R]),   # 分配律
        fsum([fsum([fsum([fsum([prod5(cc_conj(x[k]), cc_conj(B[j][k]), A[j][m], B[m][l], y[l]) for m in R]) for j in R]) for l in R]) for k in R]),   # 結合律
        fsum([fsum([fsum([fsum([prod5(cc_conj(x[k]), cc_conj(B[j][k]), A[j][m], B[m][l], y[l]) for l in R]) for k in R]) for m in R]) for j in R]),   # 和の順序の入れ替え
        fsum([fsum([fsum([fsum([prod5(cc_conj(B[j][k]), cc_conj(x[k]), A[j][m], B[m][l], y[l]) for l in R]) for k in R]) for m in R]) for j in R]),   # 積の可換律
        fsum([fsum([fsum([fsum([cc_mul(cc_mul(cc_mul(cc_conj(B[j][k]), cc_conj(x[k])), A[j][m]), cc_mul(B[m][l], y[l])) for l in R]) for k in R]) for m in R]) for j in R]),   # 結合律
        fsum([fsum([cc_mul(cc_mul(fsum([cc_mul(cc_conj(B[j][k]), cc_conj(x[k])) for k in R]), A[j][m]), fsum([cc_mul(B[m][l], y[l]) for l in R])) for m in R]) for j in R]),   # 分配律
        fsum([fsum([cc_mul(cc_mul(fsum([cc_conj(cc_mul(B[j][k], x[k])) for k in R]), A[j][m]), fsum([cc_mul(B[m][l], y[l]) for l in R])) for m in R]) for j in R]),   # (complex_conjugate_of_product)
        fsum([fsum([cc_mul(cc_mul(cc_conj(fsum([cc_mul(B[j][k], x[k]) for k in R])), A[j][m]), fsum([cc_mul(B[m][l], y[l]) for l in R])) for m in R]) for j in R]),   # (complex_conjugate_of_sum)
        fsum([fsum([cc_mul(cc_mul(cc_conj(Bx[j]), A[j][m]), By[m]) for m in R]) for j in R]),                    # ΣΣ conj((Bx)_j) A_jm (By)_m  (mat_mult)
        body_cbv(Bx, A, By),                                                                                     # (Bx)^*A(By)  (def_conjugate_bilinear_value)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    PK = gauss_ring(P)
    gA, gB, gx, gy = to_g_mat(A, PK), to_g_mat(B, PK), to_g_vec(x, PK), to_g_vec(y, PK)
    gxc = gx.apply_map(g_conj)
    assert to_g(lines[0], PK) == gxc * (sage_star(gB) * (gA * gB)) * gy        # 比べる側: Sage の行列とベクトルの積
    assert to_g(lines[-1], PK) == (gB * gx).apply_map(g_conj) * gA * (gB * gy)
    print(f"n = {n}: 14 個の等号と、両端の Sage の積との一致を不定元で確かめた")
print("RESULT: PASS")
