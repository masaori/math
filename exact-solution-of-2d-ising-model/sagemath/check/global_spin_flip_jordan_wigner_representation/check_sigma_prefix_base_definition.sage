# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: P_0=I。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    assert sigma_x_prefix(M, 0) == identity_matrix(K, 2**M)
print("RESULT: PASS")
