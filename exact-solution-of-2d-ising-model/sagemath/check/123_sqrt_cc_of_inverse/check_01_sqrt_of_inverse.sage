# <sqrt_cc_of_inverse>: (sqrt z)^{-1} = 1/sqrt z = ± sqrt(1/z)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
load(os.path.join(_dir, "_prelude.sage"))
rng = np.random.default_rng(int(304))
rep = CheckReport("sqrt_cc_of_inverse")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-8]
c0 = cp = 0
for z in zs:
    a = arg_def(z)
    rhs = 1/sqrt_def(z)
    rep.close(1/sqrt_def(z), rhs, f"z={z}: (sqrt z)^{{-1}} = 1/sqrt z")
    lhs = sqrt_def(1/z)
    if a == 0.0:
        c0 += 1
        rep.close(rhs, lhs, f"z={z} arg=0: 1/sqrt z = sqrt(1/z)")
    elif a < 1e-9 or a > 2*math.pi - 1e-9:
        ok = (abs(rhs-lhs) < 1e-8*max(1.0,abs(rhs))) or (abs(rhs+lhs) < 1e-8*max(1.0,abs(rhs)))
        rep.truth(ok, f"境界 z={z}: ± のいずれか")
    else:
        cp += 1
        rep.close(rhs, -lhs, f"z={z} 0<arg<2pi: 1/sqrt z = -sqrt(1/z)")
print(f"  arg=0 の場合 {c0} 件、0<arg<2pi の場合 {cp} 件")
rep.truth(c0 > 0 and cp > 0, "両方の場合を踏んでいる")
rep.finish()
