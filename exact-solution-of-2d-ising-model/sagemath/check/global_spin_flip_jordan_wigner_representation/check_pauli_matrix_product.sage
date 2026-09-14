# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 二次行列の積を成分ごとに計算する。
load("_prelude.sage")
left = matrix(K, [[1, 0], [0, -1]]) * matrix(K, [[0, -i], [i, 0]])
right = matrix(K, [[0, -i], [-i, 0]])
assert left == right
print("RESULT: PASS")
