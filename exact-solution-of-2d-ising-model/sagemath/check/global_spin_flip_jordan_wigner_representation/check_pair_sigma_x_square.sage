# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 先行因子の (σ^x)^2 を I へ直す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = kronecker_factors([
            sigma_x * sigma_x if index < site else
            sigma_z * sigma_y if index == site else
            identity_two * identity_two for index in range(M)
        ])
        right = kronecker_factors([
            identity_two if index < site else
            sigma_z * sigma_y if index == site else
            identity_two * identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
