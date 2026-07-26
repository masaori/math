# <real_exp_series_converges>: E_N(a) の単調性・有界性・剰余評価
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rep = CheckReport("real_exp_series_converges")
for a in [0.0, 0.1, 0.5, 1.0, 2.5, 5.0, 10.0, 20.0]:
    Es = []
    s = 0.0
    for m in range(0, 200):
        s += a**m/math.factorial(m)
        Es.append(s)
    E = math.exp(a)
    rep.truth(all(Es[k] <= Es[k+1] + 1e-15 for k in range(len(Es)-1)), f"a={a}: 単調非減少")
    rep.truth(all(e <= E + 1e-9 for e in Es), f"a={a}: E_N(a) <= E(a)")
    rep.close(Es[-1], E, f"a={a}: 極限が exp(a)")
    Rs = [E - e for e in Es]
    rep.truth(all(r >= -1e-9 for r in Rs), f"a={a}: 剰余は非負")
    # 剰余は E(a) に対する相対量で見る（a=20 では E(a) ~ 4.85e8 なので絶対値では倍精度の丸めに埋もれる）
    rep.truth(Rs[-1] <= 1e-12*max(1.0, E), f"a={a}: 剰余 -> 0（R_N={Rs[-1]:.3e}, E(a)={E:.3e}）")
    # sum_{m=p}^{q} a^m/m! <= R_{p-1}(a)
    for p in [1, 3, 7, 15]:
        for q in [p, p+2, p+10, 60]:
            if q < p: continue
            partial = sum(a**m/math.factorial(m) for m in range(p, q+1))
            rep.truth(partial <= Rs[p-1] + 1e-12*max(1.0,E), f"a={a} p={p} q={q}: 部分和 <= R_(p-1)")
rep.finish()
