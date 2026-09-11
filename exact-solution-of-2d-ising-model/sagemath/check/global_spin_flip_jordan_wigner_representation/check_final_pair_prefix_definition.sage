# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: i^MQ_M=i^M(Z_1Y_1)⋯(Z_MY_M)。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    ordered_product = identity_matrix(K, 2**M)
    for site in range(M):
        ordered_product *= jordan_wigner(M, site, sigma_z) * jordan_wigner(M, site, sigma_y)
    assert i**M * pair_prefix(M, M) == i**M * ordered_product
print("RESULT: PASS")
