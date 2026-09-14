# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: I=I⊠⋯⊠I。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    assert identity_matrix(K, 2**M) == kronecker_factors([identity_two for _ in range(M)])
print("RESULT: PASS")
