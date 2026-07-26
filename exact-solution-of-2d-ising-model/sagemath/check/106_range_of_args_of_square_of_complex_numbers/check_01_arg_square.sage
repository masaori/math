# <range_of_args_of_square_of_complex_numbers>: arg(z^2) の場合分け
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(207))
rep = CheckReport("range_of_args_of_square_of_complex_numbers")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-12]
c1 = c2 = 0
for z in zs:
    a = arg_def(z)
    got = arg_def(z*z)
    if a < math.pi - 1e-12:
        c1 += 1; exp = 2*a
    else:
        c2 += 1; exp = 2*a - 2*math.pi
    d = abs((got - exp + math.pi) % (2*math.pi) - math.pi)
    rep.truth(d < 1e-8, f"z={z}: arg(z^2) (arg z={a:.6f}, 差={d:.3e})")
print(f"  0 <= arg < pi の場合 {c1} 件、pi <= arg < 2pi の場合 {c2} 件")
rep.truth(c1 > 0 and c2 > 0, "両方の場合を踏んでいる")
rep.finish()
