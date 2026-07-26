# ---------------------------------------------------------
# <tensor_anticommutation_from_single_site>
#   （006_Z_Y_anticommutation.mjs / Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site）
#
# 主張: x_1..x_M, y_1..y_M in Mat(2,C) が
#         「ある j で y_j x_j = -(x_j y_j)、他のすべての i で y_i x_i = x_i y_i」
#       を満たすなら、X = x_1 (x) ... (x) x_M, Y = y_1 (x) ... (x) y_M について [X,Y]_+ = 0。
#
# 独立経路: Pauli 行列に依存しない**ランダムな 2x2 行列**で仮定を満たす組を作り、
#   クロネッカー積を実際に組み立てて XY + YX を数値的に評価する。
#   本文の証明はテンソル積代数の積の定義と多重線型性だけを使う代数的議論であり、
#   ここでの 2^M x 2^M の行列積による評価はそれとは独立な計算経路である。
#
# 仮定の作り方の妥当性（反可換な組を作れていること）も同じスクリプト内で検査する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

import numpy as np

rep = CheckReport("<tensor_anticommutation_from_single_site>: 1 サイト反可換 => テンソル積は反交換")

rng = np.random.RandomState(20260726)

# --- Step 0: 仮定を満たす組が本当に作れているかを検査する ---
for t in range(20):
    A, B = rand_anticommuting_pair(rng)
    rep.close(acomm(A, B), np.zeros((2, 2), dtype=complex),
              "Step0 反可換な組 #%d: [A,B]_+ = 0" % t)
    rep.truth(float(np.max(np.abs(comm(A, B)))) > 1e-6,
              "Step0 反可換な組 #%d: [A,B] != 0（自明な組ではない）" % t)
for t in range(20):
    A, B = rand_commuting_pair(rng)
    rep.close(comm(A, B), np.zeros((2, 2), dtype=complex),
              "Step0 可換な組 #%d: [A,B] = 0" % t)

# --- Step 1: 主張本体 ---
for M in [1, 2, 3, 4, 5]:
    for j in range(1, M + 1):
        for t in range(5):
            xs, ys = [], []
            for i in range(1, M + 1):
                if i == j:
                    a, b = rand_anticommuting_pair(rng)
                else:
                    a, b = rand_commuting_pair(rng)
                xs.append(a)
                ys.append(b)
            X = kron_list(xs)
            Y = kron_list(ys)
            rep.close(acomm(X, Y), np.zeros((2 ** M, 2 ** M), dtype=complex),
                      "M=%d j=%d #%d: [X,Y]_+ = 0" % (M, j, t))
            # 自明でないこと（X も Y も 0 でなく、XY も 0 でない）
            rep.truth(float(np.max(np.abs(X @ Y))) > 1e-8,
                      "M=%d j=%d #%d: XY != 0（自明に 0 ではない）" % (M, j, t))

rep.finish()
