# 双曲線関数 cosh・sinh（本文 def_cosh_sinh）と arcsinh（def_arcsinh）を本文の定め方どおりに組む共通の準備。
# 数学的道具立ての章の双曲線関数の主張（cosh_is_even から sinh_at_most_argument_times_cosh まで）の検算が使う。
# check/<対象名>/ から読む前提の相対パスで読み込む。
#
# 三つの持ち方を使い分ける。
# - exp の値を不定元に置く（exp_value_ring）: exp の性質を使わない行。不定元で成り立つ有理式の等号は、
#   不定元へ実数の exp の値を代入しても成り立つ（代入は環準同型である）。
# - 形式冪級数（exp_series）: exp の積の法則を使う行。本文の実数の exp は 1 行 1 列の行列の exp の成分で、
#   部分和の極限なので、全次数 D 以下の部分で比べる（引数が定数項 0 の多項式なら、exp([z]) の D 次の切り捨ては
#   部分和 S_D([z]) の D 次の切り捨てに等しい）。
# - ボール（exp_ball など）: 主張そのものと、不等号の行を具体の点で確かめる。値が QQ に収まらないので
#   RealBallField へ脱出する。exp は本文の部分和に尾の評価を半径として足したもので、Arb の exp は使わない。
load("../../_shared/one_by_one_matrix.sage")

D_SERIES = 14
PREC = 512
RBF512 = RealBallField(PREC)


def cosh_by_definition(e_plus, e_minus):
    """本文 def_cosh_sinh: cosh x := (exp(x) + exp(-x))/2。引数は exp(x) と exp(-x) の値。"""
    return (e_plus + e_minus) / 2


def sinh_by_definition(e_plus, e_minus):
    """本文 def_cosh_sinh: sinh x := (exp(x) - exp(-x))/2。引数は exp(x) と exp(-x) の値。"""
    return (e_plus - e_minus) / 2


def exp_series(R, z, D=D_SERIES):
    """本文の実数の exp(z) の全次数 D 以下の部分。z は QQ 上の多項式環 R の、定数項 0 の元。"""
    assert R(z).constant_coefficient() == 0
    return truncate_total_degree(entry11(matrix_partial_sum(one_by_one(R, R(z)), D)), D)


def cosh_series(R, z, D=D_SERIES):
    return cosh_by_definition(exp_series(R, z, D), exp_series(R, -z, D))


def sinh_series(R, z, D=D_SERIES):
    return sinh_by_definition(exp_series(R, z, D), exp_series(R, -z, D))


def exp_ball(x0):
    """本文の exp(x0)（x0 ∈ QQ）を含むボール。one_by_one_matrix.sage の body_real_exp_ball。"""
    return body_real_exp_ball(QQ(x0), prec=PREC)


def cosh_ball(x0):
    return cosh_by_definition(exp_ball(x0), exp_ball(-QQ(x0)))


def sinh_ball(x0):
    return sinh_by_definition(exp_ball(x0), exp_ball(-QQ(x0)))


def exp_ball_of_ball(xb, N=200):
    """本文の exp(x) を、x がボール xb に入るどの実数でも含むボール。中心は部分和 S_N をボール演算で
    本文の定め方（冪を右から 1 つずつ掛ける）のまま計算したもの、半径に尾の評価 2r^{N+1}/(N+1)! を足す
    （r は |x| の上界。N + 2 ≥ 2r のとき尾は比 1/2 の等比級数で抑えられる。body_real_exp_ball と同じ評価）。"""
    xb = RBF512(xb)
    r = xb.abs().upper()
    assert N + 2 >= 2 * r
    S = RBF512(0)
    power = RBF512(1)
    for m in range(N + 1):
        S = S + power / factorial(m)
        power = power * xb
    tail = 2 * RBF512(r)^(N + 1) / factorial(N + 1)
    return S.add_error(tail.upper())


def sqrt_ball(w0):
    """本文 definition_of_sqrt_r_positive の √w（w ≥ 0）を含むボール。Arb の sqrt は非負の平方根を囲む。"""
    return RBF512(w0).sqrt()


def arcsinh_ball(y0):
    """本文 def_arcsinh の arcsinh(y0) = log(y0 + √(y0²+1)) を含むボール。log は本文 def_real_logarithm_positive の
    exp の逆写像で、本文の exp は標準の実数の exp に等しいので、Arb の log（標準の実対数）で囲める。"""
    y0 = QQ(y0)
    return (RBF512(y0) + sqrt_ball(y0^2 + 1)).log()
