# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: f_j=lambda^2 f_j の両辺から f_j を引く。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, j in eigen_cases():
    assert f[j] == eigenvalue**2 * f[j]
    assert eigenvalue**2 * f[j] - f[j] == 0

print("RESULT: PASS")
