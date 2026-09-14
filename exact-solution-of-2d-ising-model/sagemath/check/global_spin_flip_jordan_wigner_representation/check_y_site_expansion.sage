# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: σ_m^y をサイト行列のクロネッカー積へ展開する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = sigma_x_prefix_factors(M, site) * site_operator(M, site, sigma_y)
        right = sigma_x_prefix_factors(M, site) * kronecker_factors([
            sigma_y if index == site else identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
