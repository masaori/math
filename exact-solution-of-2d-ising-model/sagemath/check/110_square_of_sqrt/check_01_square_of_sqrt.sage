# <square_of_sqrt>: z = ± sqrt(z^2) の場合分け
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(211))
rep = CheckReport("square_of_sqrt")
zs = sample_complex(rng)
c1 = c2 = 0
for z in zs:
    a = arg_def(z)
    s = sqrt_def(z*z)
    # 境界 arg z = 0, pi はどちらの分岐に落ちるかが倍精度で定まらないので分離する。
    if abs(a) < 1e-9 or abs(a - math.pi) < 1e-9 or abs(a - 2*math.pi) < 1e-9:
        ok = (abs(z - s) < 1e-8*max(1.0,abs(z))) or (abs(z + s) < 1e-8*max(1.0,abs(z)))
        rep.truth(ok, f"境界 z={z} arg={a:.12f}: ± のいずれかに一致")
        continue
    if a < math.pi - 1e-12:
        c1 += 1
        rep.close(z, s, f"z={z} arg={a:.6f} < pi: z = sqrt(z^2)")
    else:
        c2 += 1
        rep.close(z, -s, f"z={z} arg={a:.6f} >= pi: z = -sqrt(z^2)")
print(f"  0<=arg<pi の場合 {c1} 件、pi<=arg<2pi の場合 {c2} 件")
rep.truth(c1 > 0 and c2 > 0, "両方の場合を踏んでいる")
rep.finish()
