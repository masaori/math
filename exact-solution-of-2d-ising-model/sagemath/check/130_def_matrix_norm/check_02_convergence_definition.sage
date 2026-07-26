# ---------------------------------------------------------
# <def_matrix_norm> の「収束」の定義が、成分ごとの収束と同じものを指すことを確認する。
#
# 定義: A_N → A ⟺ ‖A_N − A‖ → 0。
# 独立経路: 成分ごとの最大絶対差 d_N := max_{i,j} |(A_N)_ij − A_ij|。
#   有限次元では ‖·‖ と max|·| は同値なノルムで、n×n 行列について
#       d_N ≤ ‖A_N − A‖ ≤ n · d_N
#   が成り立つ。これを実際の収束列で数値的に確認する（同語反復ではなく、
#   「ノルム収束 ⟺ 成分収束」という本文が暗に使っている事実の検査）。
#
# 併せて、級数 Σ B_m := lim S_N（S_N = Σ_{m≤N} B_m）の定義が、
# 独立に計算できる閉じた極限（等比級数）と一致することを確認する。
#
# 対象: structured-latex def_matrix_norm
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("def_matrix_norm: 収束の定義（ノルム収束 ⟺ 成分収束、級数の定義）")

# --- 1. ノルム収束 ⟺ 成分収束 -----------------------------------------
for n in [2, 4, 8]:
    A = rand_mat(n, 5100 + n, 1.0)
    C = rand_mat(n, 5200 + n, 1.0)
    print("n=%d: N, ‖A_N-A‖, max|成分差|, 比" % n)
    for N in [1, 4, 16, 64, 256]:
        AN = A + C / float(N)
        d = float(np.max(np.abs(AN - A)))
        f = fro(AN - A)
        rep.truth(le_ok(d, f), "n=%d,N=%d: max|成分差| ≤ ‖·‖" % (n, N))
        rep.truth(le_ok(f, n * d), "n=%d,N=%d: ‖·‖ ≤ n·max|成分差|" % (n, N))
        print("   N=%3d  %.6e  %.6e  %.4f" % (N, f, d, f / d))

# 逆向き: 成分が収束しない列はノルムでも収束しない（定義の非退化性）
A = rand_mat(4, 5300, 1.0)
worst = 0.0
for N in [10, 100, 1000]:
    AN = A.copy()
    AN[0, 0] = AN[0, 0] + 0.5   # 1 成分だけずらしたまま
    worst = max(worst, fro(AN - A))
rep.truth(worst >= 0.4, "1 成分がずれ続ける列は ‖A_N−A‖→0 にならない（実測 %.3f）" % worst)

# --- 2. 級数の定義 Σ B_m = lim S_N -----------------------------------
# B_m := r^m C（|r|<1）とすると Σ_{m=0}^{∞} B_m = (1-r)^{-1} C（等比級数、閉形式）。
# S_N を素朴に足した結果がこの閉形式へノルム収束することを確認する。
C = rand_mat(4, 5400, 1.0)
for r in [0.5, -0.3, 0.9, 0.5 + 0.5j]:
    S_inf = C / (1.0 - r)
    S = np.zeros((4, 4), dtype=complex)
    prev = None
    for m in range(0, 400):
        S = S + (r ** m) * C
        if m in (0, 1, 5, 20, 100, 399):
            prev = fro(S - S_inf)
    rep.close(S, S_inf, "Σ_{m} r^m C = (1-r)^{-1} C  (r=%s)" % (r,))
    print("r=%s: ‖S_399 − S‖ = %.3e" % (r, prev))

rep.finish()
