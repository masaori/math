# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 中央因子へ σ^zσ^y=-iσ^x を代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = kronecker_factors([
            sigma_z * sigma_y if index == site else identity_two for index in range(M)
        ])
        right = kronecker_factors([
            -i * sigma_x if index == site else identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
