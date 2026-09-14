# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 計算した行列から複素スカラー -i を外へ出す。
load("_prelude.sage")
left = matrix(K, [[0, -i], [-i, 0]])
right = -i * matrix(K, [[0, 1], [1, 0]])
assert left == right
print("RESULT: PASS")
