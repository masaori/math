# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: P_r は先頭 r 因子が sigma^x、残りが I のクロネッカー積である。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M + 1):
        assert sigma_x_prefix(M, r) == sigma_x_prefix_factors(M, r)
print("RESULT: PASS")
