# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: lambda(lambda f) = (lambda lambda)f。帰属: QQ^(2^M)。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, _j in eigen_cases():
    assert eigenvalue * (eigenvalue * f) == (eigenvalue * eigenvalue) * f

print("RESULT: PASS")
