# ---------------------------------------------------------
# 共通: 章 C′（013〜016 章）の証明を「1 ステップ 1 定理」へ分割した結果、
#       本文に**明示的に現れるようになった中間等式**を検証するための道具立て。
#
#   theta~_mu   = 2 pi (mu - 1/2) / M
#   checkZ_mu   = sum_{j=1}^{M} Z_j e^{-i j theta~_mu}
#   checkY_mu   = sum_{j=1}^{M} Y_j e^{-i j theta~_mu}
#
#   Y^flat_0     = -Y_M,  Y^flat_j = Y_j (1<=j<=M)      （反周期的な延長）
#   Z^flat_{M+1} = -Z_1,  Z^flat_j = Z_j (1<=j<=M)
#
#   gamma_1(t)  = c_1 c_2* - s_1 s_2* cos t
#   gamma_2(t)  = i e^{i t} s_2* (c_1 cos t - i sin t - s_1 c_2)
#   gamma(t~_mu)= arccosh(gamma_1(t~_mu))
#
#   B_1(t) = [[cosh K_1, -i e^{it} sinh K_1], [i e^{-it} sinh K_1, cosh K_1]]
#   B_2    = [[cosh 2K_2*, i sinh 2K_2*], [-i sinh 2K_2*, cosh 2K_2*]]
#   A(t)   = [[gamma_1(t), gamma_2(t)], [-gamma_2(-t), gamma_1(t)]]
#
#   P^_mu = [[ -r/(2 sqrt(M) b),  +r/(2 sqrt(M) b) ],
#            [  1/(2 sqrt(M)),     1/(2 sqrt(M))   ]]
#           （r = |gamma_2(t~_mu)|, b = gamma_2(-t~_mu)）
#   (psi^dagger_mu, psi_mu) := (checkZ_mu, checkY_mu) P^_mu
#
#   X^ := sum_{mu in 𝓜̌} gamma(t~_mu) ( psi^dagger_mu psi_{M+1-mu} - (1/2) I )
#   V^' := exp(X^)
#
#   V_1^{(+)}         = exp(i K_1 H_1^{(+)})
#   (V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)})
#   V_2               = (2 s_2)^{M/2} exp(i K_2^* H_2)
#   V^{(+)}           = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
#   T_g(W)            = g W g^{-1}
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

TOL = 1e-8


def th_tilde(M, mu):
    """theta~_mu := 2 pi (mu - 1/2) / M"""
    return RDF(2 * pi * (RDF(mu) - RDF(1) / 2) / M)


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


def Yflat(O, l):
    """commutator_of_H_and_check_Z_Y の proof で導入した反周期的な延長 Y^flat_l"""
    if l == 0:
        return -O.Y[O.M]
    return O.Y[l]


def Zflat(O, l):
    """同じく Z^flat_l"""
    if l == O.M + 1:
        return -O.Z[1]
    return O.Z[l]


def coeffs(K1, K2):
    K1 = RDF(K1); K2 = RDF(K2); K2s = K_star(K2)
    return {'K1': K1, 'K2': K2, 'K2s': K2s,
            'c1': RDF(cosh(2 * K1)), 's1': RDF(sinh(2 * K1)),
            'c2': RDF(cosh(2 * K2)), 's2': RDF(sinh(2 * K2)),
            'c2s': RDF(cosh(2 * K2s)), 's2s': RDF(sinh(2 * K2s))}


def g1(t, P):
    return RDF(P['c1'] * P['c2s'] - P['s1'] * P['s2s'] * cos(RDF(t)))


def g2(t, P):
    t = RDF(t)
    return CDF(CDF(I) * eiph(t) * P['s2s'] *
               (P['c1'] * cos(t) - CDF(I) * sin(t) - P['s1'] * P['c2']))


def gamma_tilde(M, mu, P):
    """gamma(theta~_mu) = arccosh(gamma_1(theta~_mu))"""
    return RDF(arccosh(g1(th_tilde(M, mu), P)))


def A_theta(t, P):
    return matrix(CDF, [[g1(t, P), g2(t, P)], [-g2(-t, P), g1(t, P)]])


def B1(t, P):
    """def_B1_theta_B2 の B_1(theta)"""
    t = RDF(t)
    a = RDF(cosh(P['K1'])); b = RDF(sinh(P['K1']))
    return matrix(CDF, [[a, -CDF(I) * eiph(t) * b],
                        [CDF(I) * eiph(-t) * b, a]])


def B2(P):
    """def_B1_theta_B2 の B_2"""
    C = RDF(cosh(2 * P['K2s'])); S = RDF(sinh(2 * P['K2s']))
    return matrix(CDF, [[C, CDF(I) * S], [-CDF(I) * S, C]])


def Pcheck(M, mu, P):
    """diagonalization_check_P_D の P^_mu"""
    t = th_tilde(M, mu)
    r = RDF(abs(g2(t, P)))
    b = g2(-t, P)
    s = RDF(sqrt(RDF(M)))
    return matrix(CDF, [[-r / (2 * s * b), r / (2 * s * b)],
                        [CDF(1) / (2 * s), CDF(1) / (2 * s)]])


