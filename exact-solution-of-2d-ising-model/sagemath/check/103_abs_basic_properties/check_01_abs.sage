# <abs_basic_properties>: (1)-(6)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(204))
rep = CheckReport("abs_basic_properties")
zs = sample_complex(rng)
for z in zs:
    x, y = z.real, z.imag
    rep.close(abs_def(z), sqrt_nonneg(x*x+y*y), f"z={z}: (1) |z| = sqrt(x^2+y^2)")
    rep.close(abs_def(z)**2, x*x+y*y, f"z={z}: (2) |z|^2 = x^2+y^2")
    rep.truth((abs_def(z) == 0) == (z == 0), f"z={z}: (3) |z|=0 ⟺ z=0")
for z1 in zs[:25]:
    for z2 in zs[:25]:
        rep.close(abs_def(z1*z2), abs_def(z1)*abs_def(z2), f"(4) |z1 z2| = |z1||z2|")
        rep.truth(abs_def(z1+z2) <= abs_def(z1)+abs_def(z2)+1e-9, f"(5) 三角不等式")
for x in [0.0, 1.0, -1.0, 3.5, -7.25]:
    rep.close(abs_def(complex(x,0)), abs(x), f"(6) 実数の包含で絶対値が一致 x={x}")
# 三角不等式の等号（同じ偏角）
z = complex(3,4)
rep.close(abs_def(z + 2*z), abs_def(z) + abs_def(2*z), "(5) 同じ偏角で等号")
rep.finish()
