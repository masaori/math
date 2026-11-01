# 対象ラベル: mat_columnwise
# 本文の第一行: (A[b_1 … b_p])_{ik} = Σ_{j=1}^{n} A_{ij} ([b_1 … b_p])_{jk}（行列の積の定義 mat_mult）。
# 左辺は Sage の行列積、右辺は成分の和を直接書いたもの。帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for (m, n, p) in SIZES:
    R, A, b = generic_data(m, n, p)
    B = sage_column_matrix(R, b)
    product = A * B
    for i in range(m):
        for k in range(p):
            right = sum(A[i, j] * B[j, k] for j in range(n))
            assert product[i, k] == right
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
