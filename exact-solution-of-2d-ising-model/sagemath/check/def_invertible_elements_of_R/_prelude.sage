# 対象ラベル: def_invertible_elements_of_R
# 共通の準備。行列の積・単位行列・スカラー倍は、本文の定め方どおりに成分から組む共通の準備
# _shared/matrix_operations_by_definition.sage を使う。
# 帰属: 一般の行列の等式は QQ 上の多項式環の不定元で、具体の可逆行列は QQ(i)（ガウス有理数体）で、
# スカラー c の逆元は有理関数体 QQ(c) で扱う。どれも厳密な等号で、浮動小数点は使わない。

# 本文の R = Mat(2^M, C) の 2^M。M = 1, 2, 3。
SIZES = [2, 4, 8]

K = QuadraticField(-1, 'i')
i_K = K.gen()

load("../../_shared/matrix_operations_by_definition.sage")

def generic_matrices(n, letters):
    """letters の各文字について、成分を QQ 上の不定元とする n×n 行列を返す。"""
    names = [f"{x}_{r}_{s}" for x in letters for r in range(n) for s in range(n)]
    P = PolynomialRing(QQ, names)
    g = P.gens()
    mats = [matrix(P, n, n, g[t*n*n:(t+1)*n*n]) for t in range(len(letters))]
    return P, mats

def concrete_invertible(n, seed):
    """QQ(i) の成分を持つ n×n の可逆行列を、乱数の種から決まる形で 1 つ返す。"""
    set_random_seed(seed)
    while True:
        g = matrix(K, n, n, lambda r, s: K(ZZ.random_element(-3, 4)) + K(ZZ.random_element(-3, 4)) * i_K)
        if g.det() != 0:
            return g

SEEDS = [11, 23, 37]
