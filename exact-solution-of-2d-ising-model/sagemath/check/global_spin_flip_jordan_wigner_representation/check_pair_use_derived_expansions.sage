# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 直前に導いた Z_m,Y_m のクロネッカー積表示を代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = jordan_wigner(M, site, sigma_z) * jordan_wigner(M, site, sigma_y)
        right = jordan_wigner_factors(M, site, sigma_z) * jordan_wigner_factors(M, site, sigma_y)
        assert left == right
print("RESULT: PASS")
