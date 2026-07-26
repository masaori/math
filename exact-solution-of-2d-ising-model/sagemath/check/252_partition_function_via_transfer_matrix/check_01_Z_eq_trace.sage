# 252-01: Z(J,J') = tr((V_1 V_2)^M)
#
# 左辺: 2^{MN} 通りの全スピン配位のブルートフォース和（def_partition_function_2d_ising）
# 右辺: 2^N × 2^N の転送行列の積のトレース（def_transfer_matrix）
# の 2 つの完全に独立な計算経路で突き合わせる。
#
# M ≠ N の組と J ≠ J' を必ず含める（J と J' の割り当ての入れ替わりを検出するため）。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

import time

rep = CheckReport("partition_function_via_transfer_matrix: Z(J,J') = tr((V_1V_2)^M)")

t0 = time.time()
for (M, N) in MN_PAIRS:
    for (J, Jp) in JJ_PAIRS:
        lhs = brute_force_Z(M, N, J, Jp)
        rhs = trace_transfer(M, N, J, Jp)
        rep.close(lhs, rhs, "M=%d N=%d J=%.6g J'=%.6g" % (M, N, J, Jp))
        print("  M=%d N=%d J=%.6g J'=%.6g : Z=%.10e  tr=%.10e  rel=%.2e"
              % (M, N, J, Jp, lhs, rhs, abs(lhs - rhs) / max(1.0, abs(lhs))))
print("elapsed: %.1f s (総配位数 2^{MN} は最大 2^12 = 4096)" % (time.time() - t0))

rep.finish()
