# 対象ラベル: epsilon_commutes_with_V1
# 準備 ε((K_1)_C D) = ((K_1)_C D)ε を、K_1 を不定元にして M_col = 1..4 で厳密に（commuting_with_scalar_multiple の形）。
load("_prelude.sage")
for M in range(1, 5):
    R = PolynomialRing(KG, 'K1')
    K1 = R.gen()
    E = epsilon(M).change_ring(R)
    D = bond_sum(M).change_ring(R)
    check_chain([body_product(E, body_scalar(K1, D)), body_scalar(K1, body_product(E, D)),
                 body_scalar(K1, body_product(D, E)), body_product(body_scalar(K1, D), E)], f"M={M}")
    print(f"  M_col={M}: ε(K_1 D) = (K_1 D)ε")
print("RESULT: PASS")
