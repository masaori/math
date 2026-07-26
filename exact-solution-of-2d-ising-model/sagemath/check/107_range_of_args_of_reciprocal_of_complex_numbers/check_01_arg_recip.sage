# <range_of_args_of_reciprocal_of_complex_numbers>: arg(1/z) の場合分け
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(208))
rep = CheckReport("range_of_args_of_reciprocal_of_complex_numbers")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-12]
c0 = cp = 0
for z in zs:
    a = arg_def(z)
    got = arg_def(1/z)
    if a < 1e-12:
        c0 += 1; exp = 0.0
    else:
        cp += 1; exp = 2*math.pi - a
    d = abs((got - exp + math.pi) % (2*math.pi) - math.pi)
    rep.truth(d < 1e-8, f"z={z}: arg(1/z) (arg z={a:.6f}, 差={d:.3e})")
print(f"  arg z = 0 の場合 {c0} 件、0 < arg z < 2pi の場合 {cp} 件")
rep.truth(c0 > 0 and cp > 0, "両方の場合を踏んでいる")
rep.finish()
