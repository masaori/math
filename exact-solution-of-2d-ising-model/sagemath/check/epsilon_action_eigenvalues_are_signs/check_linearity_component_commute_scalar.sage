# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 各項で行列成分と複素スカラーを交換する。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert sum(
            (epsilon[i, k] * eigenvalue) * f[k] for k in range(len(f))
        ) == sum(
            (eigenvalue * epsilon[i, k]) * f[k] for k in range(len(f))
        )

print("RESULT: PASS")
