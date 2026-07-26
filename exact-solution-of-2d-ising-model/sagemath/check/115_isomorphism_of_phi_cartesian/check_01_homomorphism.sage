# <isomorphism_of_phi_cartesian>: phi_cartesian が積を保ち、全単射
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(216))
rep = CheckReport("isomorphism_of_phi_cartesian")
# 極座標表現の積は [(r,th)]・[(r',th')] = [(r r', th+th')]（<operations_on_polar_representation>）
pairs = [(abs(float(rng.normal()))*2, float(rng.normal()*6)) for _ in range(40)]         + [(0.0, 0.0), (1.0, 0.0), (1.0, math.pi), (2.0, 2*math.pi)]
for (r1,t1) in pairs[:25]:
    for (r2,t2) in pairs[:25]:
        lhs = phi_cartesian(r1*r2, t1+t2)
        rhs = phi_cartesian(r1,t1) * phi_cartesian(r2,t2)
        rep.close(lhs, rhs, "phi_cartesian は積を保つ（モノイド準同型）")
# phi_polar が phi_cartesian の逆写像であること（全単射性）
for z in sample_complex(rng):
    r, t = phi_polar(z)
    rep.close(phi_cartesian(r,t), z, f"z={z}: phi_cartesian(phi_polar(z)) = z（全射）")
for (r,t) in pairs:
    z = phi_cartesian(r,t)
    r2, t2 = phi_polar(z)
    rep.close(r2, r, "pr_1 が一致（単射: 代表元の第1成分）")
    if r > 1e-12:
        d = abs((t2 - t + math.pi) % (2*math.pi) - math.pi)
        rep.truth(d < 1e-8, "偏角が 2pi の差を除いて一致（単射）")
rep.finish()
