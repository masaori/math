# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 成分和を (lambda(epsilon f))_i へ戻す。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert eigenvalue * sum(
            epsilon[i, k] * f[k] for k in range(len(f))
        ) == (eigenvalue * (epsilon * f))[i]

print("RESULT: PASS")
