# 対象ラベル: kronecker_transpose
# 本文の第一行: ((A_1⊠⋯⊠A_M)^⊤)_{ν(I),ν(J)} = (A_1⊠⋯⊠A_M)_{ν(J),ν(I)}（def_matrix_transpose で m=n=2^M）。
# 転置は Sage 組み込みの transpose で取り、本文の定め方どおりに成分から組んだ転置とも一致することを確かめる。
# クロネッカー積は Sage の tensor_product で組む。帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for M in M_RANGE:
    R, A = generic_factors(M)
    K = kron_by_sage(A)
    KT = K.transpose()
    assert KT == transpose_by_definition(R, K)
    for I in index_set(M):
        for J in index_set(M):
            assert entry(KT, nu(I), nu(J)) == entry(K, nu(J), nu(I))
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
