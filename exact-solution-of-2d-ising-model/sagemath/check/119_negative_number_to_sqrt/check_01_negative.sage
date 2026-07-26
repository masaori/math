# <negative_number_to_sqrt>: x < 0 について x = -sqrt((-x)^2)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(220))
rep = CheckReport("negative_number_to_sqrt")
xs = [-1e-12, -1e-6, -0.5, -1.0, -2.0, -1e6] + [-abs(float(rng.normal()))*7 - 1e-9 for _ in range(40)]
for x in xs:
    rep.close(x, -sqrt_nonneg((-x)**2), f"x={x:.6e}: x = -sqrt((-x)^2)")
    rep.truth(-x > 0, f"x={x:.6e}: -x > 0（sqrt の定義域）")
    # 正の数では符号が逆になる（主張が x<0 に限られる理由）
    rep.close(-x, sqrt_nonneg((-x)**2), f"x={x:.6e}: -x = sqrt((-x)^2)")
rep.finish()
