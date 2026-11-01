# 対象ラベル: star_preserves_norm_and_limits
# 共通の準備。ℂ を本文 definition_of_cc どおり実数の対で持ち（_shared/complex_as_real_pairs.sage）、
# 行列は対を成分に持つ n×n の表（Python のリストのリスト）として、本文の定め方どおりに成分から組む:
# 共役転置 (A^*)_{kl} := conj(A_{lk})（def_hermitian_positive_definite）、積 (AB)_{kl} := Σ_j A_{kj}B_{jl}（mat_mult、
# 有限和は def_finite_sum_of_complex_numbers のとおり左から足す）、和・スカラー倍・差は def_matrix_sum・def_matrix_scalar_multiple・
# def_matrix_difference の成分の式。
# 比べる側: 対 (x, y) を QQ(i) 係数の x + i y へ送った Sage の行列と、その conjugate_transpose・積・和・スカラー倍・差。
# 不定元の x, y は実の不定元なので、係数の共役が複素共役に当たる。
load("../../_shared/complex_as_real_pairs.sage")

SIZES = [1, 2, 3, 4]
K = QuadraticField(-1, 'i')
i_K = K.gen()


def generic_pairs(n, letters, scalars=()):
    """letters の各文字について成分を QQ 上の不定元の対とする n×n の表と、scalars の不定元の対を返す。"""
    names = [f"{s}_{c}" for s in scalars for c in "ri"]
    names += [f"{x}_{k}_{l}_{c}" for x in letters for k in range(n) for l in range(n) for c in "ri"]
    P = PolynomialRing(QQ, names)
    g = P.gens()
    sc = [(g[2 * t], g[2 * t + 1]) for t in range(len(scalars))]
    pos = 2 * len(scalars)
    mats = []
    for _ in letters:
        mats.append([[(g[pos + 2 * (k * n + l)], g[pos + 2 * (k * n + l) + 1]) for l in range(n)] for k in range(n)])
        pos += 2 * n * n
    return P, sc, mats


def fsum(zs):
    s = zs[0]
    for q in zs[1:]:
        s = cc_add(s, q)
    return s


def body_star(A):
    n = len(A)
    return [[cc_conj(A[l][k]) for l in range(n)] for k in range(n)]


def body_prod(A, B):
    n = len(A)
    return [[fsum([cc_mul(A[k][j], B[j][l]) for j in range(n)]) for l in range(n)] for k in range(n)]


def body_sum(A, B):
    n = len(A)
    return [[cc_add(A[k][l], B[k][l]) for l in range(n)] for k in range(n)]


def body_scalar(a, A):
    n = len(A)
    return [[cc_mul(a, A[k][l]) for l in range(n)] for k in range(n)]


def body_diff(A, B, R):
    n = len(A)
    return [[cc_sub(A[k][l], B[k][l], R) for l in range(n)] for k in range(n)]


def gauss_ring(P):
    return PolynomialRing(K, P.variable_names())


def to_gauss_scalar(z, PK):
    return PK(z[0]) + i_K * PK(z[1])


def to_gauss(A, PK):
    n = len(A)
    return matrix(PK, n, n, lambda k, l: to_gauss_scalar(A[k][l], PK))


def sage_star(M):
    """比べる側の共役転置: 係数の共役を取って転置する（QQ(i) 係数の多項式の行列でも使える形）。"""
    return M.transpose().apply_map(lambda p: p.map_coefficients(lambda c: c.conjugate()))
