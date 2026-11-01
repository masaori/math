# 対象ラベル: mat_columnwise
# 本文の第四行: (A b_k)_i = ([A b_1 … A b_p])_{ik}（列に並べた行列の成分の定め方）。
# この行は定め方をそのまま当てはめる行なので、右辺の行列は Sage 組み込みの column_matrix で組み、
# 本文の定め方どおりに成分から組んだ行列と一致することも確かめる。
# 帰属: QQ 上の多項式環。添字は Sage の 0 始まり。
load("_prelude.sage")

count = 0
for (m, n, p) in SIZES:
    R, A, b = generic_data(m, n, p)
    products = [A * b[k] for k in range(p)]
    C = sage_column_matrix(R, products)
    assert C.dimensions() == (m, p)
    assert C == columns_matrix(R, m, p, products)
    for i in range(m):
        for k in range(p):
            assert products[k][i] == C[i, k]
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
