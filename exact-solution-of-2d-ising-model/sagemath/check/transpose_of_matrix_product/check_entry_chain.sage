# 対象ラベル: transpose_of_matrix_product
# 人手の成分の鎖
#   ((AB)^T)_{kl} = (AB)_{lk} = Σ_j A_{lj} B_{jk} = Σ_j (A^T)_{jl} (B^T)_{kj} = Σ_j (B^T)_{kj} (A^T)_{jl} = (B^T A^T)_{kl}
# を、A, B の成分を QQ(i) 上の不定元にして、m, n, p = 1..3 の全成分で 1 行ずつ確かめる。
# 転置は def_matrix_transpose の成分の式 (B^T)_{pq} := B_{qp}、積は mat_mult の成分の式で組む。
KG = QuadraticField(-1, 'i')
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        for p in range(1, 4):
            names = [f'a_{r}_{c}' for r in range(m) for c in range(n)] + [f'b_{r}_{c}' for r in range(n) for c in range(p)]
            P = PolynomialRing(KG, names)
            A = matrix(P, m, n, lambda r, c: P.gen(r * n + c))
            B = matrix(P, n, p, lambda r, c: P.gen(m * n + r * p + c))
            tr = lambda X: matrix(P, X.ncols(), X.nrows(), lambda r, c: X[c, r])   # def_matrix_transpose
            mul = lambda X, Y: matrix(P, X.nrows(), Y.ncols(),
                                      lambda r, c: sum(X[r, j] * Y[j, c] for j in range(X.ncols())))  # mat_mult
            AB = mul(A, B)
            At = tr(A); Bt = tr(B)
            lhs = tr(AB); rhs = mul(Bt, At)
            for k in range(p):
                for l in range(m):
                    lines = [
                        lhs[k, l],
                        AB[l, k],
                        sum(A[l, j] * B[j, k] for j in range(n)),
                        sum(At[j, l] * Bt[k, j] for j in range(n)),
                        sum(Bt[k, j] * At[j, l] for j in range(n)),
                        rhs[k, l],
                    ]
                    for s, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                        assert a == b, (m, n, p, k, l, s)
                        count += 1
            assert lhs == rhs and lhs == (A * B).transpose()
# 否定コントロール: 右辺を順序を変えない A^T B^T にすると（正方で非可換な例で）一致しない
P = PolynomialRing(KG, 4, 'x')
A = matrix(P, 2, 2, [0, 1, 0, 0]); B = matrix(P, 2, 2, [0, 0, 1, 0])
assert (A * B).transpose() != A.transpose() * B.transpose()
print(f"  {count} 段（m, n, p = 1..3 の全成分、成分は QQ(i) 上の不定元。厳密計算）")
print("  否定コントロール 1 件: 右辺を A^T B^T にすると一致しない")
print("RESULT: PASS")
