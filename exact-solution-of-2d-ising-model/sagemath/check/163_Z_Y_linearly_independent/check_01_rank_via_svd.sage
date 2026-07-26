# ---------------------------------------------------------
# <Z_Y_linearly_independent>
#   （004_transfer_matrix.mjs / transfer_matrix_002_claim_Z_Y_linearly_independent）
#
# 主張: {Z_1,...,Z_M, Y_1,...,Y_M} は Mat(2,C)^{(x)M} の C-線型空間として線型独立。
#
# 独立経路: 各 Z_m, Y_m を 2^M x 2^M の行列として構成し、成分を並べて 4^M 次元の
#   複素ベクトルへ平坦化する。得られる 2M x 4^M 行列の**特異値**を計算し、
#   ランクが 2M であること（= 最小特異値が 0 から十分離れていること）で判定する。
#   本文の証明は Pauli 基底の係数比較による代数的議論であり、特異値による判定は独立。
#
# 判定基準:
#   Z_m, Y_m の成分はすべて絶対値 1 か 0 で、各行の 2-ノルムはちょうど sqrt(2^M)。
#   したがって最大特異値は高々 sqrt(2M) * sqrt(2^M) の程度。
#   ここでは「最小特異値 / 最大特異値 > 1e-8」を線型独立の判定条件とする
#   （倍精度の相対精度 ~1e-16 に対して 8 桁の余裕）。実測はもっとずっと大きい。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import numpy as np

rep = CheckReport("<Z_Y_linearly_independent>: Z, Y の線型独立性（特異値によるランク判定）")

RANK_TOL = 1e-8


def flatten_rows(mats):
    return np.array([m.reshape(-1) for m in mats], dtype=complex)


for M in [1, 2, 3, 4, 5, 6]:
    Zs = [Zop(m, M) for m in range(1, M + 1)]
    Ys = [Yop(m, M) for m in range(1, M + 1)]
    A = flatten_rows(Zs + Ys)
    sv = np.linalg.svd(A, compute_uv=False)
    smin, smax = float(sv[-1]), float(sv[0])
    ratio = smin / smax
    print("  M=%d: 行列サイズ %s, sigma_min=%.6e, sigma_max=%.6e, 比=%.6e"
          % (M, A.shape, smin, smax, ratio))
    rep.truth(A.shape == (2 * M, 4 ** M), "M=%d: 平坦化後の形が 2M x 4^M" % M)
    rep.truth(ratio > RANK_TOL,
              "M=%d: sigma_min/sigma_max = %.3e > %.0e（ランク = 2M = %d）"
              % (M, ratio, RANK_TOL, 2 * M))
    rep.truth(int(np.linalg.matrix_rank(A, tol=smax * RANK_TOL)) == 2 * M,
              "M=%d: 数値ランクがちょうど %d" % (M, 2 * M))

# --- 反例探し: この判定が「従属」をちゃんと検出できることを示す ---
# 従属なベクトルを 1 本足すと、ランクは 2M のまま増えず、最小特異値が 0 に落ちる。
for M in [2, 3, 4]:
    Zs = [Zop(m, M) for m in range(1, M + 1)]
    Ys = [Yop(m, M) for m in range(1, M + 1)]
    extra = Zs[0] + 2.0 * Ys[-1]      # 明らかに従属な元
    A = flatten_rows(Zs + Ys + [extra])
    sv = np.linalg.svd(A, compute_uv=False)
    smin, smax = float(sv[-1]), float(sv[0])
    print("  [対照] M=%d: 従属な元を 1 本追加 -> sigma_min/sigma_max=%.3e"
          % (M, smin / smax))
    rep.truth(smin / smax < 1e-12,
              "[対照] M=%d: 従属な元を足すと最小特異値が 0 に落ちる" % M)
    rep.truth(int(np.linalg.matrix_rank(A, tol=smax * RANK_TOL)) == 2 * M,
              "[対照] M=%d: ランクは 2M のまま増えない" % M)

# --- さらに: Z, Y の集合に I を足すと 2M+1 になる（= 判定は「増える」側も検出する）---
for M in [2, 3, 4]:
    Zs = [Zop(m, M) for m in range(1, M + 1)]
    Ys = [Yop(m, M) for m in range(1, M + 1)]
    A = flatten_rows(Zs + Ys + [eye_M(M)])
    sv = np.linalg.svd(A, compute_uv=False)
    rep.truth(int(np.linalg.matrix_rank(A, tol=float(sv[0]) * RANK_TOL)) == 2 * M + 1,
              "[対照] M=%d: I を足すとランクが %d に増える" % (M, 2 * M + 1))

rep.finish()
