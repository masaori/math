# =============================================================
# 素朴に組み上げ直した複素数の土台（check 100〜129 の共有ファイル）
#
# structured-latex の
#   <definition_of_cc>            C := R^2 と積 (a,b)(c,d) = (ac-bd, ad+bc)
#   <definition_of_sqrt_r_positive>  非負実数の平方根
#   <angle_section_existence_uniqueness> / <section_of_angle_representation>  s_{[0,2pi)}
#   <def_phi_polar> / <def_phi_cartesian>  phi_polar, phi_cartesian
#   <first_and_second_projections>  pr_1, pr_2
#   <def_abs_arg>                 |z|, arg^{[0,2pi)}
#   <def_sqrt_cc>                 C の sqrt
# の定義を、**そのまま写して**組み上げたもの。
#
# _shared/operators.sage の arg02pi / sqrt_cc_np（および _shared/defs.sage の
# arg_02pi / sqrt_cc）は本文定義の実装そのものなので、それらを両辺に使うと
# 同語反復になる。ここで用意した素朴な経路を片側に使うことで独立経路を確保する。
#
# 演算はすべて Sage の記号環（SR）上の**厳密**計算で行う。テスト点の座標を有理数に
# 取るので arg は arctan(有理数) と pi の有理数倍の和として厳密に表され、
# arg_1 + arg_2 = 2pi のような境界がちょうど成り立つ場合分けを正しく踏める。
#
# 使い方（例: 105 のディレクトリから）:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '../100_cosh_sinh_basic_properties/_prelude.sage'))
# =============================================================

_NPREC = 300
_NRF = RealField(_NPREC)
# 符号判定のしきい値。テスト点は有理座標なので、非零な量（arctan(有理数) と pi の
# 有理数倍の有限和の差など）がこの閾値を下回ることは無い。厳密な 0 だけがここへ入る。
_NEPS = _NRF(2) ** (-150)


def sgn0(v):
    """記号式 v の符号（-1 / 0 / +1）。|v| < 2^-150 を厳密な 0 とみなす。"""
    r = _NRF(SR(v))
    if abs(r) < _NEPS:
        return 0
    return 1 if r > 0 else -1


def is_zero0(v):
    return sgn0(v) == 0


# ---------------------------------------------------------
# 非負実数の平方根（<definition_of_sqrt_r_positive>）
# ---------------------------------------------------------
def sqrt_nonneg(x):
    """x >= 0 について y >= 0 かつ y^2 = x なる唯一の y。"""
    x = SR(x)
    if sgn0(x) < 0:
        raise ValueError("sqrt_nonneg: 負の実数 %s" % x)
    return sqrt(x)


# ---------------------------------------------------------
# 角度表現の切断 s_{[0,2pi)}（<section_of_angle_representation>）
#   0 <= theta - 2 n pi < 2 pi なる整数 n を、整数を走査して見つける。
#   floor を使わずに「条件を満たす n」を直接探すので、
#   <angle_section_existence_uniqueness> の主張の独立な検算にもなる。
# ---------------------------------------------------------
def angle_section_n(theta, width=4):
    """0 <= theta - 2 n pi < 2 pi を満たす n（複数見つかったら例外＝一意性の破れ）。"""
    theta = SR(theta)
    center = Integer((_NRF(theta) / _NRF(2 * pi)).floor())
    found = []
    for n in range(center - width, center + width + 1):
        v = theta - 2 * n * pi
        if sgn0(v) >= 0 and sgn0(v - 2 * pi) < 0:
            found.append(Integer(n))
    if len(found) != 1:
        raise ValueError("angle_section_n: n が %d 個見つかった (theta=%s)" % (len(found), theta))
    return found[0]


def s_02pi(theta):
    """s_{[0,2pi)}([theta]_~angle) = theta - 2 n pi。"""
    return SR(theta) - 2 * angle_section_n(theta) * pi


# ---------------------------------------------------------
# C の演算（<definition_of_cc>, <complex_numbers_form_a_field>）
#   複素数は (x, y) の 2 元組で表す。
# ---------------------------------------------------------
def C(x, y=0):
    return (SR(x), SR(y))


def cadd(z, w):
    return (z[0] + w[0], z[1] + w[1])


def cmul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])


def cneg(z):
    return (-z[0], -z[1])


def csub(z, w):
    return cadd(z, cneg(w))


def cinv(z):
    d = z[0] ** 2 + z[1] ** 2
    if is_zero0(d):
        raise ValueError("cinv: 0 の逆元")
    return (z[0] / d, -z[1] / d)


