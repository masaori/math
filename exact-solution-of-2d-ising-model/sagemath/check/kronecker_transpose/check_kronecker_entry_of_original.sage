# 対象ラベル: kronecker_transpose
# 本文の第二行: (A_1⊠⋯⊠A_M)_{ν(J),ν(I)} = ∏_k (A_k)_{j_k i_k}（def_kronecker の成分の定め方）。
# 左辺は Sage の tensor_product で組んだ行列の成分、右辺は不定元の積を直接書いたもの。
# あわせて、本文の定め方どおりに成分から組んだ行列が tensor_product の行列と一致する
# （ν の番号の付け方が Sage のクロネッカー積の行・列の並びと同じである）ことを確かめる。
# 帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for M in M_RANGE:
    R, A = generic_factors(M)
    K = kron_by_sage(A)
    assert K == kron_by_definition(R, A)
    for I in index_set(M):
        for J in index_set(M):
            assert entry(K, nu(J), nu(I)) == prod(entry(A[k], J[k], I[k]) for k in range(M))
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
