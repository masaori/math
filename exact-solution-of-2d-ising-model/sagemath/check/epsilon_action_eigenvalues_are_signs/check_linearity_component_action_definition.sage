# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: (epsilon(lambda f))_i を行列作用の成分表示へ展開する。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert (epsilon * (eigenvalue * f))[i] == sum(
            epsilon[i, k] * (eigenvalue * f[k]) for k in range(len(f))
        )

print("RESULT: PASS")
