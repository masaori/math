# 対象ラベル: transpose_of_finite_sum_of_matrices
# 人手の帰納法の 2 本の鎖を、X_1, ..., X_r の成分を QQ(i) 上の不定元にして、m, n = 1..3、r = 1..4 で 1 行ずつ確かめる。
#   r = 1:     (Σ_{j=1}^{1} X_j)^T = X_1^T = Σ_{j=1}^{1} X_j^T
#   r → r+1:   (Σ_{j=1}^{r+1} X_j)^T = ((Σ_{j=1}^{r} X_j) + X_{r+1})^T = (Σ_{j=1}^{r} X_j)^T + X_{r+1}^T
#              = (Σ_{j=1}^{r} X_j^T) + X_{r+1}^T = Σ_{j=1}^{r+1} X_j^T
# 有限和は def_finite_sum_of_matrices のとおり左から足して組む（Sage の sum を使わない）。
KG = QuadraticField(-1, 'i')
count = 0
def lsum(Xs):                                   # def_finite_sum_of_matrices（左から足す）
    out = Xs[0]
    for X in Xs[1:]:
        out = out + X
    return out
for m in range(1, 4):
    for n in range(1, 4):
        rmax = 5
        names = [f'x{j}_{p}_{q}' for j in range(rmax) for p in range(m) for q in range(n)]
        P = PolynomialRing(KG, names)
        X = [matrix(P, m, n, lambda p, q, j=j: P.gen(j * m * n + p * n + q)) for j in range(rmax)]
        T = lambda Y: Y.transpose()                # def_matrix_transpose
        # r = 1
        lines = [T(lsum(X[:1])), T(X[0]), lsum([T(Y) for Y in X[:1]])]
        for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
            assert a == b, (m, n, 1, k); count += 1
        # r → r + 1（r = 1..4）
        for r in range(1, rmax):
            lines = [
                T(lsum(X[:r + 1])),
                T(lsum(X[:r]) + X[r]),
                T(lsum(X[:r])) + T(X[r]),                       # transpose_of_matrix_sum
                lsum([T(Y) for Y in X[:r]]) + T(X[r]),          # 帰納法の仮定
                lsum([T(Y) for Y in X[:r + 1]]),
            ]
            for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                assert a == b, (m, n, r, k); count += 1
# 否定コントロール: 右辺から最後の項を落とすと一致しない
P = PolynomialRing(KG, ['x', 'y'])
X = [matrix(P, 1, 1, [P.gen(0)]), matrix(P, 1, 1, [P.gen(1)])]
assert lsum(X).transpose() != X[0].transpose()
print(f"  {count} 段（m, n = 1..3、r = 1..4 の帰納法の段、成分は QQ(i) 上の不定元。厳密計算）")
print("  否定コントロール 1 件: 最後の項を落とすと一致しない")
print("RESULT: PASS")
