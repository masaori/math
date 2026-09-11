# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Pauli 行列の成分表示を行列積へ代入する。
load("_prelude.sage")
left = sigma_z * sigma_y
right = matrix(K, [[1, 0], [0, -1]]) * matrix(K, [[0, -i], [i, 0]])
assert left == right
print("RESULT: PASS")
