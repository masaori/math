# 対象ラベル: global_spin_flip_kronecker_form
# ε = Π_{j=1}^{M_col}σ_j^x（def_global_spin_flip_matrix の def_finite_product_of_matrices の有限積。左から掛ける。Sage の積とも一致）
# = σ^x⊠⋯⊠σ^x（site_pauli_prefix_product_kronecker_form、r → M_col、a_j = x）を M_col = 1..6 で厳密に。
load("_prelude.sage")
for M in range(1, 7):
    E = epsilon(M)
    assert E == prefix_product(M, ['x'] * M)
    assert E == kron([SX] * M)
    print(f"  M_col={M}: ε = σ^x⊠⋯⊠σ^x")
print("RESULT: PASS")
