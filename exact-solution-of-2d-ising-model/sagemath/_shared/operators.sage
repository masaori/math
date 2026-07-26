# =============================================================
# 共通定義ファイル (sagemath/_shared/operators.sage)
#
# Mat(2,C)^{⊗M} の元を「具体的な 2^M × 2^M の複素行列（クロネッカー積）」として構成する。
# structured-latex 側のラベル <def_transfer_matrix_symbols>, <def_hatZ_hatY>,
# <transfer_matrix_011_definition_H1_H2>, <def_A_theta>, <def_fermi> などに対応する。
#
# 既存の `_shared/defs.sage` は「symbolic な γ_1, γ_2, A(θ) の式」を提供するもので、
# こちらは「作用素を明示的な行列として作る」ためのもの。役割が違うので両方 load してよい。
#
# 使い方:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '../../_shared/operators.sage'))
#
# 数値は numpy の complex128 で扱う（行列指数は scipy.linalg.expm）。
# SageMath の記号計算を使わないのは、2^M × 2^M の行列指数を扱う必要があるため。
# =============================================================

import numpy as _np
from scipy.linalg import expm as _expm

# ---------------------------------------------------------
# Pauli 行列（<pauli_matrix_products>）
# ---------------------------------------------------------
I2 = _np.eye(2, dtype=complex)
SX = _np.array([[0, 1], [1, 0]], dtype=complex)
SY = _np.array([[0, -1j], [1j, 0]], dtype=complex)
SZ = _np.array([[1, 0], [0, -1]], dtype=complex)
PAULI = {'0': I2, 'x': SX, 'y': SY, 'z': SZ}


def kron_list(mats):
    """行列のリストのクロネッカー積。先頭がサイト 1（最も外側の因子）。"""
    out = _np.array([[1.0 + 0.0j]])
    for m in mats:
        out = _np.kron(out, m)
    return out


def eye_M(M):
    """I_{(Mat(2,C))^{⊗M}}（2^M 次の単位行列）。"""
    return _np.eye(2 ** M, dtype=complex)


def site_op(a, k, M):
    """sigma^a_k := I ⊗ … ⊗ (a を第 k 因子に) ⊗ … ⊗ I。k は 1..M。"""
    if not (1 <= k <= M):
        raise ValueError("site index k must be in 1..M, got %r" % (k,))
    return kron_list([PAULI[a] if j == k else I2 for j in range(1, M + 1)])


def sx(k, M):
    return site_op('x', k, M)


def sy(k, M):
    return site_op('y', k, M)


def sz(k, M):
    return site_op('z', k, M)


# ---------------------------------------------------------
# Jordan--Wigner 文字列（<def_transfer_matrix_symbols>）
#   Z_m := sigma^x_1 … sigma^x_{m-1} sigma^z_m   （Z_1 = sigma^z_1）
#   Y_m := sigma^x_1 … sigma^x_{m-1} sigma^y_m   （Y_1 = sigma^y_1）
#   添字は M 周期に延長する（Z_{M+1} = Z_1）。
# ---------------------------------------------------------
def _wrap(m, M):
    """m を {1,…,M} の代表元へ（M 周期）。"""
    return ((m - 1) % M) + 1


def Zop(m, M):
    m = _wrap(m, M)
    return kron_list(
        [SX if j < m else (SZ if j == m else I2) for j in range(1, M + 1)]
    )


def Yop(m, M):
    m = _wrap(m, M)
    return kron_list(
        [SX if j < m else (SY if j == m else I2) for j in range(1, M + 1)]
    )


def eps_op(M):
    """epsilon := sigma^x_1 … sigma^x_M。"""
    return kron_list([SX] * M)


# ---------------------------------------------------------
# 結合定数（<def_transfer_matrix_symbols>）
#   K^* := -1/2 log(tanh K)   ⟺  sinh(2K) sinh(2K^*) = 1
# ---------------------------------------------------------
def K_star(K):
    return -0.5 * _np.log(_np.tanh(K))


def c_of(K):
    return _np.cosh(2 * K)


def s_of(K):
    return _np.sinh(2 * K)


