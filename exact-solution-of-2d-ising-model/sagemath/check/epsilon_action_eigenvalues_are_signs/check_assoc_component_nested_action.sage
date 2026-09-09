# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 二重和を (epsilon(epsilon f))_i へ戻す。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, _eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        left = sum(
            epsilon[i, ell] * sum(epsilon[ell, k] * f[k] for k in range(len(f)))
            for ell in range(len(f))
        )
        assert left == (epsilon * (epsilon * f))[i]

print("RESULT: PASS")
