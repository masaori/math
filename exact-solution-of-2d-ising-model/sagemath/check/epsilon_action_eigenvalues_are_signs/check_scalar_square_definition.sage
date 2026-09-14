# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: (lambda lambda)f = lambda^2 f。帰属: QQ^(2^M)。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, _j in eigen_cases():
    assert (eigenvalue * eigenvalue) * f == eigenvalue**2 * f

print("RESULT: PASS")
