# <cos_arctan_sin_arctan>: cos(arctan x) = 1/sqrt(1+x^2), sin(arctan x) = x/sqrt(1+x^2)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(214))
rep = CheckReport("cos_arctan_sin_arctan")
xs = [0.0, 1e-8, 0.5, 1.0, 2.0, 10.0, 1e6, -0.5, -1.0, -10.0, -1e6] + [float(rng.normal()*5) for _ in range(40)]
for x in xs:
    a = math.atan(x)
    d = sqrt_nonneg(1 + x*x)
    rep.close(math.cos(a), 1.0/d, f"x={x:.6e}: cos(arctan x)")
    rep.close(math.sin(a), x/d, f"x={x:.6e}: sin(arctan x)")
    rep.truth(-1 <= x/d <= 1, f"x={x:.6e}: x/sqrt(1+x^2) in [-1,1]（arcsin の定義域）")
    rep.close(math.tan(a), x, f"x={x:.6e}: tan(arctan x) = x")
rep.finish()
