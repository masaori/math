# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: (-i)^0I=(-i)^0P_0。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    left = (-i)**0 * identity_matrix(K, 2**M)
    assert left == (-i)**0 * sigma_x_prefix(M, 0)
print("RESULT: PASS")
