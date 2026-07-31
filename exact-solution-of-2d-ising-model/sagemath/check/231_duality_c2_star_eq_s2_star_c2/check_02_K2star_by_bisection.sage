# <duality_c2_star_eq_s2_star_c2>: K_2^* を二分法で独立に解いて閉じた式と比較する
#
# K_2^* を「対数の閉じた式 -(1/2) log(tanh K_2)」ではなく、
# 方程式 sinh(2K_2) sinh(2x) = 1 の解として二分法で数値的に求め、両者が一致することを見る。
# これにより s_2^* = 1/s_2 が「定義の書き換え」ではなく、
# 定義 K_2^* = -(1/2) log(tanh K_2) から実際に従うことを、閉じた式に依らずに確認できる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np

def crit_K1(K2):
    """臨界条件 sinh(2K_1) sinh(2K_2) = 1 をちょうど満たす K_1。"""
    return float(np.arcsinh(1.0/np.sinh(2*K2))/2.0)

def solve_K2star(K2):
    """sinh(2K_2) sinh(2x) = 1 を満たす x > 0 を二分法で求める（閉じた式を使わない）。

    x |-> sinh(2K_2) sinh(2x) - 1 は x > 0 で狭義単調増加なので、
    符号が変わる区間を倍々に広げて挟み、200 回の二分で幅を 2^-200 まで詰める。
    """
    s2 = float(np.sinh(2.0*K2))
    f = lambda x: s2*float(np.sinh(2.0*x)) - 1.0
    lo, hi = 1e-12, 1.0
    while f(hi) < 0.0:
        hi *= 2.0
        if hi > 1e6:
            raise RuntimeError("bracket not found for K2=%r" % K2)
    for _ in range(200):
        mid = 0.5*(lo + hi)
        if f(mid) < 0.0:
            lo = mid
        else:
            hi = mid
    return 0.5*(lo + hi)

# 一般のパラメータ・臨界点をちょうど踏む K_2・広めの range を混ぜる。
K2_LIST = sorted(set([p["K2"] for p in OP_TEST_PARAMS]
                     + [0.3, 0.4407, 0.6, 1.1]
                     + [0.05, 0.2, 0.7, 1.5, 3.0]))

rep = CheckReport("duality_c2_star_eq_s2_star_c2: K_2^* を二分法で解いて閉じた式と比較")
for K2 in K2_LIST:
    x = solve_K2star(K2)
    K2s = float(K_star(K2))
    c2, s2 = float(c_of(K2)), float(s_of(K2))
    rep.close(x, K2s, f"K2={K2}: 二分法の解 = -(1/2) log(tanh K_2)")
    rep.close(float(s_of(K2))*float(np.sinh(2*x)), 1.0,
              f"K2={K2}: 二分法の解が sinh(2K_2) sinh(2x) = 1 を満たす")
    rep.close(float(np.cosh(2*x)), c2/s2, f"K2={K2}: cosh(2x) = c_2/s_2")
    rep.close(float(np.sinh(2*x)), 1.0/s2, f"K2={K2}: sinh(2x) = 1/s_2")
    # 臨界条件を踏む K_1 のもとでは K_1 = K_2^*（自己双対）になることも見ておく。
    rep.close(crit_K1(K2), x, f"K2={K2}: 臨界条件を満たす K_1 = 二分法で解いた K_2^*")
rep.finish()
