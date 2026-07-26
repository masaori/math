# <range_of_args_of_multiple_of_complex_numbers>: arg(z1 z2) = pi のとき arg z1 + arg z2 = pi または 3pi
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
load(os.path.join(_dir, "_prelude.sage"))
rng = np.random.default_rng(int(301))
rep = CheckReport("range_of_args_of_multiple_of_complex_numbers")
c1 = c2 = 0
# arg(z1 z2) = pi となる組を作る: z2 = -t/z1 （t > 0 実数）とすれば z1 z2 = -t で arg = pi
for z1 in [z for z in sample_complex(rng) if abs(z) > 1e-9][:60]:
    for t in [0.3, 1.0, 2.5]:
        z2 = complex(-t,0)/z1
        if abs(z2) < 1e-12: continue
        if abs(arg_def(z1*z2) - math.pi) > 1e-8: continue
        a1, a2 = arg_def(z1), arg_def(z2)
        ssum = a1 + a2
        if abs(ssum - math.pi) < 1e-7:
            c1 += 1
            rep.truth(True, f"z1={z1}: 第1の場合 arg1+arg2 = pi")
        elif abs(ssum - 3*math.pi) < 1e-7:
            c2 += 1
            rep.truth(True, f"z1={z1}: 第2の場合 arg1+arg2 = pi + 2pi")
        else:
            rep.truth(False, f"z1={z1}: arg1+arg2 = {ssum:.12f} がどちらの場合にも当てはまらない")
print(f"  第1の場合 {c1} 件、第2の場合 {c2} 件")
rep.truth(c1 > 0 and c2 > 0, "両方の場合を実際に踏んでいる")
rep.finish()
