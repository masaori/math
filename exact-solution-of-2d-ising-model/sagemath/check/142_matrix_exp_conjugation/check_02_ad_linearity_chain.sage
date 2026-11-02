# 対象ラベル: matrix_exp_conjugation
# Step 1（ad_X は C-線型）の二つの鎖を一行ずつ確かめる。
#   ad_X(Z+W) = X(Z+W)-(Z+W)X = (XZ+XW)-(ZX+WX) = (XZ-ZX)+(XW-WX) = ad_X(Z)+ad_X(W)
#   ad_X(cZ)  = X(cZ)-(cZ)X = c(XZ)-(cZ)X = c(XZ)-c(ZX) = c(XZ-ZX) = c ad_X(Z)
#   2 行目から 3 行目は scalar_multiple_factors_out_of_right_factor（X(cZ)=c(XZ)）、
#   3 行目から 4 行目は scalar_multiple_factors_out_of_left_factor（(cZ)X=c(ZX)）、
#   4 行目から 5 行目は scalar_multiple_distributes_over_matrix_difference（c(XZ)-c(ZX)=c(XZ-ZX)）。
# X, Z, W の成分と c を QQ(i) 上の多項式環の独立な不定元に置く（n = 1, 2, 3）。厳密等号。
GAUSSIAN = QuadraticField(-1, "i")

def ad(X, Y):
    return X * Y - Y * X

def scalar_times(c, A):
    # def_matrix_scalar_multiple のとおり成分ごとに掛ける
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, j: c * A[i, j])

count = 0
for n in range(1, 4):
    names = [f"x{i}{j}" for i in range(n) for j in range(n)] + \
            [f"z{i}{j}" for i in range(n) for j in range(n)] + \
            [f"w{i}{j}" for i in range(n) for j in range(n)] + ["c"]
    R = PolynomialRing(GAUSSIAN, names)
    g = R.gens()
    X = matrix(R, n, n, g[0:n * n])
    Z = matrix(R, n, n, g[n * n:2 * n * n])
    W = matrix(R, n, n, g[2 * n * n:3 * n * n])
    c = g[-1]
    chain_sum = [
        ad(X, Z + W),
        X * (Z + W) - (Z + W) * X,
        (X * Z + X * W) - (Z * X + W * X),
        (X * Z - Z * X) + (X * W - W * X),
        ad(X, Z) + ad(X, W),
    ]
    assert all(m == chain_sum[0] for m in chain_sum), n
    cZ = scalar_times(c, Z)
    chain_scalar = [
        ad(X, cZ),
        X * cZ - cZ * X,
        scalar_times(c, X * Z) - cZ * X,
        scalar_times(c, X * Z) - scalar_times(c, Z * X),
        scalar_times(c, X * Z - Z * X),
        scalar_times(c, ad(X, Z)),
    ]
    assert all(m == chain_scalar[0] for m in chain_scalar), n
    # 各段で使った主張そのもの
    assert X * cZ == scalar_times(c, X * Z)
    assert cZ * X == scalar_times(c, Z * X)
    assert scalar_times(c, X * Z) - scalar_times(c, Z * X) == scalar_times(c, X * Z - Z * X)
    # 対照: 第 2 項の c を落とすと一致しない（差は (c−1)ZX で、不定元の多項式として零でない）
    assert X * cZ - Z * X != chain_scalar[0]
    count += 1
print(f"PASS: ad_X の線型性の二つの鎖（n = 1..{count}）を厳密等号で確かめた")
