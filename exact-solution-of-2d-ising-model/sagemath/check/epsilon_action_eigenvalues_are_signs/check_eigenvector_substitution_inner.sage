# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: epsilon(epsilon f) = epsilon(lambda f)。帰属: QQ^(2^M)。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    assert epsilon * f == eigenvalue * f
    assert epsilon * (epsilon * f) == epsilon * (eigenvalue * f)

print("RESULT: PASS")
