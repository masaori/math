# 1 行 1 列の行列 [x]_K（本文 def_one_by_one_matrix）と、行列の積・冪の本文どおりの定め方。
# 数の exp（def_scalar_exp）の三つの主張 scalar_exp_is_limit_of_partial_sums・scalar_exp_product・
# scalar_exp_zero の検算が使う。
#
# 係数: 本文の K = R の検算は QQ、K = C の検算は QQ(i)（ガウス有理数。QuadraticField(-1)、
# 生成元を ii と書き、複素数 1j へ埋め込む）を使う。どちらも可算で、等号は厳密に決定できる。
# 不定元を置くときは、これらの上の多項式環を使う。不定元で成り立つ多項式の等号は、
# 不定元へ K の任意の元を代入しても成り立つ（代入は環準同型である）。
# 添字は本文の 1 始まりで持ち、Sage の行列を引くときだけ 1 を引く。

GAUSSIAN = QuadraticField(-1, 'ii')
COEFFICIENT_FIELDS = [("K = R（係数 QQ）", QQ), ("K = C（係数 QQ(i)）", GAUSSIAN)]


def one_by_one(R, x):
    """本文 def_one_by_one_matrix の [x]_K。ただ 1 つの成分が x の 1 行 1 列の行列。"""
    return matrix(R, 1, 1, [x])


def entry(A, p, q):
    """本文の 1 始まりの成分 A_{pq}。"""
    return A[p - 1, q - 1]


def entry11(A):
    return entry(A, 1, 1)


def product_entry_by_definition(A, B, p, q):
    """本文 mat_mult の (AB)_{pq} = Σ_{j=1}^{n} A_{pj} B_{jq} を、和として直接書いたもの。"""
    return sum(entry(A, p, j) * entry(B, j, q) for j in range(1, A.ncols() + 1))


def matrix_power_by_definition(A, m):
    """本文 def_exp (1) の A^0 := I、A^{m+1} := A^m A を、右から 1 つずつ掛けて作る。
    Sage の A^m（二乗を繰り返す計算）とは独立な経路である。"""
    P = identity_matrix(A.base_ring(), A.nrows())
    for _ in range(m):
        P = P * A
    return P


def scalar_power_by_definition(x, m):
    """数の冪 x^0 := 1、x^{m+1} := x^m x を、右から 1 つずつ掛けて作る。"""
    p = x.parent()(1)
    for _ in range(m):
        p = p * x
    return p


def matrix_partial_sum(A, N):
    """本文 matrix_exp_series_converges の S_N(A) = Σ_{m=0}^{N} (1/m!) A^m。冪は本文の定め方で作る。"""
    S = matrix(A.base_ring(), A.nrows(), A.ncols())
    for m in range(N + 1):
        S = S + (QQ(1) / factorial(m)) * matrix_power_by_definition(A, m)
    return S


def body_real_exp_ball(x0, N=None, prec=512):
    """本文の実数の exp(x) := (exp([x]_R))_11（x ∈ QQ）を含む実数のボール（RealBallField(prec)）。
    中心は 1 行 1 列の行列の部分和 S_N([x]_R) の成分（N の既定は max(150, ⌈8|x|⌉)）（QQ の中で厳密）、半径は尾の評価 2|x|^{N+1}/(N+1)!。
    本文の exp(x) がこのボールに入る根拠: scalar_exp_is_limit_of_partial_sums により S_M → exp(x)（M → ∞）であり、
    N + 2 ≥ 2|x| のとき M > N で |S_M - S_N| ≤ (|x|^{N+1}/(N+1)!) Σ_k 2^{-k} ≤ 2|x|^{N+1}/(N+1)!
    （比 |x|/(N+2) ≤ 1/2 の等比級数との比較。この尾の評価は本文には無く、検算の側で導いたもの）なので、
    M → ∞ で |exp(x) - S_N| ≤ 2|x|^{N+1}/(N+1)!。Arb の exp は使わない。"""
    RBF_ = RealBallField(prec)
    x0 = QQ(x0)
    if N is None:
        N = max(150, ceil(8 * abs(x0)))
    assert N + 2 >= 2 * abs(x0)
    center = entry11(matrix_partial_sum(one_by_one(QQ, x0), N))
    radius = 2 * abs(x0)^(N + 1) / factorial(N + 1)
    return RBF_(center).add_error(RBF_(radius).upper())


def truncate_total_degree(p, D):
    """多項式 p から全次数が D を超える項を落とす。単変数と多変数で係数の取り出し方が違うので分ける。"""
    if p.parent().ngens() == 1:
        return p.truncate(D + 1)
    return sum((c * m for c, m in zip(p.coefficients(), p.monomials()) if m.degree() <= D), p.parent()(0))
