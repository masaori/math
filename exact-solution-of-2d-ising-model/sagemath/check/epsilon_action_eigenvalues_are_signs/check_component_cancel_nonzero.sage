# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: f_j != 0 と (lambda^2-1)f_j=0 から lambda^2-1=0。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, f, eigenvalue, j in eigen_cases():
    assert f[j] != 0
    assert (eigenvalue**2 - 1) * f[j] == 0
    assert eigenvalue**2 - 1 == 0

print("RESULT: PASS")
