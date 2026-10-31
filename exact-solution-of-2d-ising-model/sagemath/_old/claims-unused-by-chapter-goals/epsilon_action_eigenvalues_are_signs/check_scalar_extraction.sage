# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: epsilon(lambda f) = lambda(epsilon f)。帰属: QQ^(2^M)。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    assert epsilon * (eigenvalue * f) == eigenvalue * (epsilon * f)

print("RESULT: PASS")
