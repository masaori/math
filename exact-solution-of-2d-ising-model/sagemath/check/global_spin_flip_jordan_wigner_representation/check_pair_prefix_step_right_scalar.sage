# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: 右側のスカラー倍を内側の行列積の外へ出す。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        prefix = sigma_x_prefix(M, r)
        local = site_operator(M, r, sigma_x)
        left = prefix * (-i * local)
        right = -i * (prefix * local)
        assert left == right
print("RESULT: PASS")
