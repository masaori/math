# 対象ラベル: transpose_of_matrix_sum
# 人手の成分の鎖 ((A+B)^T)_{pq} = (A+B)_{qp} = A_{qp} + B_{qp} = (A^T)_{pq} + (B^T)_{pq} = (A^T + B^T)_{pq} を、
# A, B の成分を QQ(i) 上の不定元にして、m, n = 1..3 の全成分で 1 行ずつ確かめる。
# 転置は def_matrix_transpose の成分の式 (B^T)_{pq} := B_{qp}、和は def_matrix_sum の成分の式で組む。
KG = QuadraticField(-1, 'i')
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        names = [f'a_{p}_{q}' for p in range(m) for q in range(n)] + [f'b_{p}_{q}' for p in range(m) for q in range(n)]
        P = PolynomialRing(KG, names)
        A = matrix(P, m, n, lambda p, q: P.gen(p * n + q))
        B = matrix(P, m, n, lambda p, q: P.gen(m * n + p * n + q))
        tr = lambda X: matrix(P, X.ncols(), X.nrows(), lambda p, q: X[q, p])   # def_matrix_transpose
        add = lambda X, Y: matrix(P, X.nrows(), X.ncols(), lambda p, q: X[p, q] + Y[p, q])  # def_matrix_sum
        S = add(A, B)
        lhs = tr(S); At = tr(A); Bt = tr(B); rhs = add(At, Bt)
        for p in range(n):
            for q in range(m):
                lines = [lhs[p, q], S[q, p], A[q, p] + B[q, p], At[p, q] + Bt[p, q], rhs[p, q]]
                for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                    assert a == b, (m, n, p, q, k)
                    count += 1
        assert lhs == rhs and lhs == (A + B).transpose()
# 否定コントロール: 右辺を A^T + A^T にすると（B ≠ A のとき）一致しない
P = PolynomialRing(KG, ['x', 'y'])
A = matrix(P, 1, 2, [P.gen(0), P.gen(1)]); B = matrix(P, 1, 2, [P.gen(1), P.gen(0)])
assert (A + B).transpose() != A.transpose() + A.transpose()
print(f"  {count} 段（m, n = 1..3 の全成分、成分は QQ(i) 上の不定元。厳密計算）")
print("  否定コントロール 1 件: 右辺を A^T + A^T にすると一致しない")
print("RESULT: PASS")
