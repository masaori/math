# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 帰納法の仮定 Q_r=(-i)^rP_r を代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        pair = jordan_wigner(M, r, sigma_z) * jordan_wigner(M, r, sigma_y)
        left = pair_prefix(M, r) * pair
        right = (-i)**r * sigma_x_prefix(M, r) * pair
        assert left == right
print("RESULT: PASS")
