# 対象ラベル: kronecker_transpose
# 共通の準備。A_1,…,A_M ∈ Mat(2,C) の成分を QQ 上の多項式環の不定元として置く。
# 不定元どうしの多項式の等号は厳密に決定でき、不定元で成り立つ等号は成分へ任意の複素数を
# 代入しても成り立つ（代入は環準同型であるため）。浮動小数点と RR / CC への脱出はない。
# 添字は本文の 1 始まりで持ち、Sage の行列を引くときだけ 1 を引く。
import itertools

M_RANGE = [1, 2, 3, 4]

def generic_factors(M):
    """A_k の (i,j) 成分を不定元 a_k_i_j とする多項式環と、A_1,…,A_M（Sage の行列）を返す。"""
    names = [f"a_{k}_{i}_{j}" for k in range(1, M + 1) for i in (1, 2) for j in (1, 2)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    A = [matrix(R, 2, 2, g[4 * k:4 * k + 4]) for k in range(M)]
    return R, A

def index_set(M):
    """本文の添字集合 I_M = {1,2}^M。"""
    return list(itertools.product((1, 2), repeat=M))

def nu(I):
    """本文 def_kronecker の ν(I) = 1 + Σ_k (i_k - 1) 2^{M-k}（値は 1 始まり）。"""
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2**(M - k) for k in range(1, M + 1))

def entry(B, p, q):
    """本文の 1 始まりの成分 B_{pq}。"""
    return B[p - 1, q - 1]

def kron_by_definition(R, A):
    """本文 def_kronecker の (2) どおり、(A_1⊠⋯⊠A_M)_{ν(I),ν(J)} := ∏_k (A_k)_{i_k j_k} で成分から組む。"""
    M = len(A)
    K = matrix(R, 2**M, 2**M)
    for I in index_set(M):
        for J in index_set(M):
            K[nu(I) - 1, nu(J) - 1] = prod(entry(A[k], I[k], J[k]) for k in range(M))
    return K

def kron_by_sage(A):
    """同じ行列を Sage 組み込みの tensor_product で組む。kron_by_definition とは独立な経路である。"""
    K = A[0]
    for B in A[1:]:
        K = K.tensor_product(B)
    return K

def transpose_by_definition(R, B):
    """本文 def_matrix_transpose どおり、(B^⊤)_{pq} := B_{qp} で成分から組む（B は m 行 n 列）。"""
    m, n = B.nrows(), B.ncols()
    return matrix(R, n, m, lambda p, q: B[q, p])
