# ---------------------------------------------------------
# 共通: 半整数運動量モード checkZ, checkY
#   structured-latex/content/013_even_sector_modes.ts に対応
#   theta~_mu = 2 pi (mu - 1/2) / M
#   checkZ_mu = sum_j Z_j e^{-i j theta~_mu},  checkY_mu = sum_j Y_j e^{-i j theta~_mu}
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))


def th_tilde(M, mu):
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


EVEN_CASES_M = [2, 3, 4, 5]
TOL = 1e-8
