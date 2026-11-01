# 対象ラベル: kronecker_transpose
# 本文の第三行: ∏_k (A_k)_{j_k i_k} = ∏_k (A_k^⊤)_{i_k j_k}（def_matrix_transpose で m=n=2 を各 k に適用）。
# A_k^⊤ は Sage 組み込みの transpose で取り、本文の定め方どおりに組んだ転置とも一致することを確かめる。
# 帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for M in M_RANGE:
    R, A = generic_factors(M)
    AT = [B.transpose() for B in A]
    for k in range(M):
        assert AT[k] == transpose_by_definition(R, A[k])
    for I in index_set(M):
        for J in index_set(M):
            left = prod(entry(A[k], J[k], I[k]) for k in range(M))
            right = prod(entry(AT[k], I[k], J[k]) for k in range(M))
            assert left == right
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
