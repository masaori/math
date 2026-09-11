# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: ε=σ_1^x⋯σ_M^x。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    ordered_product = identity_matrix(K, 2**M)
    for site in range(M):
        ordered_product *= site_operator(M, site, sigma_x)
    epsilon = sigma_x_prefix(M, M)
    assert epsilon == ordered_product
print("RESULT: PASS")
