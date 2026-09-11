# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Z_mY_m のクロネッカー積同士の積を因子ごとの積へ移す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = jordan_wigner_factors(M, site, sigma_z) * jordan_wigner_factors(M, site, sigma_y)
        right = kronecker_factors([
            sigma_x * sigma_x if index < site else
            sigma_z * sigma_y if index == site else
            identity_two * identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