# ---------------------------------------------------------
# 転送行列（<def_transfer_matrix_symbols>）
#   V_1 := exp(K_1 sum_{m=1}^{M} sigma^z_m sigma^z_{m+1})   （sigma^z_{M+1} = sigma^z_1）
#   V_2 := (2 sinh 2K_2)^{M/2} exp(K_2^* sum_{m=1}^{M} sigma^x_m)
# ---------------------------------------------------------
def V1_op(K1, M):
    H = sum(sz(m, M) @ sz(_wrap(m + 1, M), M) for m in range(1, M + 1))
    return _expm(K1 * H)


def V2_op(K2, M):
    K2s = K_star(K2)
    H = sum(sx(m, M) for m in range(1, M + 1))
    return (2 * _np.sinh(2 * K2)) ** (M / 2) * _expm(K2s * H)


# ---------------------------------------------------------
# H_1^{(±)}, H_2（transfer_matrix_011_definition_H1_H2）
#   H_1^{(±)} := Y_1 Z_2 + … + Y_{M-1} Z_M ∓ Y_M Z_1
#   H_2       := Z_1 Y_1 + … + Z_M Y_M
#   sign は '+' / '-' の文字列。複号 ∓ は sign='+' で -1、sign='-' で +1。
# ---------------------------------------------------------
def _mp_sign(sign):
    """複号 ∓ の値（上が '+'）。"""
    if sign == '+':
        return -1.0
    if sign == '-':
        return +1.0
    raise ValueError("sign must be '+' or '-', got %r" % (sign,))


def H1_op(M, sign):
    H = sum(Yop(m, M) @ Zop(m + 1, M) for m in range(1, M))
    return H + _mp_sign(sign) * (Yop(M, M) @ Zop(1, M))


def H2_op(M):
    return sum(Zop(m, M) @ Yop(m, M) for m in range(1, M + 1))


def V1pm_op(K1, M, sign):
    """V_1^{(±)} := exp(i K_1 H_1^{(±)})（<def_V1_pm>）。"""
    return _expm(1j * K1 * H1_op(M, sign))


# ---------------------------------------------------------
# 離散 Fourier 変換（<def_hatZ_hatY>）
#   hatZ^{(±)}_mu := sum_{j=1}^{M} w_j Z_j exp(-i 2 pi j mu / M),  w_1 = ∓1, w_{j≠1} = 1
#   hatY_mu       := sum_{j=1}^{M} Y_j exp(-i 2 pi j mu / M)
# ---------------------------------------------------------
def hatZ_op(mu, M, sign):
    w1 = _mp_sign(sign)
    out = _np.zeros((2 ** M, 2 ** M), dtype=complex)
    for j in range(1, M + 1):
        w = w1 if j == 1 else 1.0
        out = out + w * Zop(j, M) * _np.exp(-1j * 2 * _np.pi * j * mu / M)
    return out


def hatY_op(mu, M):
    out = _np.zeros((2 ** M, 2 ** M), dtype=complex)
    for j in range(1, M + 1):
        out = out + Yop(j, M) * _np.exp(-1j * 2 * _np.pi * j * mu / M)
    return out


def theta_mu_of(mu, M):
    """theta_mu := 2 pi mu / M（<def_theta_mu>）。"""
    return 2 * _np.pi * mu / M


# ---------------------------------------------------------
# 交換子・反交換子・共役（<commutator_via_anticommutators>, <def_T_g>）
# ---------------------------------------------------------
def comm(a, b):
    return a @ b - b @ a


def acomm(a, b):
    return a @ b + b @ a


def T_conj(g, h):
    """T_g(h) := g h g^{-1}。"""
    return g @ h @ _np.linalg.inv(g)


def ad_pow(X, Y, n):
    """n 重交換子 ad_X^n(Y)（n=0 のとき Y）。"""
    out = Y
    for _ in range(n):
        out = comm(X, out)
    return out


def sqrtm_series(A, terms=None):
    """使わない（誤用防止のため未実装）。行列の平方根が要る場合は個別に構成すること。"""
    raise NotImplementedError


