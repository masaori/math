# 本文の定め方どおりに成分から組む行列の積・単位行列・スカラー倍。
# 積は mat_mult の (AB)_{ik} = Σ_j A_{ij} B_{jk}、単位行列は def_identity_matrix と def_kronecker_delta の
# I_{ij} = δ_{ij}、スカラー倍は def_matrix_scalar_multiple の (aA)_{ij} = a A_{ij}。
# Sage の行列積 `*`・identity_matrix・スカラー倍 `a*A`・inverse は、これらとは独立な経路として比べる側にだけ使う。


def body_product(A, B):
    """mat_mult の成分の式で積を組む。"""
    m, n, p = A.nrows(), A.ncols(), B.ncols()
    assert B.nrows() == n
    R = A.base_ring()
    return matrix(R, m, p, lambda i, k: sum(A[i, j] * B[j, k] for j in range(n)))


def body_delta(R, i, j):
    """def_kronecker_delta の δ_{ij}。"""
    return R(1) if i == j else R(0)


def body_identity(R, n):
    """def_identity_matrix の単位行列を δ から組む。"""
    return matrix(R, n, n, lambda i, j: body_delta(R, i, j))


def body_scalar(a, A):
    """def_matrix_scalar_multiple のスカラー倍を成分から組む。"""
    R = A.base_ring()
    return matrix(R, A.nrows(), A.ncols(), lambda i, j: R(a) * A[i, j])


def generic_ring(shapes, scalars=()):
    """shapes の各 (文字, 行数, 列数) について成分を QQ 上の不定元とする行列と、scalars の不定元を返す。"""
    names = list(scalars) + [f"{x}_{r}_{s}" for (x, m, n) in shapes for r in range(m) for s in range(n)]
    P = PolynomialRing(QQ, names)
    g = P.gens()
    sc = g[:len(scalars)]
    pos = len(scalars)
    mats = []
    for (x, m, n) in shapes:
        mats.append(matrix(P, m, n, g[pos:pos + m*n]))
        pos += m*n
    return P, sc, mats
