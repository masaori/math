# 対象ラベル: transpose_of_matrix_scalar_multiple
# 人手の成分の鎖 ((cA)^T)_{pq} = (cA)_{qp} = c A_{qp} = c (A^T)_{pq} = (c A^T)_{pq} を、
# c と A の成分を QQ(i) 上の不定元にして、m, n = 1..3 の全成分で 1 行ずつ確かめる。
# 転置は def_matrix_transpose、スカラー倍は def_matrix_scalar_multiple の成分の式で組む。
KG = QuadraticField(-1, 'i')
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        names = ['c'] + [f'a_{p}_{q}' for p in range(m) for q in range(n)]
        P = PolynomialRing(KG, names)
        c = P.gen(0)
        A = matrix(P, m, n, lambda p, q: P.gen(1 + p * n + q))
        tr = lambda X: matrix(P, X.ncols(), X.nrows(), lambda p, q: X[q, p])   # def_matrix_transpose
        sm = lambda a, X: matrix(P, X.nrows(), X.ncols(), lambda p, q: a * X[p, q])  # def_matrix_scalar_multiple
        cA = sm(c, A)
        lhs = tr(cA); At = tr(A); rhs = sm(c, At)
        for p in range(n):
            for q in range(m):
                lines = [lhs[p, q], cA[q, p], c * A[q, p], c * At[p, q], rhs[p, q]]
                for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                    assert a == b, (m, n, p, q, k)
                    count += 1
        assert lhs == rhs and lhs == (c * A).transpose()
# 否定コントロール: 右辺で係数を落として A^T にすると一致しない
P = PolynomialRing(KG, ['c', 'x'])
A = matrix(P, 1, 1, [P.gen(1)])
assert (P.gen(0) * A).transpose() != A.transpose()
print(f"  {count} 段（m, n = 1..3 の全成分、c と成分は QQ(i) 上の不定元。厳密計算）")
print("  否定コントロール 1 件: 係数を落とすと一致しない")
print("RESULT: PASS")
