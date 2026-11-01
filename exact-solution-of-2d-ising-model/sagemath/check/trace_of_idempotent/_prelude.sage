# 対象ラベル: trace_of_idempotent
# 共通の準備。行列の積・単位行列・和は _shared/matrix_operations_by_definition.sage の本文の定め方どおりの組み方を使う。
# 差は def_matrix_difference、トレースは def_trace、冪は def_exp (1) の A^0 := I, A^{m+1} := A^m A のとおりに下で組む。
# 帰属: 冪等行列はガウス有理数体 QQ(i) の具体の行列、ベクトル x は QQ(i) 上の多項式環の不定元で持つ。浮動小数点は使わない。
# 比べる側には Sage 組み込みの行列積・trace・rank・column_space・right_kernel・inverse・solve_right を独立な経路として使う。
load("../../_shared/matrix_operations_by_definition.sage")

SIZES = [1, 2, 3, 4, 5]
SEEDS = [5, 17, 29]

K = QuadraticField(-1, 'i')
i_K = K.gen()


def body_difference(A, B):
    """def_matrix_difference の (A - B)_{ik} := A_{ik} - B_{ik}。"""
    assert A.nrows() == B.nrows() and A.ncols() == B.ncols()
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda i, k: A[i, k] - B[i, k])


def body_zero(R, m, p):
    """def_zero_matrix の零行列（p = 1 なら零ベクトル）。"""
    return matrix(R, m, p, lambda i, k: R(0))


def body_trace(A):
    """def_trace の tr(A) := Σ_k A_kk。"""
    n = A.nrows()
    return sum((A[k, k] for k in range(n)), A.base_ring()(0))


def body_power(A, m):
    """def_exp (1) の A^0 := I、A^{m+1} := A^m A。"""
    R = A.base_ring()
    X = body_identity(R, A.nrows())
    for _ in range(m):
        X = body_product(X, A)
    return X


def columns_matrix(R, vecs, n):
    """mat_columnwise の [b_1 ... b_p]（第 k 列の第 j 成分が (b_k)_j）。vecs は n×1 の行列の並び。"""
    return matrix(R, n, len(vecs), lambda j, k: vecs[k][j, 0])


def concrete_invertible(n, seed):
    set_random_seed(seed)
    while True:
        g = matrix(K, n, n, lambda r, s: K(ZZ.random_element(-3, 4)) + K(ZZ.random_element(-3, 4)) * i_K)
        if g.det() != 0:
            return g


def idempotents(n):
    """各 r = 0..n について、QQ(i) の冪等行列 S diag(1^r, 0^{n-r}) S^{-1} を種ごとに返す（エルミートとは限らない）。"""
    out = []
    for r in range(n + 1):
        Dr = diagonal_matrix(K, [1] * r + [0] * (n - r))
        for seed in SEEDS:
            S = concrete_invertible(n, seed + 100 * r)
            Q = S * Dr * S.inverse()
            assert Q * Q == Q
            out.append((r, seed, Q))
    return out
