# 対象ラベル: config_basis_vector_own_component
# 証明の四行:
#   (f_I)_{ν(I)} = (e_{i_1}⊠⋯⊠e_{i_M})_{ν(I)} = ∏_k (e_{i_k})_{i_k} = ∏_k 1 = 1
# 第一行は Sage の tensor_product で組んだ f_I の成分、第二行は因子の成分を左から掛けた積、
# 第三行は 1 を M 個掛けた積、第四行は 1。対照として、ν(J)（J ≠ I）の成分は 0 であることも確かめる
# （主張の対象外だが、第一行が自明でないことの確かめ）。帰属: ZZ。M = 1,…,6、すべての I。
load("../../_shared/site_sigma_z_kronecker.sage")

def left_to_right_product(zs):
    acc = zs[0]
    for w in zs[1:]:
        acc = acc * w
    return acc

count = 0
for M in range(1, 7):
    for Ivec in index_set(M):
        f = f_basis(Ivec)
        line1 = f[nu(Ivec) - 1, 0]
        line2 = left_to_right_product([E[i][i - 1, 0] for i in Ivec])
        assert all(E[i][i - 1, 0] == 1 for i in Ivec)
        line3 = left_to_right_product([1] * M)
        assert line1 == line2 == line3 == 1
        for J in index_set(M):
            if J != Ivec:
                assert f[nu(J) - 1, 0] == 0
        count += 1
print(f"checked {count} multi-indices")
print("RESULT: PASS")
