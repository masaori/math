# <multiplicative_group_of_cc>: C^x = C \ {0} が乗法群、z^{-1} = 1/z
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
load(os.path.join(_dir, "_prelude.sage"))
rng = np.random.default_rng(int(302))
rep = CheckReport("multiplicative_group_of_cc")
zs = [z for z in sample_complex(rng) if abs(z) > 1e-12]
one = complex(1,0)
for a in zs[:30]:
    inv = complex(a.real/(a.real**2+a.imag**2), -a.imag/(a.real**2+a.imag**2))
    rep.close(a*inv, one, f"z={a}: 逆元 z^{{-1}} z = 1")
    rep.close(inv, 1/a, f"z={a}: z^{{-1}} = 1/z")
    rep.truth(abs(a*inv) > 0, f"z={a}: 積が 0 でない（閉性）")
    for b in zs[:20]:
        rep.truth(abs(a*b) > 1e-24, f"閉性: 非零どうしの積は非零")
        for c in zs[:8]:
            rep.close((a*b)*c, a*(b*c), "結合律")
    rep.close(a*one, a, f"z={a}: 単位元")
rep.finish()
