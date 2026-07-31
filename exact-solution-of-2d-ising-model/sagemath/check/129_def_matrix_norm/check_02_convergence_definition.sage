# <def_matrix_norm>: 「収束」の定義が成分ごとの収束と同じものを指すこと
#
# 定義: A_N -> A ⟺ ||A_N - A|| -> 0。
# 独立経路: 成分ごとの最大絶対差 d_N := max_{i,j} |(A_N)_ij - A_ij|。
#   有限次元では ||・|| と max|・| は同値なノルムで、n x n 行列について
#       d_N <= ||A_N - A|| <= n * d_N
#   が成り立つ。これを実際の収束列で確認する（同語反復ではなく、
#   「ノルム収束 ⟺ 成分収束」という本文が暗に使っている事実の検査）。
# 併せて、級数 Σ B_m := lim S_N の定義が独立に計算できる閉形式（等比級数）と一致することも見る。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("def_matrix_norm: 収束の定義（ノルム収束 ⟺ 成分収束、級数の定義）")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def rand_mat(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal((int(n),int(n))) + 1j*g.standard_normal((int(n),int(n))))
def le_ok(x, y, slack=1e-12):
    # 倍精度の丸めで「厳密には成り立つ不等式」が 1e-16 程度破れうるので等号ぎりぎりを許す
    x = float(x); y = float(y)
    return x <= y + float(slack)*max(1.0, abs(x), abs(y))

# --- 1. ノルム収束 ⟺ 成分収束 ---
for n in [2,4,8]:
    A = rand_mat(n, 5100+n, 1.0)
    C = rand_mat(n, 5200+n, 1.0)
    print("n=%d: N, ||A_N-A||, max|成分差|, 比" % n)
    for N in [1,4,16,64,256]:
        AN = A + C/float(N)
        d = float(np.max(np.abs(AN - A)))
        f = fro(AN - A)
        rep.truth(le_ok(d, f), f"n={n},N={N}: max|成分差| <= ||・||")
        rep.truth(le_ok(f, n*d), f"n={n},N={N}: ||・|| <= n*max|成分差|")
        print("   N=%3d  %.6e  %.6e  %.4f" % (N, f, d, f/d))

# 逆向き: 成分が収束しない列はノルムでも収束しない（定義の非退化性）
A = rand_mat(4, 5300, 1.0)
worst = 0.0
for N in [10,100,1000]:
    AN = A.copy()
    AN[0,0] = AN[0,0] + 0.5   # 1 成分だけずらしたまま
    worst = max(worst, fro(AN - A))
rep.truth(worst >= 0.4, f"1 成分がずれ続ける列は ||A_N-A||->0 にならない（実測 {worst:.3f}）")

# --- 2. 級数の定義 Σ B_m = lim S_N ---
# B_m := r^m C（|r|<1）なら Σ_{m=0}^{∞} B_m = (1-r)^{-1} C（等比級数、閉形式）
C = rand_mat(4, 5400, 1.0)
for r in [0.5, -0.3, 0.9, 0.5+0.5j]:
    S_inf = C/(1.0 - r)
    S = np.zeros((4,4), dtype=complex)
    for m in range(0, 400):
        S = S + (r**m)*C
    rep.close(S, S_inf, f"Σ_m r^m C = (1-r)^(-1) C  (r={r})")
    print("r=%s: ||S_399 - S|| = %.3e" % (r, fro(S - S_inf)))

rep.finish()
