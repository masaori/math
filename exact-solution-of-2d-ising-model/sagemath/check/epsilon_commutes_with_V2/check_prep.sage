# 対象ラベル: epsilon_commutes_with_V2
# 準備の三つの可換性 ε(Σσ_m^x) = (Σσ_m^x)ε、εR = Rε（K_2^* を不定元に）、ε(c X) = (c X)ε（c, X の成分を不定元に、
# X は ε と可換なものとして X = a0 I + a1 ε + a2 Σσ^x）を M_col = 1..4 で厳密に。
load("_prelude.sage")
P = body_product
for M in range(1, 5):
    E = epsilon(M)
    terms = [site(M, m, 'x') for m in range(1, M + 1)]
    for T in terms:
        assert P(E, T) == P(T, E)
    S = body_finite_sum(terms)
    assert P(E, S) == P(S, E)
    R = PolynomialRing(KG, ['K2s', 'c', 'a0', 'a1', 'a2'])
    K2s, c, a0, a1, a2 = R.gens()
    ER, SR = E.change_ring(R), S.change_ring(R)
    Rm = body_scalar(K2s, SR)
    check_chain([P(ER, Rm), body_scalar(K2s, P(ER, SR)), body_scalar(K2s, P(SR, ER)), P(Rm, ER)], f"M={M} R")
    X = a0 * identity_matrix(R, 2**M) + a1 * ER + a2 * SR
    check_chain([P(ER, body_scalar(c, X)), body_scalar(c, P(ER, X)), body_scalar(c, P(X, ER)), P(body_scalar(c, X), ER)], f"M={M} c")
    print(f"  M_col={M}: 準備の三つの可換性が成り立つ")
print("RESULT: PASS")
