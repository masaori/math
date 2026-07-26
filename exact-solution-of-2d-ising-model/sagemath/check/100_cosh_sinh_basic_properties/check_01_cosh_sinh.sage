# <cosh_sinh_basic_properties>: (1)-(4)
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(201))
rep = CheckReport("cosh_sinh_basic_properties")
xs = [0.0, 1e-8, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0, -0.1, -1.0, -5.0] + [float(rng.normal()*3) for _ in range(30)]
for x in xs:
    ch = (math.exp(x)+math.exp(-x))/2
    sh = (math.exp(x)-math.exp(-x))/2
    rep.close(ch, math.cosh(x), f"x={x:.4f}: cosh の定義式")
    rep.close(sh, math.sinh(x), f"x={x:.4f}: sinh の定義式")
    rep.close(ch - sh, math.exp(-x), f"x={x:.4f}: (1) cosh - sinh = exp(-x)")
    rep.close(ch + sh, math.exp(x), f"x={x:.4f}: (1) cosh + sinh = exp(x)")
    rep.truth(math.exp(-x) > 0 and ch > 0, f"x={x:.4f}: (1) exp(-x) > 0, cosh > 0")
    rep.truth(ch > sh, f"x={x:.4f}: (1) cosh > sinh")
    # cosh^2 - sinh^2 は catastrophic cancellation を起こす（x=10 で cosh^2 ~ 1.2e8）。
    # 倍精度で意味のある判定にするため、相殺前の大きさ cosh^2 に比例した許容誤差で比べる。
    tol_cancel = 1e-14 * max(1.0, ch*ch)
    rep.truth(abs((ch*ch - sh*sh) - 1.0) <= tol_cancel,
              f"x={x:.4f}: (2) cosh^2 - sinh^2 = 1 "
              f"（誤差={abs(ch*ch-sh*sh-1):.3e} <= {tol_cancel:.3e}、相殺前の大きさ {ch*ch:.3e}）")
    if x > 0:
        rep.truth(ch > sh > 0, f"x={x:.4f}: (3) x>0 で cosh > sinh > 0")
    if x < 0:
        rep.truth(sh < 0, f"x={x:.4f}: x<0 で sinh < 0（(3) の前提が必要であること）")
# (4) a,b > 0 で a^2 = b^2 ⟺ a = b
for _ in range(50):
    a = abs(float(rng.normal()))+1e-6
    b = abs(float(rng.normal()))+1e-6
    rep.truth((abs(a*a-b*b) < 1e-12) == (abs(a-b) < 1e-12) or abs(a-b) > 1e-9,
              f"(4) a={a:.6f} b={b:.6f}: a^2=b^2 ⟺ a=b")
    rep.close(a, sqrt_nonneg(a*a), f"(4) a={a:.6f}: a>0 なら sqrt(a^2) = a")
    # 正値性を外すと偽: (-a)^2 = a^2 だが -a != a
    rep.truth(abs((-a)*(-a) - a*a) < 1e-12 and abs(-a - a) > 1e-9, f"(4) の正値性が必要（a={a:.6f}）")
rep.finish()
