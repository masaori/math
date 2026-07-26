# ---------------------------------------------------------
# K_2^* を「対数の閉じた式」ではなく「方程式 sinh(2K_2) sinh(2x) = 1 の解」として
# 二分法で数値的に求め、-(1/2) log(tanh K_2) と一致することを確かめる。
# 対象: structured-latex `duality_c2_star_eq_s2_star_c2`
#
# これにより s_2^* = 1/s_2 が「定義の書き換え」ではなく、
# 定義 K_2^* = -(1/2) log(tanh K_2) から実際に従うことを独立に確認できる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("duality_c2_star_eq_s2_star_c2: K_2^* を二分法で解いて閉じた式と比較", tol=1e-12)


def solve_K2star(K2):
    """sinh(2K_2) sinh(2x) = 1 を満たす x > 0 を二分法で求める。"""
    s2 = float(np.sinh(2.0 * K2))
    f = lambda x: s2 * np.sinh(2.0 * x) - 1.0
    lo, hi = 1e-12, 1.0
    while f(hi) < 0.0:
        hi *= 2.0
        if hi > 1e6:
            raise RuntimeError("bracket not found")
    for _ in range(200):
        mid = 0.5 * (lo + hi)
        if f(mid) < 0.0:
            lo = mid
        else:
            hi = mid
    return 0.5 * (lo + hi)


K2_list = sorted(set([p['K2'] for p in OP_TEST_PARAMS]
                     + CRIT_K2_LIST
                     + [0.05, 0.2, 0.7, 1.5, 3.0]))

for K2 in K2_list:
    x = solve_K2star(K2)
    K2s = float(K_star(K2))
    rep.close(x, K2s, "[K2=%.6f] 二分法解 = -(1/2) log(tanh K_2)" % K2)
    rep.close(float(np.cosh(2 * x)), float(c_of(K2)) / float(s_of(K2)),
              "[K2=%.6f] cosh(2x) = c_2/s_2" % K2)

rep.finish()
