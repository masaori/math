# 対象ラベル: mat_columnwise
# A ∈ Mat(m,n,C)、b_1,…,b_p ∈ C^n の成分を、有理数係数の多項式環の不定元として置く。
# 不定元どうしの多項式の等号は厳密に決定でき、不定元で成り立つ等号は、
# 成分へ任意の複素数を代入しても成り立つ（代入は環準同型であるため）。
# 浮動小数点と RR / CC への脱出はない。

SIZES = [(m, n, p) for m in [1, 2, 3] for n in [1, 2, 3] for p in [1, 2, 3]]

def generic_data(m, n, p):
    """A の成分 a_{i,j} と b_k の成分 b_{k,j} を不定元とする多項式環と、A・b_1,…,b_p を返す。"""
    names = [f"a_{i}_{j}" for i in range(m) for j in range(n)] \
          + [f"b_{k}_{j}" for k in range(p) for j in range(n)]
    R = PolynomialRing(QQ, names)
    gens = R.gens()
    A = matrix(R, m, n, gens[:m*n])
    rest = gens[m*n:]
    b = [vector(R, rest[k*n:(k+1)*n]) for k in range(p)]
    return R, A, b

def columns_matrix(R, rows, cols, vectors):
    """本文の「列に並べた行列」を、本文の定め方（第 k 列の第 j 成分が (vectors[k])_j）どおりに成分から組む。"""
    return matrix(R, rows, cols, lambda j, k: vectors[k][j])

def sage_column_matrix(R, vectors):
    """同じ行列を Sage 組み込みの column_matrix で組む。columns_matrix とは独立な経路である。"""
    return column_matrix(R, vectors)
