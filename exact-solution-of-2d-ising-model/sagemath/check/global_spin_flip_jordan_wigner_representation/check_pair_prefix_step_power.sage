# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 本文: ((-i)^r(-i))=(-i)^(r+1)。
load("_prelude.sage")
for M in [1, 2, 3, 4, 5]:
    for r in range(M):
        product = sigma_x_prefix(M, r) * site_operator(M, r, sigma_x)
        assert (((-i)**r) * (-i)) * product == (-i)**(r + 1) * product
print("RESULT: PASS")
