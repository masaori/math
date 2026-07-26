# ---------------------------------------------------------
# 共通: 半整数運動量 theta~_mu = 2 pi (mu - 1/2) / M における A(theta~_mu)
#   structured-latex/content/015_A_theta_tilde_diagonalization.ts に対応
#
#   gamma_1(th) = c_1 c_2^* - s_1 s_2^* cos th
#   gamma_2(th) = i e^{i th} s_2^* (c_1 cos th - i sin th - s_1 c_2)
#   A(th) = [[gamma_1(th), gamma_2(th)], [-gamma_2(-th), gamma_1(th)]]
#
# _shared/defs.sage は symbolic 版（K1, K2 を変数に残す）だが、ここでは
# 多数の (M, mu, K_1, K_2) を回すので RDF/CDF の数値版を用意する。
# ---------------------------------------------------------
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'

TOL = 1e-10
CI = CDF(I)


def K2_star_of(K2):
    """K_2^* := -1/2 log(tanh K_2)"""
    return -RDF(log(tanh(RDF(K2)))) / 2


def coeffs(K1, K2):
    """def_transfer_matrix_symbols の c_1, s_1, c_2, s_2, c_2^*, s_2^* を数値で返す。"""
    K1 = RDF(K1)
    K2 = RDF(K2)
    K2s = K2_star_of(K2)
    return {
        'K1': K1, 'K2': K2, 'K2s': K2s,
        'c1': RDF(cosh(2 * K1)), 's1': RDF(sinh(2 * K1)),
        'c2': RDF(cosh(2 * K2)), 's2': RDF(sinh(2 * K2)),
        'c2s': RDF(cosh(2 * K2s)), 's2s': RDF(sinh(2 * K2s)),
    }


def g1(th, P):
    return RDF(P['c1'] * P['c2s'] - P['s1'] * P['s2s'] * cos(RDF(th)))


def g2(th, P):
    th = RDF(th)
    return CDF(CI * exp(CI * th) * P['s2s'] *
               (P['c1'] * cos(th) - CI * sin(th) - P['s1'] * P['c2']))


def A_mat(th, P):
    return matrix(CDF, [[g1(th, P), g2(th, P)],
                        [-g2(-th, P), g1(th, P)]])


def th_tilde(M, mu):
    """半整数運動量 theta~_mu = 2 pi (mu - 1/2) / M"""
    return RDF(2 * pi * (RDF(mu) - RDF(1) / 2) / M)


def th_int(M, mu):
    """整数運動量 theta_mu = 2 pi mu / M（対比用）"""
    return RDF(2 * pi * RDF(mu) / M)


def arg_02pi(z):
    """arg^{[0,2pi)}"""
    z = CDF(z)
    if z == 0:
        raise ValueError("arg is undefined for 0")
    a = RDF(z.argument())
    if a < 0:
        a += 2 * RDF(pi)
    return a


def sqrt_cc(z):
    """本プロジェクト定義の sqrt（arg を [0,2pi) で取り半分にする）"""
    z = CDF(z)
    if z == 0:
        return CDF(0)
    return CDF(RDF(abs(z)).sqrt() * exp(CI * arg_02pi(z) / 2))


def clean_real(z, rel=1e-12):
    """虚部が相対的に無視できるなら実数へ丸める。

    本プロジェクトの sqrt は arg^{[0,2pi)} を半分にする定義なので、**正の実軸で不連続**である
    （arg = 0 なら +sqrt、arg -> 2pi なら -sqrt）。-gamma_2(th) gamma_2(-th) = |gamma_2|^2 は
    数学的には正の実数だが、倍精度計算では虚部に -0 や -1e-17 が残り、arg^{[0,2pi)} が 2pi 側に
    落ちて符号が反転してしまう。数値検証ではその丸めを明示的に取り除く。
    """
    z = CDF(z)
    if abs(z.imag()) <= rel * max(1.0, abs(z)):
        return CDF(z.real())
    return z


def K2_critical(K1):
    """sinh(2K_1) sinh(2K_2) = 1 を満たす K_2（臨界点）"""
    K1 = RDF(K1)
    return RDF(arcsinh(1 / sinh(2 * K1))) / 2


# ---------------------------------------------------------
# パラメータ集合
#   CRIT_*: 厳密な臨界点 sinh 2K_1 sinh 2K_2 = 1（gamma_2 の零点が存在しうる唯一の場所）
#   NEAR_*: その近傍
#   GEN_* : 一般の点
# ---------------------------------------------------------
def _crit(K1):
    return (RDF(K1), K2_critical(K1))


def _near(K1, eps):
    K1 = RDF(K1)
    return (K1, K2_critical(K1) * (1 + RDF(eps)))


K_CASES = [
    _crit(0.4),                      # 臨界点（非等方）
    _crit(0.4406867935097715),       # 臨界点（等方 K_1 = K_2 = K_c）
    _crit(0.2),
    _crit(1.2),
    _near(0.4, 1e-9), _near(0.4, -1e-9),
    _near(0.4, 1e-4), _near(0.4, -1e-4),
    _near(0.4406867935097715, 1e-6), _near(0.4406867935097715, -1e-6),
    (RDF(0.4), RDF(0.8)), (RDF(0.7), RDF(0.3)), (RDF(0.25), RDF(1.1)),
    (RDF(1.2), RDF(0.3)), (RDF(0.05), RDF(0.1)), (RDF(0.3), RDF(5.0)),
]

M_CASES = [2, 3, 4, 5, 6, 7, 8]


def case_label(K1, K2):
    return f"K1={float(K1):.10g}, K2={float(K2):.10g} (s1*s2={float(sinh(2*RDF(K1))*sinh(2*RDF(K2))):.10g})"
