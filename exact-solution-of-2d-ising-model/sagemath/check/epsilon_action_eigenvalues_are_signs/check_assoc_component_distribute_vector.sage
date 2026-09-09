# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 準備: 分配律で数ベクトル成分を内側の有限和へ入れる。帰属: QQ。
load("_prelude.sage")

for _M, epsilon, f, _eigenvalue, _j in eigen_cases():
    for i in range(len(f)):
        left = sum(
            sum(epsilon[i, ell] * epsilon[ell, k] for ell in range(len(f))) * f[k]
            for k in range(len(f))
        )
        right = sum(
            sum((epsilon[i, ell] * epsilon[ell, k]) * f[k] for ell in range(len(f)))
            for k in range(len(f))
        )
        assert left == right

print("RESULT: PASS")
