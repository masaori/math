# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: (i(-i))^M=i^M(-i)^M。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    left = i**M * (-i)**M * sigma_x_prefix(M, M)
    right = (i * (-i))**M * sigma_x_prefix(M, M)
    assert right == left
print("RESULT: PASS")
