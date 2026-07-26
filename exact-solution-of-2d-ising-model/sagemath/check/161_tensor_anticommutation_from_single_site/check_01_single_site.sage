# <tensor_anticommutation_from_single_site>: 1 サイトだけ反可換ならテンソル積全体が反交換
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rng = np.random.default_rng(int(20260726))
rep = CheckReport("tensor_anticommutation_from_single_site")

def rand2():
    return rng.normal(size=(2,2)) + 1j*rng.normal(size=(2,2))

for M in [2,3,4]:
    for j in range(1, M+1):
        for trial in range(3):
            # 第 j サイト: 反可換な組（sigma^x と sigma^z のスカラー倍は反可換）
            a = rng.normal() + 1j*rng.normal()
            b = rng.normal() + 1j*rng.normal()
            xj, yj = a*SX, b*SZ
            assert np.max(np.abs(yj@xj + xj@yj)) < 1e-12
            # 他サイト: 可換な組（片方をスカラー行列にすれば必ず可換）
            xs, ys = [], []
            for k in range(1, M+1):
                if k == j:
                    xs.append(xj); ys.append(yj)
                else:
                    c = rng.normal() + 1j*rng.normal()
                    xs.append(rand2()); ys.append(c*I2)
            X = kron_list(xs); Y = kron_list(ys)
            rep.close(acomm(X, Y), np.zeros_like(X), f"M={M} j={j} t={trial}: [X,Y]+ = 0")

# 仮定を崩す: 2 サイトで反可換にすると結論は破れる（可換になってしまう）
for M in [2,3]:
    xs = [SX]*M ; ys = [SZ]*M          # 全サイト反可換
    X = kron_list(xs); Y = kron_list(ys)
    # 反可換なサイトが偶数個なら XY = +YX（反交換子は 0 にならない）
    if M % 2 == 0:
        rep.truth(np.max(np.abs(acomm(X,Y))) > 1e-6,
                  f"M={M}: 反可換サイトが偶数個だと [X,Y]+ != 0（仮定の必要性）")
rep.finish()
