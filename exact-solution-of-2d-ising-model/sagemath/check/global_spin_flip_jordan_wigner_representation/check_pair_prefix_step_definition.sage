# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: Q_{r+1}=Q_r(Z_{r+1}Y_{r+1})。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        pair = jordan_wigner(M, r, sigma_z) * jordan_wigner(M, r, sigma_y)
        assert pair_prefix(M, r + 1) == pair_prefix(M, r) * pair
print("RESULT: PASS")