def cdiv(z, w):
    return cmul(z, cinv(w))


def ceq(z, w):
    return is_zero0(SR(z[0]) - SR(w[0])) and is_zero0(SR(z[1]) - SR(w[1]))


def to_complex(z):
    """(x, y) を numpy 比較用の Python complex へ。"""
    return complex(_NRF(SR(z[0])), _NRF(SR(z[1])))


C_ZERO = (SR(0), SR(0))
C_ONE = (SR(1), SR(0))


# ---------------------------------------------------------
# phi_polar（<def_phi_polar>）
#   定義の場合分けをそのまま写す。返り値は代表元 (r, theta)。
# ---------------------------------------------------------
def phi_polar_rep(z):
    x, y = SR(z[0]), SR(z[1])
    sx, sy = sgn0(x), sgn0(y)
    r = sqrt_nonneg(x ** 2 + y ** 2)
    if sx > 0:
        return (r, arctan(y / x))
    if sx < 0 and sy >= 0:
        return (r, arctan(y / x) + pi)
    if sx < 0 and sy < 0:
        return (r, arctan(y / x) - pi)
    if sx == 0 and sy > 0:
        return (y, SR(pi) / 2)
    if sx == 0 and sy < 0:
        return (-y, -SR(pi) / 2)
    return (SR(0), SR(0))


# ---------------------------------------------------------
# pr_1, pr_2（<first_and_second_projections>）
#   pr_2 は角度表現の代表元（実数）として返す。
# ---------------------------------------------------------
def pr1(rep):
    return rep[0]


def pr2(rep):
    r, th = rep
    return SR(0) if is_zero0(r) else SR(th)


# ---------------------------------------------------------
# phi_cartesian（<def_phi_cartesian>）
# ---------------------------------------------------------
def phi_cartesian(r, theta):
    return (SR(r) * cos(SR(theta)), SR(r) * sin(SR(theta)))


# ---------------------------------------------------------
# |z|, arg^{[0,2pi)}（<def_abs_arg>）
# ---------------------------------------------------------
def abs_naive(z):
    return pr1(phi_polar_rep(z))


def arg_naive(z):
    return s_02pi(pr2(phi_polar_rep(z)))


# ---------------------------------------------------------
# C の sqrt（<def_sqrt_cc>）
# ---------------------------------------------------------
def sqrt_cc_naive(z):
    rep = phi_polar_rep(z)
    return phi_cartesian(
        sqrt_nonneg(pr1(rep)),
        SR(1) / 2 * s_02pi(pr2(rep)),
    )


# ---------------------------------------------------------
# テスト点（すべて有理座標）
#   軸上・対角線上（arg が pi の有理数倍ちょうどになる境界）を必ず含める。
# ---------------------------------------------------------
NAIVE_TEST_POINTS = [
    # 軸上（arg = 0, pi/2, pi, 3pi/2）
    (1, 0), (5, 0), (-1, 0), (-3, 0), (0, 1), (0, 7), (0, -1), (0, -9),
    # 対角（arg = pi/4, 3pi/4, 5pi/4, 7pi/4）
    (1, 1), (-1, 1), (-1, -1), (1, -1), (2, 2), (-4, 4), (-3, -3), (5, -5),
    # 一般の有理点（4 象限）
    (3, 4), (-3, 4), (-3, -4), (3, -4),
    (1, 2), (2, 1), (-1, 2), (-2, 1), (-1, -2), (-2, -1), (1, -2), (2, -1),
    (1 / 2, 1 / 3), (-4 / 5, 3 / 7), (7 / 3, -2 / 9), (-5 / 6, -1 / 4),
    # 軸に極端に近い点（場合分けの境界近傍）
    (100, 1), (1, 100), (-100, 1), (1, -100), (-100, -1), (-1, -100),
]

NAIVE_TEST_POINTS_NZ = [C(x, y) for (x, y) in NAIVE_TEST_POINTS]
NAIVE_TEST_POINTS_ALL = NAIVE_TEST_POINTS_NZ + [C_ZERO]

# 積・和の検証で全 pair を回すと重いので、代表的な部分集合も用意する。
NAIVE_PAIR_POINTS = [
    C(1, 0), C(-1, 0), C(0, 1), C(0, -1),
    C(1, 1), C(-1, 1), C(-1, -1), C(1, -1),
    C(3, 4), C(-3, 4), C(-3, -4), C(3, -4),
    C(1 / 2, 1 / 3), C(-4 / 5, 3 / 7), C(7 / 3, -2 / 9), C(-5 / 6, -1 / 4),
    C(100, 1), C(-100, -1),
]
