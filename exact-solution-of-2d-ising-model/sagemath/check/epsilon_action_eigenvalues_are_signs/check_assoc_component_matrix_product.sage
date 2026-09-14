# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: (epsilon^2)_{ik} を行列積の成分表示へ展開する。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, _eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        assert sum((epsilon * epsilon)[i, k] * f[k] for k in range(len(f))) == sum(
            sum(epsilon[i, ell] * epsilon[ell, k] for ell in range(len(f))) * f[k]
            for k in range(len(f))
        )

print("RESULT: PASS")
