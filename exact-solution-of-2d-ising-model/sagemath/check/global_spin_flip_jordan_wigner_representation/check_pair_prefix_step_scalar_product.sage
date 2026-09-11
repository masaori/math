# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 二つのスカラー倍を結合する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        product = sigma_x_prefix(M, r) * site_operator(M, r, sigma_x)
        left = (-i)**r * (-i * product)
        right = (((-i)**r) * (-i)) * product
        assert left == right
print("RESULT: PASS")
