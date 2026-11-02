# 対象ラベル: epsilon_anticommutes_with_site_sigma_y
# 因子の条件 y_ix_i = Iσ^x = σ^x = σ^xI = x_iy_i（i ≠ k）と y_kx_k = σ^yσ^x = -(σ^xσ^y)（pauli_matrix_products）、
# 鎖 εσ_k^y + σ_k^yε = (クロネッカー積の積の和) = O、結論 εσ_k^y = -(σ_k^yε) を M_col = 1..5、全ての k で厳密に。
# 対照: σ^y を σ^x に替えた行列とは和が O にならない（反可換の因子が要る）。
load("_prelude.sage")
P = body_product
check_chain([P(I2, SX), SX, P(SX, I2)], "因子の条件")
assert P(PAULI['y'], SX) == body_negation(P(SX, PAULI['y']))
for M in range(1, 6):
    E = epsilon(M)
    Ek = kron([SX] * M)
    for k in range(1, M + 1):
        S = site(M, k, 'y')
        Sk = kron(site_factors(M, k, PAULI['y']))
        O = matrix(KG, 2**M, 2**M, 0)
        check_chain([body_sum(P(E, S), P(S, E)), body_sum(P(Ek, Sk), P(Sk, Ek)), O], f"M={M} k={k}")
        assert P(E, S) == body_negation(P(S, E))
        X = site(M, k, 'x')
        assert body_sum(P(E, X), P(X, E)) != O
    print(f"  M_col={M}: 全ての k で εσ_k^y + σ_k^yε = O、εσ_k^y = -(σ_k^yε)")
print("RESULT: PASS")
