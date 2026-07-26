# ---------------------------------------------------------
# 共通: gamma(theta) と自由エネルギーの表式
#   structured-latex/content/012_free_energy.ts に対応
#   gamma(theta) = arccosh( cosh 2K1 cosh 2K2* - sinh 2K1 sinh 2K2* cos(theta) )
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../044_claim_max_eigenvalue/_prelude.sage'))


def gamma_fn(K1, K2):
    K1 = RDF(K1); K2 = RDF(K2); K2s = K_star(K2)
    c1 = RDF(cosh(2 * K1)); s1 = RDF(sinh(2 * K1))
    c2s = RDF(cosh(2 * K2s)); s2s = RDF(sinh(2 * K2s))
    def g(th):
        y = RDF(c1 * c2s - s1 * s2s * RDF(cos(RDF(th))))
        return RDF(arccosh(y))
    return g


def gamma1_lower(K1, K2):
    """cosh(2K1 - 2K2*)（gamma_1 の下限）"""
    K1 = RDF(K1); K2s = K_star(RDF(K2))
    return RDF(cosh(2 * K1 - 2 * K2s))


def theta_family(M, delta):
    return [RDF(2 * pi * (mu - RDF(delta)) / M) for mu in range(1, M + 1)]


def Lambda_delta(M, K1, K2, delta):
    """Lambda^{(delta)}_M = (2 sinh 2K2)^{M/2} exp( (1/2) sum gamma(theta) )"""
    g = gamma_fn(K1, K2)
    s2 = RDF(sinh(2 * RDF(K2)))
    tot = sum(g(th) for th in theta_family(M, delta))
    return RDF((2 * s2) ** (RDF(M) / 2) * exp(tot / 2))


def integral_of_gamma(K1, K2):
    g = gamma_fn(K1, K2)
    return RDF(numerical_integral(lambda t: float(g(RDF(t))), 0, 2 * float(pi))[0])


def onsager_rhs(K1, K2):
    s2 = RDF(sinh(2 * RDF(K2)))
    return RDF(log(2 * s2) / 2 + integral_of_gamma(K1, K2) / (4 * RDF(pi)))


FE_CASES = [
    (0.4, 0.8), (0.7, 0.3), (0.25, 1.1),
    (0.4407, 0.4407),   # 臨界点にほぼ一致（sinh 2K1 sinh 2K2 = 1）
]