def principal_sqrt_of_V1pm(K1, M, sign):
    """(V_1^{(±)})^{1/2} := exp(i (K_1/2) H_1^{(±)})。

    本文で (V_1^{(±)})^{1/2} と書かれているものは、指数の肩を半分にしたものを指す
    （<def_T_V> の周辺で T_{(V_1^{(±)})^{1/2}} として使われる）。
    """
    return _expm(1j * (K1 / 2.0) * H1_op(M, sign))


# ---------------------------------------------------------
# gamma_1, gamma_2, A(theta), B_1, B_2（<def_A_theta>, <factorization_of_A_theta>）
#   gamma_1(theta) := c_1 c_2^* - s_1 s_2^* cos(theta)
#   gamma_2(theta) := i e^{i theta} s_2^* (c_1 cos theta - i sin theta - s_1 c_2)
# ---------------------------------------------------------
def gamma1_of(th, K1, K2):
    K2s = K_star(K2)
    return c_of(K1) * c_of(K2s) - s_of(K1) * s_of(K2s) * _np.cos(th)


def gamma2_of(th, K1, K2):
    K2s = K_star(K2)
    return (
        1j
        * _np.exp(1j * th)
        * s_of(K2s)
        * (c_of(K1) * _np.cos(th) - 1j * _np.sin(th) - s_of(K1) * c_of(K2))
    )


def A_of(th, K1, K2):
    return _np.array(
        [
            [gamma1_of(th, K1, K2), gamma2_of(th, K1, K2)],
            [-gamma2_of(-th, K1, K2), gamma1_of(th, K1, K2)],
        ],
        dtype=complex,
    )


def B1_of(th, K1):
    return _np.array(
        [
            [_np.cosh(K1), -1j * _np.exp(1j * th) * _np.sinh(K1)],
            [1j * _np.exp(-1j * th) * _np.sinh(K1), _np.cosh(K1)],
        ],
        dtype=complex,
    )


def B2_of(K2):
    K2s = K_star(K2)
    return _np.array(
        [
            [_np.cosh(2 * K2s), 1j * _np.sinh(2 * K2s)],
            [-1j * _np.sinh(2 * K2s), _np.cosh(2 * K2s)],
        ],
        dtype=complex,
    )


# ---------------------------------------------------------
# 本プロジェクト定義の複素数の平方根と偏角（<def_sqrt_cc>, <def_abs_arg>）
#   arg^{[0,2pi)} を取り、半分にする分枝。
# ---------------------------------------------------------
def arg02pi(z):
    a = _np.angle(complex(z))
    if a < 0:
        a += 2 * _np.pi
    return a


def sqrt_cc_np(z):
    z = complex(z)
    if z == 0:
        return complex(0)
    r = abs(z)
    a = arg02pi(z)
    return _np.sqrt(r) * _np.exp(1j * a / 2)


# ---------------------------------------------------------
# フェルミオン（<def_fermi>, <diagonalization_P_D>）
#   psi^dagger_mu = (+i sqrt(g2(th) g2(-th)) / (2 sqrt(M) g2(-th))) hatZ^{(-)}_mu + (1/(2 sqrt M)) hatY_mu
#   psi_mu        = (-i sqrt(g2(th) g2(-th)) / (2 sqrt(M) g2(-th))) hatZ^{(-)}_mu + (1/(2 sqrt M)) hatY_mu
# ---------------------------------------------------------
def P_mu_of(mu, M, K1, K2):
    th = theta_mu_of(mu, M)
    g2p = gamma2_of(th, K1, K2)
    g2m = gamma2_of(-th, K1, K2)
    r = sqrt_cc_np(g2p * g2m)
    d = 2 * _np.sqrt(M) * g2m
    return _np.array([[1j * r / d, -1j * r / d],
                      [1 / (2 * _np.sqrt(M)), 1 / (2 * _np.sqrt(M))]], dtype=complex)


def psi_ops(mu, M, K1, K2):
    """(psi^dagger_mu, psi_mu) を返す。"""
    P = P_mu_of(mu, M, K1, K2)
    hZ = hatZ_op(mu, M, '-')
    hY = hatY_op(mu, M)
    psi_dag = P[0, 0] * hZ + P[1, 0] * hY
    psi = P[0, 1] * hZ + P[1, 1] * hY
    return psi_dag, psi


