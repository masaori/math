# ---------------------------------------------------------
# 共通: V, V', フェルミオン数演算子 n_mu の構成
#   structured-latex/content/009_eigenvalues_of_V.mjs に対応
#
#   S_1^{(pm)} := i K_1 H_1^{(pm)},   S_2 := i K_2^* H_2
#   V  := exp(S_1/2) * V_2 * exp(S_1/2),  V_2 = (2 s_2)^{M/2} exp(S_2)
#   psi_mu^dagger, psi_mu : def_fermi
#   n_mu := psi_mu^dagger psi_{-mu}
#   V' := exp( sum_{mu in I} gamma(theta_mu) (n_mu - 1/2) )
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))


def arg_02pi_cdf(z):
    """arg^([0,2pi)) （本プロジェクト定義）"""
    a = CDF(z).argument()
    if a < 0:
        a += 2 * RDF(pi)
    return a


def sqrt_cc_cdf(z):
    """本プロジェクト定義の sqrt（偏角を [0,2pi) で取り半分にする）"""
    z = CDF(z)
    if z == 0:
        return CDF(0)
    return CDF(abs(z).sqrt() * exp(CDF(I) * arg_02pi_cdf(z) / 2))


class TransferSetup:
    """与えられた M, K1, K2 に対して V, V', n_mu 等を構成する。"""

    def __init__(self, M, K1v, K2v, sgn=-1):
        self.O = SpinOps(M)
        self.M = M
        self.d = self.O.d
        self.sgn = sgn                      # H_1^{(pm)} の符号（+1 が (+)、-1 が (-)）
        self.K1 = RDF(K1v)
        self.K2 = RDF(K2v)
        self.K2s = K_star(self.K2)
        self.c1 = RDF(cosh(2 * self.K1))
        self.s1 = RDF(sinh(2 * self.K1))
        self.c2 = RDF(cosh(2 * self.K2))
        self.s2 = RDF(sinh(2 * self.K2))
        self.c2s = RDF(cosh(2 * self.K2s))
        self.s2s = RDF(sinh(2 * self.K2s))
        # S_1, S_2
        self.S1 = CDF(I) * self.K1 * self.O.H1(sgn)
        self.S2 = CDF(I) * self.K2s * self.O.H2
        self.prefactor = CDF((2 * self.s2) ** (RDF(M) / 2))   # (2 s_2)^{M/2}

    # --- gamma_1, gamma_2 (def_A_theta) ---
    def gamma2(self, th):
        th = CDF(th)
        return (CDF(I) * CDF(exp(CDF(I) * th)) * self.s2s
                * (self.c1 * CDF(cos(th)) - CDF(I) * CDF(sin(th)) - self.s1 * self.c2))

    def gamma1(self, th):
        return RDF(self.c1 * self.c2s - self.s1 * self.s2s * RDF(cos(RDF(th))))

    def gamma(self, mu):
        """gamma(theta_mu) := arccosh(gamma_1(theta_mu))"""
        return RDF(arccosh(self.gamma1(self.O.theta(mu))))

    def index_set(self):
        """I := { mu in {1..M} | gamma_2(theta_mu) != 0 }"""
        out = []
        for mu in range(1, self.M + 1):
            if abs(self.gamma2(self.O.theta(mu))) > 1e-10:
                out.append(mu)
        return out

    # --- フェルミオン (def_fermi) ---
    def psi_pair(self, mu):
        """(psi_mu^dagger, psi_mu) を返す。gamma_2(theta_mu) = 0 なら (None, None)。"""
        th = self.O.theta(mu)
        a = self.gamma2(th)
        b = self.gamma2(-th)
        if abs(a) < 1e-10 or abs(b) < 1e-10:
            return (None, None)
        Zm = self.O.Zhat(mu, -1)
        Yh = self.O.Yhat(mu)
        rt = sqrt_cc_cdf(a * b)
        norm = 2 * RDF(self.M).sqrt()
        dag = (CDF(I) * rt / (norm * b)) * Zm + (1 / norm) * Yh
        ann = (-CDF(I) * rt / (norm * b)) * Zm + (1 / norm) * Yh
        return (dag, ann)

    def number_operators(self):
        """{ mu: n_mu } （mu in I）"""
        out = {}
        for mu in self.index_set():
            dag, _ = self.psi_pair(mu)
            _, ann = self.psi_pair(-mu)
            if dag is None or ann is None:
                continue
            out[mu] = dag * ann
        return out

    # --- V, V' ---
    def V(self):
        half = matrix(CDF, (self.S1 / 2).exp())
        E2 = matrix(CDF, self.S2.exp())
        return half * (self.prefactor * E2) * half

    def X(self):
        """X := sum_{mu in I} gamma(theta_mu) (n_mu - I/2)"""
        out = matrix(CDF, self.d, self.d, 0)
        Id = identity_matrix(CDF, self.d)
        for mu, n in self.number_operators().items():
            out = out + RDF(self.gamma(mu)) * (n - (1 / RDF(2)) * Id)
        return out

    def Vprime(self):
        return matrix(CDF, self.X().exp())

    def U_signflip(self):
        """U := (prod_{m odd} sigma^x_m)(prod_m sigma^z_m)"""
        out = identity_matrix(CDF, self.d)
        for m in range(1, self.M + 1):
            if m % 2 == 1:
                out = out * self.O.SX[m]
        for m in range(1, self.M + 1):
            out = out * self.O.SZ[m]
        return matrix(CDF, out)


TEST_CASES = [
    (2, 0.4, 0.8), (2, 1.2, 0.3),
    (3, 0.4, 0.8), (3, 1.2, 0.3), (3, 0.3, 0.9),
    (4, 0.4, 0.8), (4, 1.2, 0.3), (4, 0.3, 0.9),
    (5, 0.4, 0.8), (5, 0.3, 0.9),
]

TOL = 1e-8
