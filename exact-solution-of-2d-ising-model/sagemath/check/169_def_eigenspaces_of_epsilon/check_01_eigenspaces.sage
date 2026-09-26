# <def_eigenspaces_of_epsilon>: F^{(+)} = {f | eps f = f} は C^{2^M} の C-部分線型空間
#   零ベクトルを含み、和と複素スカラー倍で閉じることを乱数ベクトルで確かめ、
#   あわせて eps = sigma^x_1 ... sigma^x_M の積表示と dim F^{(+)} = 2^{M-1} を観測する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("def_eigenspaces_of_epsilon")
rng = np.random.default_rng(int(20260926))
for M in [1,2,3,4,5]:
    E = eps_op(M)
    d = 2**M
    # eps = sigma^x_1 ... sigma^x_M
    prod = eye_M(M)
    for m in range(1,M+1):
        prod = prod @ sx(m,M)
    rep.close(E, prod, f"M={M}: eps = sigma^x_1 ... sigma^x_M")
    # F^{(+)} の元を作る: f = x + eps x は eps f = x + eps^2 x = f を満たす
    def even_vector():
        x = rng.normal(size=int(d)) + 1j*rng.normal(size=int(d))
        return x + E @ x
    zero = np.zeros(int(d), dtype=complex)
    rep.close(E @ zero, zero, f"M={M}: 零ベクトルは F^(+) に属する")
    for t in range(4):
        f = even_vector(); g = even_vector()
        a = complex(rng.normal(), rng.normal())
        rep.close(E @ f, f, f"M={M} #{t}: eps f = f")
        rep.close(E @ (f + g), f + g, f"M={M} #{t}: eps (f+g) = f+g")
        rep.close(E @ (a*f), a*f, f"M={M} #{t}: eps (a f) = a f")
    w = np.linalg.eigvalsh(E)
    npos = int(np.sum(np.abs(w - 1) < 1e-10))
    print(f"  M={M}: dim F^(+)={npos}, 2^(M-1)={2**(M-1)}")
    rep.truth(npos == 2**(M-1), f"M={M}: dim F^(+) = 2^(M-1)（観測）")
rep.finish()
