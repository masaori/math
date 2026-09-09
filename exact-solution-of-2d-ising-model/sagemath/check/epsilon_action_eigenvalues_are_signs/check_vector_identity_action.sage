# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: f = I f。帰属: QQ^(2^M)。
load("_prelude.sage")

for M, _epsilon, f, _eigenvalue, _j in eigen_cases():
    assert f == identity_matrix(QQ, 2**M) * f

print("RESULT: PASS")
