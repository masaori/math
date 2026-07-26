# =============================================================
# check 220〜234（A(θ) の性質・固有値・γ の零点・臨界条件）の共通補助定義。
#
# `_shared/` は他エージェントと共有していて編集できないため、必要な補助はここに置く。
# 同じ内容を各 check ディレクトリへ複製している（load のパスを自分のディレクトリ内に閉じるため）。
#
# 使い方（check 本体側）:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '../../_shared/operators.sage'))
#   load(os.path.join(_dir, '_prelude.sage'))
# =============================================================

import numpy as np

# hatZ^{(-)}_mu / H_1^{(-)} / V_1^{(-)} の側を使う（T_V_hatZ_hatY の主張と同じ符号）。
SIGN = '-'


# ---------------------------------------------------------
# 臨界点を厳密に踏むパラメータ
#   s_1 s_2 = 1  <=>  sinh(2K_1) = 1/sinh(2K_2)  <=>  K_1 = arcsinh(1/sinh 2K_2)/2
# OP_TEST_PARAMS の {'K1': 0.4407, 'K2': 0.4407} は近似値なので、ここで厳密に乗せた点を作る。
# ---------------------------------------------------------
def crit_K1_of(K2):
    return 0.5 * np.arcsinh(1.0 / np.sinh(2.0 * K2))


CRIT_K2_LIST = [0.25, 0.4406867935097714, 0.6, 1.0]


def param_sets():
    """(K1, K2, タグ) の列。臨界点上・臨界点近傍を必ず含む。"""
    out = []
    for p in OP_TEST_PARAMS:
        out.append((p['K1'], p['K2'], 'generic'))
    for K2 in CRIT_K2_LIST:
        out.append((crit_K1_of(K2), K2, 'critical'))
    for K2 in [0.5, 0.9]:
        Kc = crit_K1_of(K2)
        out.append((Kc * (1 + 1e-6), K2, 'near-critical(+)'))
        out.append((Kc * (1 - 1e-6), K2, 'near-critical(-)'))
    return out


def critical_param_sets():
    return [(crit_K1_of(K2), K2, 'critical') for K2 in CRIT_K2_LIST]


def mu_range(M):
    """\\mathcal{M} := {-M, ..., -1, 1, ..., M}。"""
    return [m for m in range(-M, M + 1) if m != 0]


# ---------------------------------------------------------
# 独立経路: 作用素レベルから A(theta_mu) を取り出す
#
#   T_{(V)}(X) = T_{W}(T_{V_2}(T_{W}(X))),   W := (V_1^{(-)})^{1/2}
#              = (W V_2 W) X (W V_2 W)^{-1}
#   (T_V(hatZ_mu), T_V(hatY_mu)) = (hatZ_mu, hatY_mu) A(theta_mu)   <T_V_hatZ_hatY>
#
# より A の各列を 2^M × 2^M 行列の最小二乗展開で読み取る。
# gamma_1, gamma_2 の閉じた式も B_1, B_2 も一切使わないので、A(theta) の
# 成分表示（<def_A_theta>）とは独立な経路になる。
# ---------------------------------------------------------
def V_eff_op(K1, K2, M, sign=SIGN):
    W = np.asarray(principal_sqrt_of_V1pm(K1, M, sign), dtype=complex)
    # V2_op のスカラー係数 (2 sinh 2K_2)^{M/2} は M が奇数のとき SageMath の
    # 有理数冪になり配列が object dtype になるので、complex へ落としておく。
    # （この係数は共役 T_{V} では打ち消えるので値には影響しない。）
    V2 = np.asarray(V2_op(K2, M), dtype=complex)
    return W @ V2 @ W


def A_from_operators(mu, M, K1, K2, sign=SIGN):
    """(A, 展開の相対残差) を返す。残差が 0 でないなら hatZ, hatY で張れていない。"""
    Veff = V_eff_op(K1, K2, M, sign)
    hZ = np.asarray(hatZ_op(mu, M, sign), dtype=complex)
    hY = np.asarray(hatY_op(mu, M), dtype=complex)
    B = np.stack([hZ.reshape(-1), hY.reshape(-1)], axis=1)
    A = np.zeros((2, 2), dtype=complex)
    resid = 0.0
    for k, X in enumerate([hZ, hY]):
        rhs = T_conj(Veff, X).reshape(-1)
        coef, _r, _rank, _sv = np.linalg.lstsq(B, rhs, rcond=None)
        A[0, k] = coef[0]
        A[1, k] = coef[1]
        scale = max(1.0, float(np.max(np.abs(rhs))))
        resid = max(resid, float(np.max(np.abs(B @ coef - rhs))) / scale)
    return A, resid


# ---------------------------------------------------------
# 角度の [0, 2pi) への還元（s_{[0,2pi)} に相当）
# ---------------------------------------------------------
def reduce02pi(x):
    return float(np.mod(float(x), 2.0 * np.pi))


def angle_close(a, b, tol):
    """[0,2pi) 上の角度としての一致（0 と 2pi を同一視する）。"""
    d = abs(reduce02pi(a - b))
    return min(d, 2.0 * np.pi - d) <= tol
