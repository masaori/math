# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 左側のスカラー倍を行列積の外へ出す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        prefix = sigma_x_prefix(M, r)
        local = -i * site_operator(M, r, sigma_x)
        left = ((-i)**r * prefix) * local
        right = (-i)**r * (prefix * local)
        assert left == right
print("RESULT: PASS")
