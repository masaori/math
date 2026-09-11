# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Y_m のクロネッカー積同士の積を因子ごとの積へ移す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = sigma_x_prefix_factors(M, site) * kronecker_factors([
            sigma_y if index == site else identity_two for index in range(M)
        ])
        right = kronecker_factors([
            sigma_x * identity_two if index < site else
            identity_two * sigma_y if index == site else
            identity_two * identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
