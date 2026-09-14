# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 1^MP_M=(i(-i))^MP_M。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    left = (i * (-i))**M * sigma_x_prefix(M, M)
    assert K(1)**M * sigma_x_prefix(M, M) == left
print("RESULT: PASS")
