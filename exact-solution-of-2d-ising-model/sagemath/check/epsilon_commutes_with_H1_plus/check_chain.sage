# 対象ラベル: epsilon_commutes_with_H1_plus
# 全ての a, b で ε(Y_aZ_b) = (Y_aZ_b)ε、和の可換性、主の鎖 εH = ε(Σ - Y_MZ_1) = (Σ - Y_MZ_1)ε = Hε を M_col = 2..5 で厳密に。
load("_prelude.sage")
P = body_product
for M in range(2, 6):
    E = epsilon(M)
    for a_ in range(1, M + 1):
        for b in range(1, M + 1):
            T = P(jw(M, a_, 'y'), jw(M, b, 'z'))
            assert P(E, T) == P(T, E)
    S = body_finite_sum([P(jw(M, m, 'y'), jw(M, m + 1, 'z')) for m in range(1, M)])
    W = P(jw(M, M, 'y'), jw(M, 1, 'z'))
    assert P(E, S) == P(S, E)
    H = H1_plus(M)
    check_chain([P(E, H), P(E, body_difference(S, W)), P(body_difference(S, W), E), P(H, E)], f"M={M}")
    print(f"  M_col={M}: εH_1^(+) = H_1^(+)ε")
print("RESULT: PASS")
