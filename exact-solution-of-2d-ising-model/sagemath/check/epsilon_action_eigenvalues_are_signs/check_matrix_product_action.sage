# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: epsilon^2 f = epsilon(epsilon f)。帰属: QQ^(2^M)。
load("_prelude.sage")

for _M, epsilon, f, _eigenvalue, _j in eigen_cases():
    assert (epsilon * epsilon) * f == epsilon * (epsilon * f)

print("RESULT: PASS")
