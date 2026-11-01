# 対象ラベル: mat_columnwise
# 主張そのもの: A[b_1 … b_p] = [A b_1 … A b_p] を行列全体の等号として確かめる。
# 左辺は Sage の行列積、右辺は各列の積を列に並べたもの。帰属: QQ 上の多項式環。
load("_prelude.sage")

for (m, n, p) in SIZES:
    R, A, b = generic_data(m, n, p)
    left = A * columns_matrix(R, n, p, b)
    right = sage_column_matrix(R, [A * b[k] for k in range(p)])
    assert left == right

print(f"checked {len(SIZES)} sizes")
print("RESULT: PASS")
