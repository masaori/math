# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: P_M=1^MP_M。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    assert sigma_x_prefix(M, M) == K(1)**M * sigma_x_prefix(M, M)
print("RESULT: PASS")