def psi_pair(O, mu, P):
    """(psi^dagger_mu, psi_mu) := (checkZ_mu, checkY_mu) P^_mu を返す。"""
    Zc = checkZ(O, mu); Yc = checkY(O, mu)
    Pm = Pcheck(O.M, mu, P)
    pdag = Pm[0, 0] * Zc + Pm[1, 0] * Yc
    psi = Pm[0, 1] * Zc + Pm[1, 1] * Yc
    return matrix(CDF, pdag), matrix(CDF, psi)


def V1p_half(O, K1):
    """(V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)}) とその逆行列"""
    A = CDF(I) / 2 * RDF(K1) * O.H1(+1)
    return matrix(CDF, A.exp()), matrix(CDF, (-A).exp())


def V2_mat(O, K2):
    """V_2 = (2 s_2)^{M/2} exp(i K_2^* H_2) とその逆行列（前因子を明示）"""
    K2s = K_star(K2)
    A = CDF(I) * RDF(K2s) * O.H2
    pref = CDF((2 * RDF(sinh(2 * RDF(K2)))) ** (RDF(O.M) / 2))
    return pref * matrix(CDF, A.exp()), (1 / pref) * matrix(CDF, (-A).exp())


def V_plus(O, K1, K2):
    """V^{(+)} とその逆行列"""
    Vh, Vhi = V1p_half(O, K1)
    V2, V2i = V2_mat(O, K2)
    return matrix(CDF, Vh * V2 * Vh), matrix(CDF, Vhi * V2i * Vhi)


def Vprime_check(O, P):
    """V^' = exp(X^)、X^ = sum_{mu in 𝓜̌} gamma(t~_mu)(psi^dagger_mu psi_{M+1-mu} - I/2)"""
    Id = identity_matrix(CDF, O.d)
    X = matrix(CDF, O.d, O.d, 0)
    for mu in range(1, O.M + 1):
        pdag, _ = psi_pair(O, mu, P)
        _, psi1m = psi_pair(O, O.M + 1 - mu, P)
        X = X + gamma_tilde(O.M, mu, P) * (pdag * psi1m - Id / 2)
    X = matrix(CDF, X)
    return matrix(CDF, X.exp()), matrix(CDF, (-X).exp()), X


def delta_M(M, x, y):
    """def_delta_M: delta^M_{(x,y)}"""
    return 1 if (x - y) % M == 0 else 0


def K2_critical(K1):
    """sinh(2K_1) sinh(2K_2) = 1 を満たす K_2（厳密な臨界点）"""
    K1 = RDF(K1)
    return RDF(arcsinh(1 / sinh(2 * K1))) / 2


# パラメータ集合（臨界点上・臨界点近傍・一般点・高温側を含む）
STEP_M = [2, 3, 4, 5]
STEP_PARAMS = [
    {'K1': RDF(0.4), 'K2': K2_critical(0.4)},                 # 厳密な臨界点（非等方）
    {'K1': RDF(0.4406867935097715),
     'K2': K2_critical(0.4406867935097715)},                  # 厳密な臨界点（等方 K1 = K2 = Kc）
    {'K1': RDF(0.44), 'K2': K2_critical(0.44) * (1 + 1e-6)},  # 臨界点近傍
    {'K1': RDF(0.4), 'K2': RDF(0.8)},                         # 一般点
    {'K1': RDF(1.2), 'K2': RDF(0.3)},                         # 一般点
    {'K1': RDF(0.05), 'K2': RDF(0.1)},                        # 高温極限付近
]


def param_label(p):
    K1 = RDF(p['K1']); K2 = RDF(p['K2'])
    return f"K1={float(K1):.8g}, K2={float(K2):.8g} (s1*s2={float(sinh(2*K1)*sinh(2*K2)):.8g})"


class Steps:
    """1 つの displayMath の各段（&= で区切られた各行）の残差を集計する。

    add(name, lhs, rhs) を段ごとに呼ぶ。名前には本文の `\\because` に書いた
    根拠（ラベル名など）を入れておき、どの段がどの定理に対応するかを追えるようにする。
    """

    def __init__(self):
        self.worst = {}

    def add(self, name, lhs, rhs):
        if hasattr(lhs, 'nrows'):
            res = opnorm(matrix(CDF, lhs) - matrix(CDF, rhs))
        elif hasattr(lhs, 'degree'):          # ベクトル
            res = RDF(max([abs(CDF(x)) for x in (vector(CDF, lhs) - vector(CDF, rhs))]))
        else:
            res = RDF(abs(CDF(lhs) - CDF(rhs)))
        self.worst[name] = max(self.worst.get(name, RDF(0)), res)

    def report_all(self, tol=None):
        ok = True
        for name in self.worst:
            ok &= report(name, self.worst[name], tol if tol is not None else TOL)
        return ok
