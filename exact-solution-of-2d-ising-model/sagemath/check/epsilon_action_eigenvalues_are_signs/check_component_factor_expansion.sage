# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: 分配律で (lambda^2-1) f_j を lambda^2 f_j-1 f_j へ展開。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, j in eigen_cases():
    assert (eigenvalue**2 - 1) * f[j] == eigenvalue**2 * f[j] - 1 * f[j]

print("RESULT: PASS")
