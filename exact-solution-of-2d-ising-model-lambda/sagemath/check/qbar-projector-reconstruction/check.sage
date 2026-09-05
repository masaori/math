# 対象ラベル: claim_qbar_projector_reconstruction
# 代数的数の厳密計算だけを使い、浮動小数点は使わない。


def matrix_vector_mul(A, v):
    return vector(QQbar, [sum((A[i, j] * v[j] for j in range(A.ncols())), QQbar(0))
                          for i in range(A.nrows())])


def matrix_power(A, k):
    result = identity_matrix(QQbar, A.nrows())
    for _ in range(k):
        result = A * result
    return result


def projector(L, A, z, v):
    return sum((z ** (L - k) * matrix_vector_mul(matrix_power(A, k), v)
                for k in range(L)), vector(QQbar, [0] * A.nrows()))


def check_reconstruction():
    count = 0
    polynomials = PolynomialRing(QQbar, "x")
    x = polynomials.gen()
    for L in range(1, 5):
        dimension = 2 ** L
        A = matrix(QQbar, dimension, dimension,
                   lambda i, j: QQbar((i + 1) * (j + 2) - (1 if i == j else 0)))
        v = vector(QQbar, [QQbar(i + 1) for i in range(dimension)])
        roots = [QQbar.zeta(L) ** j for j in range(L)]
        assert len(set(roots)) == L
        assert all(z ** L == 1 for z in roots)
        assert set(roots) == set((x ** L - 1).roots(multiplicities=False))

        for k in range(L):
            root_sum = sum((z ** (L - k) for z in roots), QQbar(0))
            assert root_sum == (QQbar(L) if k == 0 else QQbar(0))

        reconstructed = sum((QQbar(1) / QQbar(L) * projector(L, A, z, v)
                             for z in roots), vector(QQbar, [0] * dimension))
        assert reconstructed == v
        count += 1
    print("claim_qbar_projector_reconstruction: %d つの L ですべて通過" % count)


check_reconstruction()
