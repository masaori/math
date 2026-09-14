# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: σ^x_{r+1} をサイト行列のクロネッカー積へ展開する。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        left = sigma_x_prefix_factors(M, r) * site_operator(M, r, sigma_x)
        right = sigma_x_prefix_factors(M, r) * kronecker_factors([
            sigma_x if site == r else identity_two for site in range(M)
        ])
        assert left == right
print("RESULT: PASS")
