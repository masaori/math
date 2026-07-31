# <matrix_norm_triangle_inequality> (4) 極限の一意性: A_N -> A かつ A_N -> A' ならば A = A'
#
# 数値でこれを「そのまま」確かめることはできない（A=A' は極限の話）。
# そこで本文の証明の骨格そのものを検査する:
#   ||A - A'|| <= ||A_N - A|| + ||A_N - A'||   （三角不等式）
# 右辺が 0 に落ちるなら左辺（N に依らない定数）は 0 でなければならない。
#
#   (a) 収束列 A_N -> A を作り、A' := A + δ（δ != O）を候補にすると
#       ||A_N - A'|| は ||δ|| へ収束し 0 には落ちない（＝別の極限は存在しない）。
#   (b) 三角不等式による評価が全 N で成り立つ。
#   (c) δ を 0 に近づけると、区別できる N が大きくなるだけで、δ != O なら必ず区別できる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("matrix_norm_triangle_inequality (4) 極限の一意性")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def rand_mat(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal((int(n),int(n))) + 1j*g.standard_normal((int(n),int(n))))
def le_ok(x, y, slack=1e-12):
    x = float(x); y = float(y)
    return x <= y + float(slack)*max(1.0, abs(x), abs(y))

A = rand_mat(4, 8001, 1.0)
C = rand_mat(4, 8002, 1.0)      # A_N := A + C/N（A へ収束する列）
Ns = [1,2,4,8,16,64,256,1024,4096]

for e in [0,-2,-4,-6,-8]:
    delta = (10.0**e)*rand_mat(4, 8100+e, 1.0)
    Ap = A + delta
    d = fro(delta)
    tail = None
    for N in Ns:
        AN = A + C/float(N)
        lhs = fro(A - Ap)
        rhs = fro(AN - A) + fro(AN - Ap)
        rep.truth(le_ok(lhs, rhs),
                  f"(4) ||A-A'|| <= ||A_N-A||+||A_N-A'|| (||δ||={d:.1e}, N={N})")
        tail = fro(AN - Ap)
    # δ != O なら ||A_N - A'|| は ||δ|| へ張り付き、0 には落ちない。
    # A_N - A' = C/N - δ なので、逆向きの三角不等式より
    #   | ||A_N-A'|| - ||δ|| | <= ||C||/N
    # これが N -> ∞ で 0 になることが「||A_N-A'|| -> ||δ||」の中身である。
    gap = abs(tail - d)
    rep.truth(le_ok(gap, fro(C)/float(Ns[-1])),
              f"(4) | ||A_N-A'|| - ||δ|| | <= ||C||/N (||δ||={d:.1e}, N={Ns[-1]})")
    rep.truth(gap < 2e-3, f"(4) ||A_N-A'|| -> ||δ|| （N={Ns[-1]} での差 {gap:.3e}）")
    rep.truth(tail > 0.5*d, f"(4) δ != O なら ||A_N-A'|| は 0 に落ちない (||δ||={d:.1e})")
    print("||δ||=%.1e: ||A_%d-A||=%.3e, ||A_%d-A'||=%.3e"
          % (d, Ns[-1], fro(C/float(Ns[-1])), Ns[-1], tail))

# δ = O（同じ極限）のときは ||A_N - A'|| = ||C||/N で 0 へ落ちる
for N in Ns:
    rep.close(fro(C/float(N)), fro(C)/float(N), f"(4) δ=O: ||A_N-A'|| = ||C||/N (N={N})")
tail0 = fro(C/float(Ns[-1]))
rep.truth(tail0 < 1e-2, f"(4) δ=O のときは ||A_N-A'|| -> 0（実測 {tail0:.3e}）")

rep.finish()
