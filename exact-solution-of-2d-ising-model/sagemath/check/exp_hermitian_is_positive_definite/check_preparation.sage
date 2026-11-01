# 対象ラベル: exp_hermitian_is_positive_definite
# 準備の H^* = H（real_multiple_of_hermitian_is_hermitian の α = 1/2）と H + H = S の 8 行を、
# S をエルミートな不定元の表に置いて厳密に確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

for n in [1, 2, 3, 4]:
    P, _, _, (M,), _ = generic_ring(n, mats=["S"])
    S = hermitian_from_generic(M, P)
    half = iota(QQ(1) / 2, P)
    H = body_scalar(half, S)
    assert body_star(H) == H
    HH = body_sum(H, H)
    for k in range(n):
        for l in range(n):
            s = S[k][l]
            lines = [
                HH[k][l],
                cc_add(H[k][l], H[k][l]),                                    # (def_matrix_sum)
                cc_add(cc_mul(half, s), cc_mul(half, s)),                    # (def_matrix_scalar_multiple)
                cc_mul(cc_add(half, half), s),                               # 分配律
                cc_mul(cc_add((P(1) / 2, P(0)), (P(1) / 2, P(0))), s),       # (inclusion_rr_to_cc)
                cc_mul((P(1) / 2 + P(1) / 2, P(0) + P(0)), s),               # (definition_of_cc の和)
                cc_mul((P(1), P(0)), s),                                     # ℝ
                cc_mul(iota(1, P), s),                                       # (inclusion_rr_to_cc)
                s,                                                           # 1_C は単位元
            ]
            for t in range(len(lines) - 1):
                assert lines[t] == lines[t + 1], (n, k, l, t)
    PK = gauss_ring(P)
    assert to_g_mat(HH, PK) == to_g_mat(S, PK)
    print(f"n = {n}: H^* = H と H + H = S の 8 行を不定元で確かめた")
print("RESULT: PASS")
