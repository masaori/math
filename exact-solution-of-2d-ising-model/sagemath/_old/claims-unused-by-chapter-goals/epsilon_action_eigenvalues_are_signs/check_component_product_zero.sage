# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: lambda^2 f_j-f_j=0 を展開済みの積へ代入。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, j in eigen_cases():
    assert eigenvalue**2 * f[j] - f[j] == 0
    assert (eigenvalue**2 - 1) * f[j] == 0

print("RESULT: PASS")
