# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 各項で最初の積の結合を変える。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert sum(
            epsilon[i, k] * (eigenvalue * f[k]) for k in range(len(f))
        ) == sum(
            (epsilon[i, k] * eigenvalue) * f[k] for k in range(len(f))
        )

print("RESULT: PASS")
