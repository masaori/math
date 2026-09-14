# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: -i [[0,1],[1,0]]=-iσ^x。
load("_prelude.sage")
left = -i * matrix(K, [[0, 1], [1, 0]])
assert left == -i * sigma_x
print("RESULT: PASS")
