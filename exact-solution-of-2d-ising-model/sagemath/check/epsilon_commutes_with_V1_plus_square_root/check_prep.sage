# 対象ラベル: epsilon_commutes_with_V1_plus_square_root
# 準備 ε(cH_1^(+)) = (cH_1^(+))ε を、c を不定元にして M_col = 2..4 で厳密に（commuting_with_scalar_multiple の形）。
load("_prelude.sage")
for M in range(2, 5):
    R = PolynomialRing(KG, 'c')
    c = R.gen()
    E = epsilon(M).change_ring(R)
    H = H1_plus(M).change_ring(R)
    check_chain([body_product(E, body_scalar(c, H)), body_scalar(c, body_product(E, H)),
                 body_scalar(c, body_product(H, E)), body_product(body_scalar(c, H), E)], f"M={M}")
    print(f"  M_col={M}: ε(cH) = (cH)ε")
print("RESULT: PASS")
