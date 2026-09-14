# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: クロネッカー積の中央因子から -i を外へ出す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for site in range(M):
        left = kronecker_factors([
            -i * sigma_x if index == site else identity_two for index in range(M)
        ])
        right = -i * kronecker_factors([
            sigma_x if index == site else identity_two for index in range(M)
        ])
        assert left == right
print("RESULT: PASS")
