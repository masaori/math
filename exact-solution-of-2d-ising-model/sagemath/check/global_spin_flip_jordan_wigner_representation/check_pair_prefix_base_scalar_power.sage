# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: I=(-i)^0I。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    identity = identity_matrix(K, 2**M)
    assert identity == (-i)**0 * identity
print("RESULT: PASS")
