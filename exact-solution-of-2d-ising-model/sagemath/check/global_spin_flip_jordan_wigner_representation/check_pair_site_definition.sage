# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 中央だけが σ^x のクロネッカー積を σ_m^x と同定する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = -i * kronecker_factors([
            sigma_x if index == site else identity_two for index in range(M)
        ])
        assert left == -i * site_operator(M, site, sigma_x)
print("RESULT: PASS")
