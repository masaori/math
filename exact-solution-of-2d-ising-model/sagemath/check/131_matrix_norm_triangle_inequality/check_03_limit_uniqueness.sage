# ---------------------------------------------------------
# <matrix_norm_triangle_inequality> (4) 極限の一意性。
#   A_N → A かつ A_N → A' ならば A = A'。
#
# 数値でこれを「そのまま」確かめることはできない（A=A' は極限の話）。
# そこで本文の証明の骨格そのものを検査する:
#   ‖A − A'‖ ≤ ‖A_N − A‖ + ‖A_N − A'‖   （三角不等式）
# 右辺が 0 に落ちるなら左辺（N に依らない定数）は 0 でなければならない。
#
# 具体的には:
#   (a) 収束列 A_N → A を作り、A' := A + δ（δ ≠ O）を候補にすると
#       ‖A_N − A'‖ は ‖δ‖ へ収束し 0 には落ちない（＝別の極限は存在しない）。
#   (b) 三角不等式による評価 ‖A−A'‖ ≤ ‖A_N−A‖+‖A_N−A'‖ が全 N で成り立つ。
#   (c) δ を 0 に近づけると、区別できる N が大きくなるだけで、δ≠O なら必ず区別できる。
#
# 対象: structured-latex matrix_norm_triangle_inequality
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_triangle_inequality (4) 極限の一意性")

A = rand_mat(4, 8001, 1.0)
C = rand_mat(4, 8002, 1.0)      # A_N := A + C/N（A へ収束する列）

Ns = [1, 2, 4, 8, 16, 64, 256, 1024, 4096]

for e in [0, -2, -4, -6, -8]:
    delta = (10.0 ** e) * rand_mat(4, 8100 + e, 1.0)
    Ap = A + delta
    d = fro(delta)
    tail = None
    for N in Ns:
        AN = A + C / float(N)
        lhs = fro(A - Ap)
        rhs = fro(AN - A) + fro(AN - Ap)
        rep.truth(le_ok(lhs, rhs),
                  "(4) ‖A−A'‖ ≤ ‖A_N−A‖+‖A_N−A'‖ (‖δ‖=%.1e, N=%d)" % (d, N))
        tail = fro(AN - Ap)
    # δ≠O なら ‖A_N − A'‖ は ‖δ‖ へ張り付き、0 には落ちない
    rep.close(tail, d, "(4) ‖A_N−A'‖ → ‖δ‖ (‖δ‖=%.1e, N=%d)" % (d, Ns[-1]))
    rep.truth(tail > 0.5 * d, "(4) δ≠O なら ‖A_N−A'‖ は 0 に落ちない (‖δ‖=%.1e)" % d)
    print("‖δ‖=%.1e: ‖A_{%d}−A‖=%.3e, ‖A_{%d}−A'‖=%.3e"
          % (d, Ns[-1], fro(A + C / float(Ns[-1]) - A), Ns[-1], tail))

# δ = O（同じ極限）のときは両方 0 に落ちる
tail0 = fro(A + C / float(Ns[-1]) - A)
rep.truth(tail0 < 1e-3, "(4) δ=O のときは ‖A_N−A'‖ → 0（実測 %.3e）" % tail0)

rep.finish()
