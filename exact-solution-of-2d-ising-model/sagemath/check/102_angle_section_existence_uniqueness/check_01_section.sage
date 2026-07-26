# <angle_section_existence_uniqueness> + <section_of_angle_representation>
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(203))
rep = CheckReport("angle_section_existence_uniqueness")
ths = [0.0, 1e-12, math.pi, 2*math.pi, -2*math.pi, 2*math.pi-1e-12, -1e-12, 1e5, -1e5]       + [float(rng.normal()*20) for _ in range(60)]
for th in ths:
    n = n_of_theta(th)
    v = th - 2*n*math.pi
    rep.truth(-1e-12 <= v < 2*math.pi + 1e-12, f"theta={th:.6f}: 0 <= theta-2n pi < 2pi (v={v:.12f})")
    # 一意性: n±1 では範囲外
    for dn in [-1, 1]:
        v2 = th - 2*(n+dn)*math.pi
        rep.truth(not (0 <= v2 < 2*math.pi) or abs(v2 - v) < 1e-9,
                  f"theta={th:.6f}: n{dn:+d} は範囲外（一意性）")
    rep.close(s_02pi(th), v, f"theta={th:.6f}: s_(0,2pi) の値")
    # 2pi ずらしても切断の値は同じ（well-defined）
    for k in [-3,-1,1,2,5]:
        rep.close(s_02pi(th + 2*k*math.pi), s_02pi(th), f"theta={th:.6f} k={k}: 代表元非依存")
rep.finish()
