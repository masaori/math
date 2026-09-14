# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Z_{r+1}Y_{r+1}=-iσ^x_{r+1} を代入する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        pair = jordan_wigner(M, r, sigma_z) * jordan_wigner(M, r, sigma_y)
        left = (-i)**r * sigma_x_prefix(M, r) * pair
        right = (-i)**r * sigma_x_prefix(M, r) * (-i * site_operator(M, r, sigma_x))
        assert left == right
print("RESULT: PASS")
