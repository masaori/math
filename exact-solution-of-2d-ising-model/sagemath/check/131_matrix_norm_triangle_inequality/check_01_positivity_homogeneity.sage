# ---------------------------------------------------------
# <matrix_norm_triangle_inequality> (1) 正定値性 と (2) 斉次性。
#
#   (1) ‖A‖ ≥ 0 であり、‖A‖ = 0 ⟺ A = O
#   (2) ‖cA‖ = |c| ‖A‖
#
# 反例を探す姿勢:
#   - (1) の「⟸」は自明なので、「⟹」側（‖A‖ が小さいなら A の全成分が小さい）を
#     成分の最大絶対値と突き合わせて確認する。零に極めて近い（が零でない）行列も入れる。
#   - (2) は c を実正・実負・純虚・複素・0・巨大/微小と変えて確認する。
#     |c| は <def_abs_arg> の絶対値（numpy の abs）。
#
# 対象: structured-latex matrix_norm_triangle_inequality
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_triangle_inequality (1) 正定値性 / (2) 斉次性")

mats = test_matrices(n_random=8, n=5, scale=2.0)

# --- (1) 正定値性 -----------------------------------------------------
for name, A in mats:
    a = fro(A)
    rep.truth(a >= 0.0, "(1) ‖A‖ ≥ 0: %s" % name)
    is_zero = bool(np.all(np.asarray(A) == 0))
    rep.truth((a == 0.0) == is_zero, "(1) ‖A‖=0 ⟺ A=O: %s" % name)

# 零に極めて近い（が零でない）行列: ノルムも 0 にならないこと
for e in [-2, -6, -10, -14]:
    A = np.zeros((4, 4), dtype=complex)
    A[2, 3] = 10.0 ** e
    rep.truth(fro(A) > 0.0, "(1) 1 成分だけ 1e%d の行列は ‖A‖>0（実測 %.3e）" % (e, fro(A)))
    rep.close(fro(A), 10.0 ** e, "(1) ‖A‖ = |a_23| （1 成分行列, 1e%d）" % e)

# ノルムが小さいなら全成分が小さい（|a_ij| ≤ ‖A‖、<matrix_completeness> Step 1 と同じ評価）
for name, A in mats:
    A = np.asarray(A)
    rep.truth(le_ok(float(np.max(np.abs(A))), fro(A)),
              "(1) max|a_ij| ≤ ‖A‖: %s" % name)

# --- (2) 斉次性 -------------------------------------------------------
scalars = [0.0, 1.0, -1.0, 2.5, -3.7, 1j, -2j, 0.3 + 0.4j, 1e-8, 1e8, -1e-6 + 1e-6j]
for name, A in mats[:20]:
    for c in scalars:
        rep.close(fro(c * np.asarray(A)), abs(c) * fro(A),
                  "(2) ‖cA‖ = |c|‖A‖ (c=%s): %s" % (c, name))

# 斉次性の「破れ」の検査: |c| を取り違えた式（c の実部など）では合わないこと
A = rand_mat(4, 6001, 1.0)
c = 0.3 + 0.4j
bad = abs(c.real) * fro(A)
rep.truth(abs(fro(c * A) - bad) > 1e-3,
          "(2) |c| を Re(c) に取り違えると合わない（差 %.3e）" % abs(fro(c * A) - bad))

rep.finish()
