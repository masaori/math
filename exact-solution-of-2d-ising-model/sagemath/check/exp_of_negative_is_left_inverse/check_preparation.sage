# 対象ラベル: exp_of_negative_is_left_inverse
# 準備の (-A)A = A(-A)（8 行）と (-A)+A = O（11 行）を、A の成分を QQ 上の不定元の対に置いて厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, _, _, (A,), _ = generic_ring(n, mats=["A"])
    R = range(n)
    mA = body_neg(A, P)
    m1, one, zero = iota(-1, P), iota(1, P), iota(0, P)
    L, Rr = body_prod(mA, A), body_prod(A, mA)
    S = body_sum(mA, A)
    for k in R:
        for l in R:
            lines = [
                L[k][l],
                fsum([cc_mul(mA[k][j], A[j][l]) for j in R]),                    # (mat_mult)
                fsum([cc_mul(cc_neg(A[k][j], P), A[j][l]) for j in R]),          # (def_matrix_negation)
                fsum([cc_mul(cc_mul(m1, A[k][j]), A[j][l]) for j in R]),         # (multiply_by_minus_one)
                fsum([cc_mul(cc_mul(A[k][j], m1), A[j][l]) for j in R]),         # 可換律
                fsum([cc_mul(A[k][j], cc_mul(m1, A[j][l])) for j in R]),         # 結合律
                fsum([cc_mul(A[k][j], cc_neg(A[j][l], P)) for j in R]),          # (multiply_by_minus_one)
                fsum([cc_mul(A[k][j], mA[j][l]) for j in R]),                    # (def_matrix_negation)
                Rr[k][l],                                                        # (mat_mult)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], ("commute", n, k, l, t)
            a = A[k][l]
            lines = [
                S[k][l],
                cc_add(mA[k][l], a),                              # (def_matrix_sum)
                cc_add(cc_neg(a, P), a),                          # (def_matrix_negation)
                cc_add(cc_mul(m1, a), a),                         # (multiply_by_minus_one)
                cc_add(cc_mul(m1, a), cc_mul(one, a)),            # 1_C は単位元
                cc_mul(cc_add(m1, one), a),                       # 分配律
                cc_mul(cc_add((P(-1), P(0)), (P(1), P(0))), a),   # (inclusion_rr_to_cc)
                cc_mul((P(-1) + 1, P(0) + 0), a),                 # (definition_of_cc の和)
                cc_mul((P(0), P(0)), a),                          # ℝ
                cc_mul(zero, a),                                  # (inclusion_rr_to_cc)
                zero,                                             # (complex_zero_times_is_zero)
                body_zero(n, P)[k][l],                            # (def_zero_matrix)
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], ("sum", n, k, l, t)
    PK = gauss_ring(P)
    gA = to_g_mat(A, PK)
    assert to_g_mat(L, PK) == (-gA) * gA == gA * (-gA) == to_g_mat(Rr, PK)
    assert to_g_mat(S, PK) == 0
    print(f"n = {n}: 準備の 8 行と 11 行を不定元で確かめ、Sage の積・和と比べた")
print("RESULT: PASS")
