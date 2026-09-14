# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: AI=IA=A により P_{r+1} のクロネッカー積表示を得る。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        left = kronecker_factors([
            sigma_x * identity_two if site < r else
            identity_two * sigma_x if site == r else
            identity_two * identity_two for site in range(M)
        ])
        assert left == sigma_x_prefix_factors(M, r + 1)
print("RESULT: PASS")
