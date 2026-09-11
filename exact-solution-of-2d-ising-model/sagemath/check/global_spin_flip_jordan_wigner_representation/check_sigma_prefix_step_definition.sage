# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: P_{r+1}=P_rσ^x_{r+1}。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        assert sigma_x_prefix(M, r + 1) == sigma_x_prefix(M, r) * site_operator(M, r, sigma_x)
print("RESULT: PASS")
