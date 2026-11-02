# 対象ラベル: epsilon_commutes_with_bond_sum
# 各 m の εσ_m^z = -(σ_m^zε)、εσ_{m+1}^z = -(σ_{m+1}^zε)（m = M_col では σ_{M+1}^z = σ_1^z）、
# product_of_anticommuting_matrices_commutes の結論 ε(σ_m^zσ_{m+1}^z) = (σ_m^zσ_{m+1}^z)ε、
# 主の鎖 εD = ε(Σ…) = (Σ…)ε = Dε を M_col = 1..5 で厳密に。
load("_prelude.sage")
P = body_product
for M in range(1, 6):
    E = epsilon(M)
    terms = []
    for m in range(1, M + 1):
        A, B = site(M, m, 'z'), site_periodic_z(M, m + 1)
        assert P(E, A) == body_negation(P(A, E)) and P(E, B) == body_negation(P(B, E))
        T = P(A, B)
        assert P(E, T) == P(T, E)
        terms.append(T)
    D = bond_sum(M)
    check_chain([P(E, D), P(E, body_finite_sum(terms)), P(body_finite_sum(terms), E), P(D, E)], f"M={M}")
    print(f"  M_col={M}: εD = Dε")
print("RESULT: PASS")
