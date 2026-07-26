# =============================================================
# 250/251/252 共通の補助関数
#
# 本文（structured-latex/content/001_partition_function_2d_ising.mjs）の
#   def_partition_function_2d_ising … Z(J,J') = Σ_s exp(Σ_{i,j}(J s(i,j)s(i+1,j) + J' s(i,j)s(i,j+1)))
#   def_transfer_matrix           … (V_1)_{μ,μ'} = δ_{μ=μ'} exp(Σ_j J' μ(j)μ(j+1))
#                                    (V_2)_{μ,μ'} = exp(Σ_j J μ(j)μ'(j))
# を、**定義の字面どおりに**（閉じた表示を一切使わずに）構成する。
#
# 周期境界条件: s(M+1,j)=s(1,j), s(i,N+1)=s(i,1), μ(N+1)=μ(1)。
#
# _shared/ は編集禁止のため、ここに置いている（250/251 からは相対パスで load する）。
# =============================================================

import itertools as _it
import numpy as _np


def spin_maps(n):
    """Map({1,…,n},{-1,1}) の全元をタプル（0-origin の添字）で列挙する。|・| = 2^n。"""
    return [tuple(t) for t in _it.product((-1, 1), repeat=int(n))]


def energy_of_config(s, M, N, J, Jp):
    """def_partition_function_2d_ising の指数の肩。s は M×N の 2 重リスト（0-origin）。

    s(i+1,j) は周期境界条件 s(M+1,j)=s(1,j)、s(i,j+1) は s(i,N+1)=s(i,1) で解釈する。
    """
    M = int(M); N = int(N)
    e = 0.0
    for i in range(M):
        for j in range(N):
            e += J * s[i][j] * s[(i + 1) % M][j]
            e += Jp * s[i][j] * s[i][(j + 1) % N]
    return e


def brute_force_Z(M, N, J, Jp):
    """Z(J,J') を 2^{MN} 通りの全スピン配位についてブルートフォースで足し上げる。"""
    M = int(M); N = int(N)
    tot = 0.0
    for flat in _it.product((-1, 1), repeat=M * N):
        s = [[flat[i * N + j] for j in range(N)] for i in range(M)]
        tot += float(_np.exp(energy_of_config(s, M, N, J, Jp)))
    return tot


def transfer_matrices(N, J, Jp, order=None):
    """def_transfer_matrix の V_1, V_2 を 2^N × 2^N 行列として素朴に構成する。

    order は「行・列の番号 {1,…,2^N} と 𝔐 の間の全単射」。省略時は spin_maps(N) の順。
    V_1 は行内（j 方向、周期 N）で J'、V_2 は行間で J を使う（本文の訂正後の割り当て）。
    """
    N = int(N)
    if order is None:
        order = spin_maps(N)
    n = len(order)
    V1 = _np.zeros((n, n), dtype=float)
    V2 = _np.zeros((n, n), dtype=float)
    for a, mu in enumerate(order):
        V1[a, a] = float(_np.exp(sum(Jp * mu[j] * mu[(j + 1) % N] for j in range(N))))
        for b, mup in enumerate(order):
            V2[a, b] = float(_np.exp(sum(J * mu[j] * mup[j] for j in range(N))))
    return V1, V2


def trace_transfer(M, N, J, Jp, order=None):
    """tr((V_1 V_2)^M)。"""
    V1, V2 = transfer_matrices(N, J, Jp, order=order)
    A = V1 @ V2
    P = _np.linalg.matrix_power(A, int(M))
    return float(_np.trace(P).real)


# 検証に使う (M, N) の組。M ≠ N を必ず含める（J と J' の入れ替わりを検出するため）。
MN_PAIRS = [(2, 2), (2, 3), (3, 2), (2, 4), (4, 2), (3, 3), (3, 4), (4, 3)]

# J ≠ J' を必ず含める。高温側・低温側・臨界点近傍（sinh2J sinh2J' = 1）を混ぜる。
JJ_PAIRS = [
    (0.3, 0.7),
    (0.7, 0.3),
    (0.1, 1.3),
    (0.4406868, 0.4406868),   # 等方的臨界点 sinh(2J)^2 = 1
    (0.2, 0.9414),            # 非等方的臨界点近傍（sinh2J sinh2J' ≈ 1）
    (1.1, 0.05),
]
