# <sqrt_expansion_via_polar>: 定義式（pr_1, pr_2, s 経由）と代表元表示 (sqrt r, theta/2 - n pi) の一致
# 左辺は def_sqrt_cc をそのまま、右辺は代表元 (r,theta) と n から独立に組む。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(209))
rep = CheckReport("sqrt_expansion_via_polar")
zs = sample_complex(rng)
for z in zs:
    r, th = phi_polar(z)
    n = n_of_theta(th)
    lhs = sqrt_def(z)                                   # 定義式
    rhs = phi_cartesian(sqrt_nonneg(r), th/2 - n*math.pi)  # 主張の右辺
    rep.close(lhs, rhs, f"z={z}: 定義式 = 代表元表示")
    rep.truth(-1e-12 <= th - 2*n*math.pi < 2*math.pi + 1e-12, f"z={z}: n の条件")
    # 代表元を 2pi ずらしても右辺は変わらない（well-defined）
    for k in [-2,-1,1,3]:
        th2 = th + 2*k*math.pi
        n2 = n_of_theta(th2)
        rep.close(phi_cartesian(sqrt_nonneg(r), th2/2 - n2*math.pi), rhs, f"z={z} k={k}: 代表元非依存")
    # r = 0（z = 0）の別扱い
    if r == 0.0:
        rep.close(lhs, complex(0,0), "z=0: sqrt(0) = 0")
    # 2 乗すると z に戻る（分枝の確認。arg が [0,2pi) なので arg/2 in [0,pi)）
    rep.close(lhs*lhs, z, f"z={z}: (sqrt z)^2 = z")
    if r != 0:
        rep.truth(-1e-12 <= arg_def(lhs) < math.pi + 1e-9, f"z={z}: arg(sqrt z) in [0,pi)")
rep.finish()
