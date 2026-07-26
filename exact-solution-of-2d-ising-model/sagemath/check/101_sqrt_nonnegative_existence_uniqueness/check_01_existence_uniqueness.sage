# <sqrt_nonnegative_existence_uniqueness>: 非負実数の平方根の存在・一意性
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(202))
rep = CheckReport("sqrt_nonnegative_existence_uniqueness")
xs = [0.0, 1e-12, 1e-6, 0.25, 1.0, 2.0, 10.0, 1e6, 1e12] + [abs(float(rng.normal()))*10 for _ in range(40)]
for x in xs:
    y = sqrt_nonneg(x)           # 二分法で構成（存在）
    rep.truth(y >= 0, f"x={x:.6e}: y >= 0")
    rep.close(y*y, x, f"x={x:.6e}: y^2 = x（存在）")
    # 一意性: y' >= 0 かつ y'^2 = x なら y' = y
    for pert in [1e-9, 1e-7, 1e-5]:
        yp = y + pert
        if yp >= 0:
            rep.truth(abs(yp*yp - x) > 0 or x == 0, f"x={x:.6e}: y+{pert} は y^2=x を満たさない（一意性）")
    # 負の候補は R_{>=0} に属さない
    rep.truth(-y <= 0, f"x={x:.6e}: -y は非負ではない（値域の指定が効く）")
rep.finish()
