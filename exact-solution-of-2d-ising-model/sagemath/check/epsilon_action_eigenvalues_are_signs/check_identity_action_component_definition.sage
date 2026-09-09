# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: (I f)_i を行列作用の成分和へ展開。帰属: QQ。
load("_prelude.sage")

for M, _epsilon, f, _eigenvalue, _j in eigen_cases():
    identity = identity_matrix(QQ, 2**M)
    for i in range(2**M):
        assert (identity * f)[i] == sum(identity[i, k] * f[k] for k in range(2**M))

print("RESULT: PASS")
