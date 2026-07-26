# ---------------------------------------------------------
# 共通: 偶セクター（半整数運動量）のフェルミオン checkpsi と V' の検証道具
#   structured-latex/content/016_even_sector_fermions.ts に対応
#
#   theta~_mu = 2 pi (mu - 1/2) / M
#   checkZ_mu = sum_{j=1}^{M} Z_j e^{-i j theta~_mu}
#   checkY_mu = sum_{j=1}^{M} Y_j e^{-i j theta~_mu}
#
#   gamma_1(th) = c_1 c_2^* - s_1 s_2^* cos th
#   gamma_2(th) = i e^{i th} s_2^* (c_1 cos th - i sin th - s_1 c_2)
#   r_mu        = |gamma_2(theta~_mu)|,  b_mu = gamma_2(-theta~_mu)
#
#   checkP_mu = [[-r_mu/(2 sqrt(M) b_mu), +r_mu/(2 sqrt(M) b_mu)],
#                [ 1/(2 sqrt(M)),          1/(2 sqrt(M))        ]]
#   (checkpsi_mu^dagger, checkpsi_mu) = (checkZ_mu, checkY_mu) checkP_mu
#
#   gamma(theta~_mu) = arccosh(gamma_1(theta~_mu))
#   checkV' = exp( sum_{mu=1}^{M} gamma(theta~_mu) (checkpsi_mu^dagger checkpsi_{1-mu} - 1/2) )
#
#   V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
#
# **注意**: 反交換関係の対は mu + nu ≡ 1 (mod M)（013 章 anticommutator_of_check_Z_Y）。
#           整数運動量の mu + nu ≡ 0 とは異なる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

TOL = 1e-8


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


def gam1(K1, K2, t):
    K2s = K_star(K2)
    c1 = RDF(cosh(2 * RDF(K1)))
    s1 = RDF(sinh(2 * RDF(K1)))
    c2s = RDF(cosh(2 * RDF(K2s)))
    s2s = RDF(sinh(2 * RDF(K2s)))
    return RDF(c1 * c2s - s1 * s2s * cos(RDF(t.real() if hasattr(t, 'real') else t)))


def gam2(K1, K2, t):
    K2s = K_star(K2)
    c1 = RDF(cosh(2 * RDF(K1)))
    s1 = RDF(sinh(2 * RDF(K1)))
    c2 = RDF(cosh(2 * RDF(K2)))
    s2s = RDF(sinh(2 * RDF(K2s)))
    tt = RDF(t.real() if hasattr(t, 'real') else t)
    return CDF(CDF(I) * eiph(tt) * s2s * (c1 * cos(tt) - CDF(I) * sin(tt) - s1 * c2))


def A_theta(K1, K2, t):
    """A(theta) = [[g1, g2(th)], [-g2(-th), g1]]（def_A_theta / def_gamma1_gamma2_of_theta）"""
    g1 = gam1(K1, K2, t)
    tt = RDF(t.real() if hasattr(t, 'real') else t)
    return matrix(CDF, [[g1, gam2(K1, K2, tt)], [-gam2(K1, K2, -tt), g1]])


def gamma_tilde(K1, K2, M, mu):
    """gamma(theta~_mu) := arccosh(gamma_1(theta~_mu))"""
    return RDF(arccosh(gam1(K1, K2, th_tilde(M, mu))))


def checkP(K1, K2, M, mu):
    """checkP_mu（diagonalization_check_P_D の正規化）"""
    t = th_tilde(M, mu)
    r = RDF(abs(gam2(K1, K2, t)))
    b = gam2(K1, K2, -t)
    n = CDF(2 * RDF(M).sqrt())
    return matrix(CDF, [[-r / (n * b), r / (n * b)], [1 / n, 1 / n]])


def checkD(K1, K2, M, mu):
    g = gamma_tilde(K1, K2, M, mu)
    return matrix(CDF, [[CDF(exp(g)), 0], [0, CDF(exp(-g))]])


def fermions(O, K1, K2, mu):
    """(checkpsi_mu^dagger, checkpsi_mu) = (checkZ_mu, checkY_mu) checkP_mu"""
    M = O.M
    P = checkP(K1, K2, M, mu)
    Zc, Yc = checkZ(O, mu), checkY(O, mu)
    psi_dag = P[0, 0] * Zc + P[1, 0] * Yc
    psi = P[0, 1] * Zc + P[1, 1] * Yc
    return matrix(CDF, psi_dag), matrix(CDF, psi)


def acomm(A, B):
    return A * B + B * A


def delta_M(k, target, M):
    """delta^M_{(k, target)}: k ≡ target (mod M) なら 1、そうでなければ 0"""
    return 1 if ((k - target) % M) == 0 else 0


def V1p_half(O, K1):
    """(V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)}) とその逆行列"""
    A = CDF(I) / 2 * RDF(K1) * O.H1(+1)
    return matrix(CDF, A.exp()), matrix(CDF, (-A).exp())


def V2_mat(O, K2):
    """V_2 = (2 s_2)^{M/2} exp(i K_2^* H_2) とその逆行列"""
    K2s = K_star(K2)
    A = CDF(I) * RDF(K2s) * O.H2
    s2 = RDF(sinh(2 * RDF(K2)))
    pref = CDF((2 * s2) ** (RDF(O.M) / 2))
    return pref * matrix(CDF, A.exp()), (1 / pref) * matrix(CDF, (-A).exp())


def V_plus(O, K1, K2):
    """V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2} とその逆行列"""
    E1, E1i = V1p_half(O, K1)
    E2, E2i = V2_mat(O, K2)
    return matrix(CDF, E1 * E2 * E1), matrix(CDF, E1i * E2i * E1i)


def X_gen(O, K1, K2):
    """X := sum_{mu=1}^{M} gamma(theta~_mu) (checkpsi_mu^dagger checkpsi_{1-mu} - 1/2)"""
    M = O.M
    out = matrix(CDF, O.d, O.d, 0)
    Id = identity_matrix(CDF, O.d)
    for mu in range(1, M + 1):
        g = gamma_tilde(K1, K2, M, mu)
        pd, _ = fermions(O, K1, K2, mu)
        _, p_conj = fermions(O, K1, K2, 1 - mu)
        out = out + g * (pd * p_conj - Id / 2)
    return matrix(CDF, out)


def checkVprime(O, K1, K2):
    """checkV' = exp(X) とその逆行列 exp(-X)"""
    X = X_gen(O, K1, K2)
    return matrix(CDF, X.exp()), matrix(CDF, (-X).exp())


EVEN_M = [2, 3, 4, 5]
EVEN_PARAMS = [
    {'K1': 0.4, 'K2': 0.8},
    {'K1': 1.2, 'K2': 0.3},
    {'K1': 0.4407, 'K2': 0.4407},   # 臨界点上（等方的、sinh 2K1 sinh 2K2 = 1）
    {'K1': 0.44, 'K2': 0.45},       # 臨界点近傍（非等方的）
    {'K1': 0.05, 'K2': 0.1},        # 高温極限付近
]