def lambda_pm_of(mu, M, K1, K2):
    """lambda_± := gamma_1 ± sqrt(-gamma_2(theta) gamma_2(-theta))（<eigenvector_of_A_theta>）。

    平方根の中身は、<relation_of_gamma_2>（gamma_2(-theta) = -conj(gamma_2(theta))）により
    **厳密には非負実数** -gamma_2(theta)gamma_2(-theta) = |gamma_2(theta)|^2 である
    （この事実自体は check 227 で独立に数値検証している）。
    ところが倍精度で計算すると虚部に ~1e-17 の丸めが乗り、それが負側に出ると
    arg^{[0,2pi)} が 0 ではなく ~2pi を返すため、本プロジェクト定義の sqrt
    （偏角を半分にする分枝）が符号を反転させてしまう。これは主張の誤りではなく
    純粋な浮動小数点の分枝跨ぎなので、虚部が実部に対して無視できるときは実軸へ落とす。
    """
    th = theta_mu_of(mu, M)
    g1 = gamma1_of(th, K1, K2)
    prod = -gamma2_of(th, K1, K2) * gamma2_of(-th, K1, K2)
    if abs(prod.imag) <= 1e-10 * max(1.0, abs(prod.real)) and prod.real >= 0:
        prod = complex(prod.real, 0.0)
    r = sqrt_cc_np(prod)
    return g1 + r, g1 - r


# ---------------------------------------------------------
# delta^M（<def_delta_M>）
# ---------------------------------------------------------
def delta_M(a, b, M):
    return 1.0 if ((a - b) % M == 0) else 0.0


# ---------------------------------------------------------
# テスト用パラメータ
# ---------------------------------------------------------
OP_TEST_PARAMS = [
    {'K1': 0.4, 'K2': 0.8},
    {'K1': 1.2, 'K2': 0.3},
    {'K1': 0.4407, 'K2': 0.4407},   # 臨界点近傍（等方的）
    {'K1': 0.2, 'K2': 0.813},       # 臨界点近傍（非等方的）
    {'K1': 0.05, 'K2': 0.1},        # 高温側
    {'K1': 0.3, 'K2': 1.7},         # 非対称
]

OP_TEST_M = [2, 3, 4, 5]
OP_TOL = 1e-9


# ---------------------------------------------------------
# 結果レポート
# ---------------------------------------------------------
class CheckReport(object):
    """個々の check スクリプトの合否をまとめる。

    使い方:
        rep = CheckReport("何を検証しているか")
        rep.close(lhs, rhs, "ラベル")      # 行列/スカラーの一致
        rep.truth(bool_value, "ラベル")    # 真偽値の確認
        rep.finish()                       # PASS/FAIL を出力し、FAIL なら exit 1
    """

    def __init__(self, title, tol=None):
        self.title = title
        self.tol = OP_TOL if tol is None else tol
        self.n = 0
        self.failures = []
        self.max_err = 0.0
        print("=== %s ===" % title)

    def _err(self, lhs, rhs):
        a = _np.asarray(lhs, dtype=complex)
        b = _np.asarray(rhs, dtype=complex)
        if a.shape != b.shape:
            return float('inf')
        denom = max(1.0, float(_np.max(_np.abs(a))), float(_np.max(_np.abs(b))))
        return float(_np.max(_np.abs(a - b))) / denom

    def close(self, lhs, rhs, label):
        """相対誤差（成分の最大絶対値で正規化）で比較する。"""
        self.n += 1
        e = self._err(lhs, rhs)
        self.max_err = max(self.max_err, e)
        if not (e <= self.tol):
            self.failures.append("%s: rel.err=%.3e" % (label, e))
            print("  MISMATCH %s: rel.err=%.3e" % (label, e))
        return e <= self.tol

    def truth(self, value, label):
        self.n += 1
        if not value:
            self.failures.append("%s: assertion false" % label)
            print("  FAIL %s" % label)
        return bool(value)

    def finish(self):
        print("checks: %d, max relative error: %.3e, tol: %.1e"
              % (self.n, self.max_err, self.tol))
        if self.failures:
            print("RESULT: FAIL (%d)" % len(self.failures))
            for f in self.failures:
                print("  - %s" % f)
            import sys
            sys.exit(1)
        print("RESULT: PASS")
        return True
