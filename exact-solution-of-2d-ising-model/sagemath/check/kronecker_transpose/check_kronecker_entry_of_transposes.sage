# 対象ラベル: kronecker_transpose
# 本文の第四行: ∏_k (A_k^⊤)_{i_k j_k} = (A_1^⊤⊠⋯⊠A_M^⊤)_{ν(I),ν(J)}（def_kronecker の成分の定め方）。
# 右辺は A_k^⊤ を Sage の transpose で取り、Sage の tensor_product で組んだ行列の成分。
# 帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for M in M_RANGE:
    R, A = generic_factors(M)
    AT = [B.transpose() for B in A]
    L = kron_by_sage(AT)
    assert L == kron_by_definition(R, AT)
    for I in index_set(M):
        for J in index_set(M):
            assert prod(entry(AT[k], I[k], J[k]) for k in range(M)) == entry(L, nu(I), nu(J))
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
