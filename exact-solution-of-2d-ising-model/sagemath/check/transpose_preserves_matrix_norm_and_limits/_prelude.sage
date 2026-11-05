# 対象ラベル: transpose_preserves_matrix_norm, transpose_preserves_matrix_limits
# 共通の準備。ℂ を本文 definition_of_cc どおり実数の対で持ち（_shared/complex_as_real_pairs.sage）、
# 行列は対を成分に持つ n×n の表として、本文の定め方どおりに成分から組む:
# 転置 (A^⊤)_{kl} := A_{lk}（def_matrix_transpose）、差は def_matrix_difference の成分の式、
# ノルムは def_matrix_norm の √(Σ_iΣ_j |a_ij|^2)（|z|^2 = x^2 + y^2 は abs_basic_properties (2)）。
# 比べる側: 対 (x, y) を QQ(i) 係数の x + i y へ送った Sage の行列の transpose と、QQbar の abs で組んだ Frobenius ノルム。
load("../../_shared/complex_as_real_pairs.sage")

SIZES = [1, 2, 3, 4]
K = QuadraticField(-1, 'i')
i_K = K.gen()


def generic_pairs(n, letters):
    names = [f"{x}_{k}_{l}_{c}" for x in letters for k in range(n) for l in range(n) for c in "ri"]
    P = PolynomialRing(QQ, names)
    g = P.gens()
    mats = []
    pos = 0
    for _ in letters:
        mats.append([[(g[pos + 2 * (k * n + l)], g[pos + 2 * (k * n + l) + 1]) for l in range(n)] for k in range(n)])
        pos += 2 * n * n
    return P, mats


def body_transpose(A):
    n = len(A)
    return [[A[l][k] for l in range(n)] for k in range(n)]


def body_diff(A, B, R):
    n = len(A)
    return [[cc_sub(A[k][l], B[k][l], R) for l in range(n)] for k in range(n)]


def abs2(z):
    return z[0]^2 + z[1]^2


def norm_aa(M):
    n = len(M)
    return AA(sum(abs2(M[k][l]) for k in range(n) for l in range(n))).sqrt()


def to_gauss(A):
    n = len(A)
    return matrix(K, n, n, lambda k, l: K(A[k][l][0]) + i_K * K(A[k][l][1]))


def frob(M):
    n = M.nrows()
    return AA(sum(QQbar(M[k, l]).abs()^2 for k in range(n) for l in range(n))).sqrt()


def to_pairs(M):
    n = M.nrows()
    return [[(QQ(M[r, s].real()), QQ(M[r, s].imag())) for s in range(n)] for r in range(n)]
