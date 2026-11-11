# column_matrix_times_diagonal_matrix_scales_columns（[b_1 ⋯ b_p] D = [D_11 b_1 ⋯ D_pp b_p]）の証明の各行の検算。
# 成分は多項式環 QQ[b, d] の元として扱う（浮動小数点は使わない）。QQ[...] の乗法は可換なので、
# complex_numbers_form_a_field の積の可換律で移り合う行どうしは多項式として一致する。
# 範囲: n, p ∈ {1, 2, 3}、全ての (i, k)。

n_check = 0
def check(ok, label):
    global n_check
    n_check += 1
    assert ok, label

for n in [1, 2, 3]:
    for p in [1, 2, 3]:
        names = [f"b{k}_{j}" for k in range(p) for j in range(n)] + [f"d{k}" for k in range(p)]
        R = PolynomialRing(QQ, names)
        g = R.gens()
        b = [[g[k * n + j] for j in range(n)] for k in range(p)]          # (b_k)_j
        dd = g[n * p:]
        D = diagonal_matrix(R, dd)                                        # def_diagonal_matrix: 非対角成分 0
        Bcols = matrix(R, n, p, lambda j, k: b[k][j])                     # mat_columnwise の列に並べた行列
        RHS = matrix(R, n, p, lambda j, k: D[k, k] * b[k][j])             # [D_11 b_1 ⋯ D_pp b_p]（def_matrix_scalar_multiple）
        LHS = Bcols * D                                                   # mat_mult
        for i in range(n):
            for k in range(p):
                # 前置き: j ≠ k なら (b_j)_i D_jk = (b_j)_i 0 = 0
                for j in range(p):
                    if j != k:
                        pre = [b[j][i] * D[j, k], b[j][i] * 0, R(0)]
                        check(all(t == pre[0] for t in pre), f"前置き n={n} p={p} i={i} k={k} j={j}")
                chain = [
                    LHS[i, k],
                    sum(Bcols[i, j] * D[j, k] for j in range(p)),
                    sum(b[j][i] * D[j, k] for j in range(p)),
                    b[k][i] * D[k, k],
                    D[k, k] * b[k][i],
                    (D[k, k] * vector(R, b[k]))[i],
                    RHS[i, k],
                ]
                for t in range(len(chain) - 1):
                    check(chain[t] == chain[t + 1], f"n={n} p={p} (i,k)=({i},{k}) 第 {t+1} 行 = 第 {t+2} 行")
        check(LHS == RHS, f"n={n} p={p} 主張")
        print(f"n={n}, p={p}: 前置きと 6 行の鎖が全成分で一致")
        # 否定コントロール: (1,2) 成分に 1 を入れた対角でない D では成り立たない
        if p >= 2:
            Dbad = copy(D); Dbad[0, 1] = 1
            check(Bcols * Dbad != matrix(R, n, p, lambda j, k: Dbad[k, k] * b[k][j]), f"否定コントロール n={n} p={p}")
            print(f"n={n}, p={p}: 否定コントロール（非対角成分が 0 でない D では成り立たない）")

print(f"検算 {n_check} 件すべて PASS")
print("ALL PASS")
