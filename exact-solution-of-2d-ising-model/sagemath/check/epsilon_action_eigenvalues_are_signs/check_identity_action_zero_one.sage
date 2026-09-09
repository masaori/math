# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: 単位行列の成分と 0, 1 の法則で成分和を f_i へ戻す。帰属: QQ。
load("_prelude.sage")

for M, _epsilon, f, _eigenvalue, _j in eigen_cases():
    identity = identity_matrix(QQ, 2**M)
    for i in range(2**M):
        assert sum(identity[i, k] * f[k] for k in range(2**M)) == f[i]

print("RESULT: PASS")
