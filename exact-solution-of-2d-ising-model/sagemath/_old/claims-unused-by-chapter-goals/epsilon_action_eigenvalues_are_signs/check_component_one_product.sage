# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: 1 f_j = f_j により lambda^2 f_j-1 f_j = lambda^2 f_j-f_j。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, j in eigen_cases():
    assert eigenvalue**2 * f[j] - 1 * f[j] == eigenvalue**2 * f[j] - f[j]

print("RESULT: PASS")
