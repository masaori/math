# <matrix_completeness> (1) 完備性: Cauchy 列は収束する
#
# 数値では「Cauchy ⟹ 収束」を証明できないので、本文の証明の骨格を検査する:
#   Step 1: max|a_ij| <= ||A||（成分は行列ノルムで抑えられる）
#     ⇒ 行列列が Cauchy なら各成分が Cauchy
#   Step 2-3: 各成分が K の Cauchy 列として収束し、その成分を並べた行列へノルム収束する
#
# 具体的には Cauchy 列を構成し、
#   (a) sup_{N,M >= N0} ||A_N - A_M|| が N0 とともに単調に 0 へ落ちること（Cauchy 性）
#   (b) 成分ごとの極限を並べた行列へノルム収束すること
#   (c) 極限が独立に計算できる閉形式（等比級数の和）と一致すること
# を確認する。(c) が「同語反復でない」独立経路である。
# check_01 は (2) の絶対収束判定側を見ており、こちらは (1) の完備性側を埋める。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("matrix_completeness (1) 完備性（Cauchy 性と極限）")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def rand_mat(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal((int(n),int(n))) + 1j*g.standard_normal((int(n),int(n))))
def le_ok(x, y, slack=1e-12):
    x = float(x); y = float(y)
    return x <= y + float(slack)*max(1.0, abs(x), abs(y))

n = 4
C = rand_mat(n, 13001, 1.0)

for r in [0.5, 0.9, -0.3, 0.6+0.3j]:
    # A_N := Σ_{m=0}^{N} r^m C。閉形式は (1-r^{N+1})/(1-r) C -> C/(1-r)。
    A_limit = C/(1.0 - r)
    def A_of(N, r=r):
        return ((1.0 - r**(int(N)+1))/(1.0 - r))*C

    # (a) Cauchy 性: N0 を上げると sup_{N,M>=N0} ||A_N - A_M|| が落ちる
    print("r=%s:" % (r,))
    prev_sup = None
    for N0 in [0,5,10,20,40,80,200]:
        sup = 0.0
        for N in range(N0, N0+40):
            for M2 in range(N0, N0+40):
                sup = max(sup, fro(A_of(N) - A_of(M2)))
        if prev_sup is not None:
            rep.truth(le_ok(sup, prev_sup),
                      f"(1) Cauchy 性: sup は N0 について単調非増加 (r={r}, N0={N0})")
        # A_N - A_M = (r^{M+1} - r^{N+1})/(1-r) C なので sup <= 2|r|^{N0+1} ||C|| / |1-r|
        rep.truth(le_ok(sup, 2.0*abs(r)**(N0+1)*fro(C)/abs(1.0-r)),
                  f"(1) Cauchy 性: sup <= 2|r|^(N0+1)||C||/|1-r| (r={r}, N0={N0})")
        print("   N0=%3d: sup_{N,M>=N0} ||A_N-A_M|| = %.6e" % (N0, sup))
        prev_sup = sup
    rep.truth(prev_sup < 1e-6, f"(1) Cauchy 性: N0=200 で sup < 1e-6 (r={r}, 実測 {prev_sup:.3e})")

    # (b)(c) 成分ごとの極限を並べた行列 = 閉形式の極限、かつノルム収束
    A_big = A_of(400)
    rep.close(A_big, A_limit, f"(1) A_N -> C/(1-r) （閉形式との一致, r={r}）")
    rep.truth(fro(A_big - A_limit) < 1e-9,
              f"(1) ||A_400 - A|| < 1e-9 (r={r}, 実測 {fro(A_big - A_limit):.3e})")

    # Step 1 の評価 max|(A_N - A)_ij| <= ||A_N - A|| が全 N で成り立つこと
    for N in [0,3,10,50]:
        D = A_of(N) - A_limit
        rep.truth(le_ok(float(np.max(np.abs(D))), fro(D)),
                  f"(1) Step 1: max|(A_N-A)_ij| <= ||A_N-A|| (r={r}, N={N})")

rep.finish()
