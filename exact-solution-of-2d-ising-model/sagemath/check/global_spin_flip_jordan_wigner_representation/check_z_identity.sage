# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: AI=IA=A により Z_m の表示を簡約する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = kronecker_factors([
            sigma_x * identity_two if index < site else
            identity_two * sigma_z if index == site else
            identity_two * identity_two for index in range(M)
        ])
        assert left == jordan_wigner_factors(M, site, sigma_z)
print("RESULT: PASS")
