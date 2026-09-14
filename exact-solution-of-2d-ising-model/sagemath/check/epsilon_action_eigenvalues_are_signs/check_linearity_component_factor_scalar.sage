# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 有限和から複素スカラーを括り出す。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert sum(
            eigenvalue * (epsilon[i, k] * f[k]) for k in range(len(f))
        ) == eigenvalue * sum(
            epsilon[i, k] * f[k] for k in range(len(f))
        )

print("RESULT: PASS")
