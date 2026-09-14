# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 本文: (lambda-1)(lambda+1)=0 から lambda-1=0 または lambda+1=0。帰属: QQ。
load("_prelude.sage")

for _M, _epsilon, _f, eigenvalue, _j in eigen_cases():
    assert (eigenvalue - 1) * (eigenvalue + 1) == 0
    assert eigenvalue - 1 == 0 or eigenvalue + 1 == 0

print("RESULT: PASS")
