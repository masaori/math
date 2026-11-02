# 数学的道具立ての章の、実対数と区間 [0, π] 上の積分の主張（real_log_of_product から three_halves_power_integral_bound まで）の
# 検算が使う共通の準備。check/<対象名>/ から読む前提の相対パスで読み込む。
#
# - 実対数 log（本文 def_real_logarithm_positive）は exp の逆写像で、本文の exp は標準の実数の exp に等しいので、
#   Arb の log（標準の実対数を囲むボール）で囲む。本文の exp の値を使う行は、hyperbolic_by_definition.sage の
#   exp_ball_of_ball（本文の部分和に尾の評価を足したもの。Arb の exp は使わない）で囲む。
# - 積分は Arb の厳密な数値積分（ComplexBallField.integral。被積分関数を区間で評価し、誤差の上界を含むボールを返す）で
#   囲む。π を端点に持つので θ = πu と置き換えて [0, 1] 上で積分する（dθ = π du）。
# - 大小は差のボールの下端の符号で判定し、許容誤差は置かない。等号は差のボールが 0 を含み、半径が 2^{-200} 未満であることで見る。
load("../../_shared/hyperbolic_by_definition.sage")
CBF256 = ComplexBallField(256)
RBF256 = RealBallField(256)
PI_BALL = RBF256.pi()

def surely_le(a, b):
    """ボール a, b について a ≤ b が確定するか（b - a の下端 ≥ 0）。"""
    return (RBF512(b) - RBF512(a)).lower() >= 0

def surely_lt(a, b):
    return (RBF512(b) - RBF512(a)).lower() > 0

def surely_equal(a, b):
    diff = RBF512(a) - RBF512(b)
    return diff.contains_zero() and diff.rad() < QQ(2)^(-200)

def integral_over_zero_pi(g):
    """∫_0^π g(θ) dθ を囲む実数のボール。g は CBF256 の元 θ と analytic 引数を受け取り、CBF256 の元を返す。"""
    pi_c = CBF256.pi()
    I = CBF256.integral(lambda u, an: pi_c * g(pi_c * u, an), 0, 1)
    assert I.imag().contains_zero()
    return RBF512(I.real())

def log_ball(x):
    """本文 def_real_logarithm_positive の log(x)（x > 0）を囲むボール。"""
    xb = RBF512(x)
    assert xb.lower() > 0
    return xb.log()
