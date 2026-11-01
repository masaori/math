# 対象ラベル: trace_basic_properties
# 共通の準備。行列の積・和・スカラー倍・単位行列は、本文の定め方どおりに成分から組む共通の準備
# _shared/matrix_operations_by_definition.sage を使う。トレースは def_trace の対角成分の和として下の body_trace で組む。
# 帰属: 一般の等式は QQ（または QQ(i)）上の多項式環の不定元で、具体の可逆行列は QQ(i) で扱う。浮動小数点は使わない。
# 比べる側には Sage 組み込みの trace・行列積・行列の和・スカラー倍・identity_matrix・inverse を独立な経路として使う。

load("../../_shared/matrix_operations_by_definition.sage")

# 行列の大きさ n。一般の n は検算の範囲外で、人手証明が担う。
SIZES = [1, 2, 3, 4, 5]

K = QuadraticField(-1, 'i')
i_K = K.gen()


def body_trace(A):
    """def_trace の tr(A) := Σ_{k=1}^{n} A_{kk}。"""
    n = A.nrows()
    assert A.ncols() == n
    return sum((A[k, k] for k in range(n)), A.base_ring()(0))


def generic(n, letters, scalars=(), base=QQ):
    """letters の各文字について成分を base 上の不定元とする n×n 行列と、scalars の不定元を返す。"""
    names = list(scalars) + [f"{x}_{r}_{s}" for x in letters for r in range(n) for s in range(n)]
    P = PolynomialRing(base, names)
    g = P.gens()
    sc = g[:len(scalars)]
    pos = len(scalars)
    mats = [matrix(P, n, n, g[pos + t*n*n: pos + (t+1)*n*n]) for t in range(len(letters))]
    return P, sc, mats


def concrete_invertible(n, seed):
    """QQ(i) の成分を持つ n×n の可逆行列を、乱数の種から決まる形で 1 つ返す。"""
    set_random_seed(seed)
    while True:
        g = matrix(K, n, n, lambda r, s: K(ZZ.random_element(-3, 4)) + K(ZZ.random_element(-3, 4)) * i_K)
        if g.det() != 0:
            return g


SEEDS = [11, 23, 37]
