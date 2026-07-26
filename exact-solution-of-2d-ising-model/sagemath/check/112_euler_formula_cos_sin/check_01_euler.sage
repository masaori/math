# <euler_formula_cos_sin>: cos t = (e^{it}+e^{-it})/2, sin t = (e^{it}-e^{-it})/(2i)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(213))
rep = CheckReport("euler_formula_cos_sin")
ts = [0.0, math.pi/6, math.pi/4, math.pi/3, math.pi/2, math.pi, 3*math.pi/2, 2*math.pi, -1.0, 10.0]      + [float(rng.normal()*5) for _ in range(40)]
for t in ts:
    e_p = complex(math.cos(t), math.sin(t))     # e^{it}（定義側は cos/sin で作る）
    e_m = complex(math.cos(-t), math.sin(-t))
    rep.close((e_p+e_m)/2, complex(math.cos(t),0), f"t={t:.6f}: cos の表示")
    rep.close((e_p-e_m)/(2j), complex(math.sin(t),0), f"t={t:.6f}: sin の表示")
    # 独立経路: numpy の complex exp
    rep.close(np.exp(1j*t), e_p, f"t={t:.6f}: e^{{it}} = cos t + i sin t")
rep.finish()
