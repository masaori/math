# 対象ラベル: transpose_of_matrix_difference
# 人手の成分の鎖 ((A-B)^T)_{ki} = (A-B)_{ik} = A_{ik} - B_{ik} = (A^T)_{ki} - (B^T)_{ki} = (A^T - B^T)_{ki} を、
# A, B の成分を QQ(i) 上の不定元にして、m, p = 1..3 の全成分で 1 行ずつ確かめる。
# 転置は def_matrix_transpose、差は def_matrix_difference の成分の式で組む。
KG = QuadraticField(-1, 'i')
count = 0
for m in range(1, 4):
    for pp in range(1, 4):
        names = [f'a_{r}_{s}' for r in range(m) for s in range(pp)] + [f'b_{r}_{s}' for r in range(m) for s in range(pp)]
        P = PolynomialRing(KG, names)
        A = matrix(P, m, pp, lambda r, s: P.gen(r * pp + s))
        B = matrix(P, m, pp, lambda r, s: P.gen(m * pp + r * pp + s))
        tr = lambda X: matrix(P, X.ncols(), X.nrows(), lambda r, s: X[s, r])   # def_matrix_transpose
        sub = lambda X, Y: matrix(P, X.nrows(), X.ncols(), lambda r, s: X[r, s] - Y[r, s])  # def_matrix_difference
        D = sub(A, B)
        lhs = tr(D); At = tr(A); Bt = tr(B); rhs = sub(At, Bt)
        for k in range(pp):
            for i in range(m):
                lines = [lhs[k, i], D[i, k], A[i, k] - B[i, k], At[k, i] - Bt[k, i], rhs[k, i]]
                for t, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                    assert a == b, (m, pp, k, i, t)
                    count += 1
        assert lhs == rhs and lhs == (A - B).transpose()
# 否定コントロール: 右辺を B^T - A^T にすると（A ≠ B のとき）一致しない
P = PolynomialRing(KG, ['x', 'y'])
A = matrix(P, 1, 1, [P.gen(0)]); B = matrix(P, 1, 1, [P.gen(1)])
assert (A - B).transpose() != B.transpose() - A.transpose()
print(f"  {count} 段（m, p = 1..3 の全成分、成分は QQ(i) 上の不定元。厳密計算）")
print("  否定コントロール 1 件: 右辺を B^T - A^T にすると一致しない")
print("RESULT: PASS")
