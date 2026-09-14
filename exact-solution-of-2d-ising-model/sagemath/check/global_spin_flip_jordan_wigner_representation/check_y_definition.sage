# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Y_m=P_{m-1}σ_m^y。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        assert jordan_wigner(M, site, sigma_y) == sigma_x_prefix(M, site) * site_operator(M, site, sigma_y)
print("RESULT: PASS")
