# ---------------------------------------------------------
# 共通: 偶セクター（半整数運動量）での T の作用を検証するための道具立て
#   structured-latex/content/014_even_sector_T_action.ts に対応
#
#   theta~_mu = 2 pi (mu - 1/2) / M
#   checkZ_mu = sum_{j=1}^{M} Z_j e^{-i j theta~_mu}
#   checkY_mu = sum_{j=1}^{M} Y_j e^{-i j theta~_mu}
#
#   V_1^{(+)}       = exp(i K_1 H_1^{(+)})
#   (V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)})
#   V_2             = (2 s_2)^{M/2} exp(i K_2^* H_2)
#   V^{(+)}         = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
#   T_g(X)          = g X g^{-1}
#
#   B_1(theta) = [[cosh K1,            -i e^{ i theta} sinh K1],
#                 [i e^{-i theta} sinh K1,  cosh K1           ]]
#   B_2        = [[cosh 2K2*,  i sinh 2K2*],
#                 [-i sinh 2K2*, cosh 2K2* ]]
#   A(theta)   = [[c1 c2* - s1 s2* cos t,
#                  i e^{ i t} s2* (c1 cos t - i sin t - s1 c2)],
#                 [-i e^{-i t} s2* (c1 cos t + i sin t - s1 c2),
#                  c1 c2* - s1 s2* cos t]]
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))


def th_tilde(M, mu):
    """theta~_mu := 2 pi (mu - 1/2) / M"""
    return CDF(2 * pi * (RDF(mu) - RDF(1) / 2) / M)


def checkZ(O, mu):
    t = th_tilde(O.M, mu)
    out = matrix(CDF, O.d, O.d, 0)
    for j in range(1, O.M + 1):
        out = out + O.Z[j] * eiph(-j * t)
    return matrix(CDF, out)


def checkY(O, mu):
    t = th_tilde(O.M, mu)
    out = matrix(CDF, O.d, O.d, 0)
    for j in range(1, O.M + 1):
        out = out + O.Y[j] * eiph(-j * t)
    return matrix(CDF, out)


def B1(K1, t):
    """B_1(theta)"""
    a = CDF(cosh(RDF(K1)))
    b = CDF(sinh(RDF(K1)))
    return matrix(CDF, [[a, -CDF(I) * eiph(t) * b],
                        [CDF(I) * eiph(-t) * b, a]])


def B2(K2s):
    """B_2（K2s = K_2^*）"""
    C = CDF(cosh(2 * RDF(K2s)))
    S = CDF(sinh(2 * RDF(K2s)))
    return matrix(CDF, [[C, CDF(I) * S], [-CDF(I) * S, C]])


def A_theta(K1, K2, t):
    """A(theta)（def_A_theta）。K2s は K2 から導く。"""
    K2s = K_star(K2)
    c1 = CDF(cosh(2 * RDF(K1)))
    s1 = CDF(sinh(2 * RDF(K1)))
    c2 = CDF(cosh(2 * RDF(K2)))
    c2s = CDF(cosh(2 * RDF(K2s)))
    s2s = CDF(sinh(2 * RDF(K2s)))
    ct = CDF(cos(CDF(t)))
    st = CDF(sin(CDF(t)))
    g1 = c1 * c2s - s1 * s2s * ct
    g2 = CDF(I) * eiph(t) * s2s * (c1 * ct - CDF(I) * st - s1 * c2)
    g2m = -CDF(I) * eiph(-t) * s2s * (c1 * ct + CDF(I) * st - s1 * c2)
    return matrix(CDF, [[g1, g2], [g2m, g1]])


def combine(Zc, Yc, col):
    """(checkZ, checkY) (a; b) = a checkZ + b checkY"""
    return col[0] * Zc + col[1] * Yc


def V1p_half(O, K1):
    """(V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)}) とその逆行列"""
    A = CDF(I) / 2 * RDF(K1) * O.H1(+1)
    return matrix(CDF, A.exp()), matrix(CDF, (-A).exp())


def V2_mat(O, K2):
    """V_2 = (2 s_2)^{M/2} exp(i K_2^* H_2) とその逆行列（前因子を明示的に付ける）"""
    K2s = K_star(K2)
    A = CDF(I) * RDF(K2s) * O.H2
    s2 = RDF(sinh(2 * RDF(K2)))
    pref = CDF((2 * s2) ** (RDF(O.M) / 2))
    return pref * matrix(CDF, A.exp()), (1 / pref) * matrix(CDF, (-A).exp())


EVEN_M = [2, 3, 4, 5]
EVEN_PARAMS = [
    {'K1': 0.4, 'K2': 0.8},
    {'K1': 1.2, 'K2': 0.3},
    {'K1': 0.4407, 'K2': 0.4407},   # 臨界点上（等方的、sinh2K1 sinh2K2 = 1）
    {'K1': 0.44, 'K2': 0.45},       # 臨界点近傍（非等方的）
    {'K1': 0.05, 'K2': 0.1},        # 高温極限付近
]
TOL = 1e-8
