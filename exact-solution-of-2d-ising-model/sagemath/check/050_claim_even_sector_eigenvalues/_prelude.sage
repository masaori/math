# ---------------------------------------------------------
# 共通: 偶セクターの数演算子・同時固有空間分解・定数 c・V^{(+)} の固有値
#   structured-latex/content/017_even_sector_eigenvalues.ts に対応
#
#   （016 章までの道具は 049_claim_even_sector_fermions/_prelude.sage と同じものを
#     ここに再掲する。別ディレクトリの prelude を load すると __file__ の解決が
#     環境依存になるため、意図的に自己完結させている。）
#
#   theta~_mu   = 2 pi (mu - 1/2) / M
#   checkZ_mu   = sum_{j=1}^{M} Z_j e^{-i j theta~_mu}
#   checkY_mu   = sum_{j=1}^{M} Y_j e^{-i j theta~_mu}
#   gamma_1(t)  = c_1 c_2* - s_1 s_2* cos t
#   gamma_2(t)  = i e^{i t} s_2* (c_1 cos t - i sin t - s_1 c_2)
#   gamma(t~_mu)= arccosh(gamma_1(t~_mu))
#   (psi^dagger_mu, psi_mu) := (checkZ_mu, checkY_mu) P^_mu
#   X^ := sum_{mu=1}^{M} gamma(t~_mu) ( psi^dagger_mu psi_{1-mu} - (1/2) I )
#   V^' := exp(X^)
#   V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
#
#   本章で新しく入るもの:
#   n^_mu   := psi^dagger_mu psi_{1-mu}                     (def_check_number_operator)
#   Q^_eps  := prod_{mu=1}^{M} ( eps_mu n^_mu + (1-eps_mu)(I - n^_mu) )
#   S_1^{(+)} := i K_1 H_1^{(+)},  S_2 := i K_2^* H_2        (iH_is_real_symmetric)
#   U := E F,  E = prod_{m odd} sigma_m^x,  F = prod_m sigma_m^z   (sign_flip_conjugation)
#   Lambda^_eps := (2 sinh 2K_2)^{M/2} exp( sum_mu gamma(t~_mu)(eps_mu - 1/2) )
# ---------------------------------------------------------
import os
import itertools
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


def delta_M(M, x, y):
    """def_delta_M: delta^M_{(x,y)}"""
    return 1 if (x - y) % M == 0 else 0


# ---------------------------------------------------------
# 017 章で新しく入るもの
# ---------------------------------------------------------
def n_check(O, mu, P):
    """def_check_number_operator: n^_mu := psi^dagger_mu psi_{1-mu}"""
    pdag, _ = psi_pair(O, mu, P)
    _, psi1m = psi_pair(O, 1 - mu, P)
    return matrix(CDF, pdag * psi1m)


def n_check_all(O, P):
    """mu = 1..M の n^_mu をまとめて返す（1 始まりのリスト）。"""
    return [None] + [n_check(O, mu, P) for mu in range(1, O.M + 1)]


def X_check(O, P, ns=None):
    """def_check_Vprime の X^ = sum_{mu=1}^{M} gamma(t~_mu)(n^_mu - I/2)"""
    Id = identity_matrix(CDF, O.d)
    if ns is None:
        ns = n_check_all(O, P)
    X = matrix(CDF, O.d, O.d, 0)
    for mu in range(1, O.M + 1):
        X = X + gamma_tilde(O.M, mu, P) * (ns[mu] - Id / 2)
    return matrix(CDF, X)


def Vprime_check(O, P, ns=None):
    """V^' = exp(X^) とその逆行列、および X^"""
    X = X_check(O, P, ns)
    return matrix(CDF, X.exp()), matrix(CDF, (-X).exp()), X


def eps_list(M):
    """{0,1}^{1..M} を (eps_1, ..., eps_M) のタプルとして全列挙する。"""
    return list(itertools.product([0, 1], repeat=M))


def Q_check(O, eps, ns):
    """Q^_eps := prod_{mu=1}^{M} ( eps_mu n^_mu + (1-eps_mu)(I - n^_mu) )"""
    Id = identity_matrix(CDF, O.d)
    out = Id
    for mu in range(1, O.M + 1):
        e = eps[mu - 1]
        out = out * (ns[mu] if e == 1 else (Id - ns[mu]))
    return matrix(CDF, out)


def g_of_eps(O, eps, P):
    """g^(eps) := sum_{mu=1}^{M} gamma(t~_mu)(eps_mu - 1/2)"""
    return RDF(sum(gamma_tilde(O.M, mu, P) * (RDF(eps[mu - 1]) - RDF(1) / 2)
                   for mu in range(1, O.M + 1)))


def Lambda_check(O, eps, P):
    """Lambda^_eps := (2 s_2)^{M/2} exp(g^(eps))"""
    pref = RDF((2 * P['s2']) ** (RDF(O.M) / 2))
    return RDF(pref * exp(g_of_eps(O, eps, P)))


def Lambda_half_M(O, P):
    """onsager_free_energy_expression の Lambda^{(1/2)}_M（delta = 1/2）"""
    pref = RDF((2 * P['s2']) ** (RDF(O.M) / 2))
    s = RDF(sum(gamma_tilde(O.M, mu, P) for mu in range(1, O.M + 1)))
    return RDF(pref * exp(s / 2))


def S1_plus(O, K1):
    """S_1^{(+)} := i K_1 H_1^{(+)}（iH_is_real_symmetric）"""
    return matrix(CDF, CDF(I) * RDF(K1) * O.H1(+1))


def S2_op(O, K2):
    """S_2 := i K_2^* H_2"""
    return matrix(CDF, CDF(I) * K_star(K2) * O.H2)


def U_signflip(O):
    """sign_flip_conjugation の U := E F（E は奇数サイトの sigma^x の積、F は全サイトの sigma^z の積）"""
    E = identity_matrix(CDF, O.d)
    for m in range(1, O.M + 1, 2):
        E = E * O.SX[m]
    F = identity_matrix(CDF, O.d)
    for m in range(1, O.M + 1):
        F = F * O.SZ[m]
    return matrix(CDF, E * F)


def herm_residual(A):
    """A - A^* のノルム（エルミート性の残差）"""
    return opnorm(matrix(CDF, A) - matrix(CDF, A).conjugate_transpose())


def real_symmetric_residual(A):
    """成分が実かつ転置対称であることの残差（実対称性）"""
    A = matrix(CDF, A)
    im = max([abs(A[i, j].imag()) for i in range(A.nrows()) for j in range(A.ncols())])
    return max(RDF(im), opnorm(A - A.transpose()))


def K2_critical(K1):
    """sinh(2K_1) sinh(2K_2) = 1 を満たす K_2（厳密な臨界点）"""
    K1 = RDF(K1)
    return RDF(arcsinh(1 / sinh(2 * K1))) / 2


# パラメータ集合（臨界点上・臨界点近傍・一般点・高温側を含む）
EIG_M = [2, 3, 4, 5]
EIG_PARAMS = [
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
