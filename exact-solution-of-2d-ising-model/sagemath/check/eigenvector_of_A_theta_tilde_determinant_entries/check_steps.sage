# eigenvector_of_A_theta_tilde Step 1 の det(A(θ) − λI) の鎖のうち、差・スカラー倍・単位行列の定義の成分と
# x·1 = x、x·0 = 0、y − 0 = y の各行を、不定元 A11..A22, λ の多項式環で確かめる（浮動小数点は使わない）。
R.<A11, A12, A21, A22, lam, g1, a, b> = PolynomialRing(QQ)
A = [[A11, A12], [A21, A22]]
delta = lambda i, j: 1 if i == j else 0                                       # def_kronecker_delta
I = [[delta(i, j) for j in range(2)] for i in range(2)]                       # def_identity_matrix
lamI = [[lam * I[i][j] for j in range(2)] for i in range(2)]                  # def_matrix_scalar_multiple
AmlamI = [[A[i][j] - lamI[i][j] for j in range(2)] for i in range(2)]         # def_matrix_difference
det = lambda X: X[0][0]*X[1][1] - X[0][1]*X[1][0]                             # def_det_two_by_two
rows = [
    AmlamI,
    [[A[i][j] - lamI[i][j] for j in range(2)] for i in range(2)],            # def_matrix_difference
    [[A[i][j] - lam * I[i][j] for j in range(2)] for i in range(2)],         # def_matrix_scalar_multiple
    [[A[i][j] - lam * delta(i, j) for j in range(2)] for i in range(2)],     # def_identity_matrix
    [[A11 - lam*1, A12 - lam*0], [A21 - lam*0, A22 - lam*1]],                # def_kronecker_delta
    [[A11 - lam, A12 - lam*0], [A21 - lam*0, A22 - lam]],                    # x·1 = x
    [[A11 - lam, A12 - 0], [A21 - 0, A22 - lam]],                            # x·0 = 0
    [[A11 - lam, A12], [A21, A22 - lam]],                                    # y − 0 = y
]
for X in rows:
    assert X == rows[0], X
    assert det(X) == det(rows[0])
# Sage の組み込みの演算との一致
assert matrix(R, rows[-1]) == matrix(R, A) - lam * identity_matrix(R, 2)
# 最後の行: A(θ) = [[g1, a], [-b, g1]] を代入
sub = {A11: g1, A12: a, A21: -b, A22: g1}
assert matrix(R, rows[-1]).subs(sub) == matrix(R, [[g1 - lam, a], [-b, g1 - lam]])
# 否定コントロール: 単位行列の非対角を 1 にした行列から作り直すと、最後の行と一致しない
I_bad = [[1 for j in range(2)] for i in range(2)]
bad = [[A[i][j] - lam * I_bad[i][j] for j in range(2)] for i in range(2)]
assert bad != rows[-1] and det(bad) != det(rows[-1])
print("det(A − λI) の先頭の 8 行（差・スカラー倍・単位行列の成分と四則）が成分ごとに一致し、A(θ) の代入で [[g1−λ, a], [−b, g1−λ]]")
print("ALL PASS")
