# 対象ラベル: claim_fisher_zero_set_finite_card_bound
#
# 主張: L >= 1 について F_L は有限集合で |F_L| <= 2 L^2 である。
# L = 1, 2, 3 で F_L（Z_L の QQbar における相異なる根）を厳密に列挙して個数を数え、
# 有限で 2L^2 以下であること、および本文の背理法の終点である |S| = 2L^2+1 と |S| <= 2L^2 が
# 両立しないことを整数の厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def qbar_pow_rec(a, k):
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def ev_F(xi, f):
    # def_qbar_polynomial_evaluation
    n = f.degree() if f.degree() >= 0 else 0
    total = QQbar(0)
    for m in range(n + 1):
        total = total + QQbar(f[m]) * qbar_pow_rec(xi, m)
    return total


def check_claim():
    for L in range(1, 4):
        Z = partition_polynomial(L)
        n = 2 * L ** 2
        # F_L: 相異なる根を厳密に列挙（有限のリストとして得られる）
        F = Z.roots(QQbar, multiplicities=False)
        assert len(set(F)) == len(F)
        for xi in F:
            assert ev_F(xi, Z) == 0
        # 主張: |F_L| <= 2L^2
        assert len(F) <= n
        # 背理法の終点: |S| = 2L^2 + 1 かつ |S| <= 2L^2 は両立しない
        assert not (n + 1 <= n)
        print("  L=%d: |F_L|=%d は有限で 2L^2=%d 以下" % (L, len(F), n))
    print("claim_fisher_zero_set_finite_card_bound: すべて通過")


check_claim()
