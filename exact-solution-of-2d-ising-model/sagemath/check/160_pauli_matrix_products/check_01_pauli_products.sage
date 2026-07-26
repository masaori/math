# ---------------------------------------------------------
# <pauli_matrix_products>（006_Z_Y_anticommutation.mjs / Z_Y_anticommutation_000a_claim_pauli_matrix_products）
#
# 主張:
#   sigma^x sigma^x = sigma^y sigma^y = sigma^z sigma^z = I
#   sigma^z sigma^x = - sigma^x sigma^z
#   sigma^y sigma^x = - sigma^x sigma^y
#   sigma^y sigma^z = - sigma^z sigma^y
#
# 独立経路:
#   (a) この check の中で literal な成分から Pauli 行列を作り直し、共有ライブラリ
#       operators.sage の PAULI と一致することを確かめる（ライブラリ側の写し間違い検出）。
#   (b) 16 通りの積 sigma^a sigma^b を、閉じた公式
#           sigma^a sigma^b = delta_{ab} I + i sum_c eps_{abc} sigma^c
#       と突き合わせる。この公式は本文の 6 式より強い（本文の 6 式は公式の系）。
#       成分計算（本文の経路）と Levi-Civita 公式（独立な経路）の 2 経路の一致を見る。
#   (c) そのうえで本文の 6 式そのものを確かめる。
#   (d) 反例探し: 「どの 2 つの相異なる Pauli 行列も可換ではない」「sigma^a sigma^b は
#       a != b のとき I の定数倍ではない」ことを確かめ、6 式が自明に成り立っているのでは
#       ないことを示す。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import numpy as np

IU = complex(0.0, 1.0)

rep = CheckReport("<pauli_matrix_products>: Pauli 行列の積")

# --- (a) literal な定義（本文 statement の成分をそのまま書き写したもの） ---
loc = {
    '0': np.array([[1, 0], [0, 1]], dtype=complex),
    'x': np.array([[0, 1], [1, 0]], dtype=complex),
    'y': np.array([[0, -IU], [IU, 0]], dtype=complex),
    'z': np.array([[1, 0], [0, -1]], dtype=complex),
}
for a in ['0', 'x', 'y', 'z']:
    rep.close(loc[a], PAULI[a], "(a) operators.sage の PAULI['%s'] と本文の成分が一致" % a)

# --- (b) Levi-Civita 公式との突き合わせ（独立な閉形式） ---
LEVI = {
    ('x', 'y', 'z'): 1.0, ('y', 'z', 'x'): 1.0, ('z', 'x', 'y'): 1.0,
    ('x', 'z', 'y'): -1.0, ('z', 'y', 'x'): -1.0, ('y', 'x', 'z'): -1.0,
}
axes = ['x', 'y', 'z']
for a in axes:
    for b in axes:
        formula = (1.0 if a == b else 0.0) * loc['0']
        for c in axes:
            e = LEVI.get((a, b, c), 0.0)
            if e != 0.0:
                formula = formula + IU * e * loc[c]
        rep.close(loc[a] @ loc[b], formula,
                  "(b) sigma^%s sigma^%s = delta I + i eps sigma" % (a, b))

# --- (c) 本文の 6 式 ---
for a in axes:
    rep.close(loc[a] @ loc[a], loc['0'], "(c) sigma^%s sigma^%s = I" % (a, a))

rep.close(loc['z'] @ loc['x'], -(loc['x'] @ loc['z']),
          "(c) sigma^z sigma^x = - sigma^x sigma^z")
rep.close(loc['y'] @ loc['x'], -(loc['x'] @ loc['y']),
          "(c) sigma^y sigma^x = - sigma^x sigma^y")
rep.close(loc['y'] @ loc['z'], -(loc['z'] @ loc['y']),
          "(c) sigma^y sigma^z = - sigma^z sigma^y")

# --- (d) 反例探し: 6 式が自明ではないことの確認 ---
for (a, b) in [('x', 'y'), ('y', 'z'), ('z', 'x')]:
    c = comm(loc[a], loc[b])
    rep.truth(float(np.max(np.abs(c))) > 1.0,
              "(d) [sigma^%s, sigma^%s] != 0（可換ではない: max|.|=%.3f）"
              % (a, b, float(np.max(np.abs(c)))))
    p = loc[a] @ loc[b]
    # p が I のスカラー倍なら、非対角成分が 0 かつ対角成分が等しい
    is_scalar = (abs(p[0, 1]) < 1e-12 and abs(p[1, 0]) < 1e-12
                 and abs(p[0, 0] - p[1, 1]) < 1e-12)
    rep.truth(not is_scalar,
              "(d) sigma^%s sigma^%s は I のスカラー倍ではない" % (a, b))

# 追加: 3 式 sigma^a sigma^a = I が「全部同じ行列だから」ではないこと
rep.truth(float(np.max(np.abs(loc['x'] - loc['y']))) > 0.5, "(d) sigma^x != sigma^y")
rep.truth(float(np.max(np.abs(loc['y'] - loc['z']))) > 0.5, "(d) sigma^y != sigma^z")
rep.truth(float(np.max(np.abs(loc['z'] - loc['x']))) > 0.5, "(d) sigma^z != sigma^x")

rep.finish()
