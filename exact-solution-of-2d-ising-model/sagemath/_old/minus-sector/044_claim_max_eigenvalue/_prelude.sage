# ---------------------------------------------------------
# 共通: 対称化転送行列 W = V_1^{1/2} V_2 V_1^{1/2}
#   structured-latex/content/011_max_eigenvalue.ts に対応
#   V_1 = exp(K_1 D), D = sum_m sigma^z_m sigma^z_{m+1}
#   V_1^{1/2} = exp(K_1 D / 2)
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../043_claim_transfer_matrix_bridge/_prelude.sage'))


def D_bonds(O):
    """D = sum_{m=1}^{M} sigma^z_m sigma^z_{m+1}（sigma^z_{M+1} = sigma^z_1）"""
    out = matrix(CDF, O.d, O.d, 0)
    for m in range(1, O.M + 1):
        mp = m + 1 if m < O.M else 1
        out = out + O.SZ[m] * O.SZ[mp]
    return out


def V1_half(O, K1):
    return matrix(CDF, (RDF(K1) / 2 * D_bonds(O)).exp())


def W_matrix(O, K1, K2):
    return V1_half(O, K1) * V2_pauli(O, K2) * V1_half(O, K1)


def to_real(A):
    d = A.nrows()
    return matrix(RDF, [[A[i, j].real() for j in range(d)] for i in range(d)])


def rayleigh_sup(A_real):
    """実対称行列の Rayleigh 商の上限（= 最大固有値）。数値的に固有値で評価する。"""
    return max([RDF(CDF(z).real()) for z in A_real.eigenvalues()])


MAXEIG_CASES = [
    (2, 0.4, 0.8), (2, 0.7, 0.3),
    (3, 0.4, 0.8), (3, 0.7, 0.3), (3, 0.25, 1.1),
    (4, 0.4, 0.8), (4, 0.7, 0.3),
]
