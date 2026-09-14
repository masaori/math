# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: クロネッカー積同士の積を因子ごとの積へ移す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        left = sigma_x_prefix_factors(M, r) * kronecker_factors([
            sigma_x if site == r else identity_two for site in range(M)
        ])
        right = kronecker_factors([
            sigma_x * identity_two if site < r else
            identity_two * sigma_x if site == r else
            identity_two * identity_two for site in range(M)
        ])
        assert left == right
print("RESULT: PASS")
