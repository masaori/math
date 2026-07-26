# ---------------------------------------------------------
# 共通: 半整数運動量の添字集合 𝓜̌ = {1,...,M} とその性質
#   structured-latex/content/013_even_sector_modes.ts に対応
#     def_check_index_set          （𝓜̌ の定義と (1)〜(5)）
#     conjugate_index_of_check_Z_Y （θ~_{M+1-μ} = 2π - θ~_μ、Ž_{M+1-μ} = Ž_{1-μ}）
#
#   θ~_μ = 2π(μ - 1/2)/M,  Ž_μ = Σ_j Z_j e^{-i j θ~_μ},  Y̌_μ = Σ_j Y_j e^{-i j θ~_μ}
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

TOL = 1e-8


def th_tilde(M, mu):
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


def check_M(M):
    """def_check_index_set: 𝓜̌ = {1, 2, ..., M}"""
    return list(range(1, M + 1))


# 行列を使う検証は M = 2..5、純粋に添字だけの検証は M = 2..40 まで回す
MATRIX_M = [2, 3, 4, 5]
INDEX_M = list(range(2, 41))


def report(name, worst, tol):
    ok = worst <= tol
    print(f"  {name}: 最悪残差 {float(worst):.3e}  ->  {'PASS' if ok else 'FAIL'}")
    return ok
