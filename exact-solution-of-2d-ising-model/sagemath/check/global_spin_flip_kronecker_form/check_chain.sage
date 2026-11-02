# 対象ラベル: global_spin_flip_kronecker_form
# ε = σ_1^x⋯σ_M^x（def_global_spin_flip_matrix を左から掛けた積、Sage の積とも一致）= σ^x⊠⋯⊠σ^x を M_col = 1..6 で厳密に。
load("_prelude.sage")
for M in range(1, 7):
    E = epsilon(M)
    assert E == prefix_product(M, ['x'] * M)
    assert E == kron([SX] * M)
    print(f"  M_col={M}: ε = σ^x⊠⋯⊠σ^x")
print("RESULT: PASS")
