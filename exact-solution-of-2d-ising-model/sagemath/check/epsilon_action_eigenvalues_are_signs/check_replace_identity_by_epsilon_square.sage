# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: I f = epsilon^2 f。帰属: QQ^(2^M)。
load("_prelude.sage")

for M, epsilon, f, _eigenvalue, _j in eigen_cases():
    assert identity_matrix(QQ, 2**M) * f == (epsilon * epsilon) * f

print("RESULT: PASS")
