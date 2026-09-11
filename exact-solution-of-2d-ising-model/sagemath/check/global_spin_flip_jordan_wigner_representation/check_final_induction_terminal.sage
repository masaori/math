# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: i^M(-i)^MP_M=i^MQ_M。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    left = i**M * pair_prefix(M, M)
    right = i**M * (-i)**M * sigma_x_prefix(M, M)
    assert right == left
print("RESULT: PASS")
