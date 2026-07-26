# <arg_of_quotient_of_complex_numbers>: arg(z1/z2) の場合分け
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(206))
rep = CheckReport("arg_of_quotient_of_complex_numbers")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-12]
c1 = c2 = 0
for z1 in zs[:35]:
    for z2 in zs[:35]:
        r1, t1 = phi_polar(z1); r2, t2 = phi_polar(z2)
        n1, n2 = n_of_theta(t1), n_of_theta(t2)
        u = t1 - t2 - 2*(n1-n2)*math.pi
        a1, a2 = arg_def(z1), arg_def(z2)
        got = arg_def(z1/z2)
        if -1e-12 <= u < 2*math.pi:
            c1 += 1; exp = a1 - a2
        elif -2*math.pi < u < 1e-12:
            c2 += 1; exp = a1 - a2 + 2*math.pi
        else:
            continue
        d = abs((got - exp + math.pi) % (2*math.pi) - math.pi)
        rep.truth(d < 1e-8, f"z1={z1} z2={z2}: arg(z1/z2) の場合分け (差={d:.3e})")
print(f"  第1の場合 {c1} 件、第2の場合 {c2} 件")
rep.truth(c1 > 0 and c2 > 0, "両方の場合を実際に踏んでいる")
rep.finish()
