# 対象ラベル: mat_columnwise
# 本文の第三行: Σ_j A_{ij} (b_k)_j = (A b_k)_i（行列の積の定義 mat_mult を A b_k へ適用）。
# 右辺は Sage の行列とベクトルの積。帰属: QQ 上の多項式環。
load("_prelude.sage")

count = 0
for (m, n, p) in SIZES:
    R, A, b = generic_data(m, n, p)
    for k in range(p):
        Ab = A * b[k]
        for i in range(m):
            left = sum(A[i, j] * b[k][j] for j in range(n))
            assert left == Ab[i]
            count += 1

print(f"checked {count} entries")
print("RESULT: PASS")
