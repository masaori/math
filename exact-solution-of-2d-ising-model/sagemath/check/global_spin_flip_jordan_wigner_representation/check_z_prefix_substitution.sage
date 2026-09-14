# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: P_{m-1} のクロネッカー積表示を Z_m に代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = sigma_x_prefix(M, site) * site_operator(M, site, sigma_z)
        right = sigma_x_prefix_factors(M, site) * site_operator(M, site, sigma_z)
        assert left == right
print("RESULT: PASS")
