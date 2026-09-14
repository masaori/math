# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: lambda^2-1=0 を平方差の因数分解へ代入。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, _f, eigenvalue, _j in eigen_cases():
    assert eigenvalue**2 - 1 == 0
    assert (eigenvalue - 1) * (eigenvalue + 1) == 0

print("RESULT: PASS")
