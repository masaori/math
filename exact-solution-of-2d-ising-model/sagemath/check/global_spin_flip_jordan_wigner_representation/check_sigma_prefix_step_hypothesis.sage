# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 帰納法の仮定を P_r に代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        left = sigma_x_prefix(M, r) * site_operator(M, r, sigma_x)
        right = sigma_x_prefix_factors(M, r) * site_operator(M, r, sigma_x)
        assert left == right
print("RESULT: PASS")
