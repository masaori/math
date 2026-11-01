# 対象ラベル: mat_columnwise
# 本文の第二行: Σ_j A_{ij} ([b_1 … b_p])_{jk} = Σ_j A_{ij} (b_k)_j（列に並べた行列の成分の定め方）。
# この行は定め方をそのまま当てはめる行なので、確かめられるのは
# 「本文の定め方どおりに成分から組んだ行列」と「Sage 組み込みの column_matrix で組んだ行列」が一致し、
# 後者の (j,k) 成分が (b_k)_j であることである。和の左辺は後者の成分で作る。
# 帰属: QQ 上の多項式環。添字は Sage の 0 始まり（本文の i,j,k から 1 を引いたもの）。
load("_prelude.sage")

count = 0
for (m, n, p) in SIZES:
    R, A, b = generic_data(m, n, p)
    B = sage_column_matrix(R, b)
    assert B.dimensions() == (n, p)
    assert B == columns_matrix(R, n, p, b)
    for i in range(m):
        for k in range(p):
            left = sum(A[i, j] * B[j, k] for j in range(n))
            right = sum(A[i, j] * b[k][j] for j in range(n))
            assert left == right
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
