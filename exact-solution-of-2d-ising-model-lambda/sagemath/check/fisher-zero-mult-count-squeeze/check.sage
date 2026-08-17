# 対象ラベル: claim_fisher_zero_count_le_mult_count, claim_fisher_zero_mult_count_le_edge_bound
#
# 主張: L >= 1、c ∈ Q×Q、r ∈ Q_{>0} について
#   N_L(c,r) <= N^mult_L(c,r) <= 2 L^2
# である。N^mult は円板内の各零点の重複度（Ẑ_L^F の根としての重複度）の有限和。
# L = 1, 2 と有理円板 9 組で、F_L（Z_L の QQbar における相異なる根）から N_L と N^mult_L を
# 厳密に数え、本文の鎖の各段（各項が 1 以上であること、和の単調性、係数の上界からの和の上界）を
# QQbar・ZZ の厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)
Rt.<t> = PolynomialRing(QQbar)


def lift_F(f):
    # def_integer_polynomial_qbar_lift
    n = f.degree() if f.degree() >= 0 else 0
    return sum(QQbar(f[k]) * t ** k for k in range(0, n + 1))


def mult(xi, g):
    # def_qbar_root_multiplicity: (t - xi)^k で割り切れる k の最大元。
    assert g != Rt.zero()
    k = 0
    q = g
    while True:
        quo, rem = q.quo_rem(t - Rt(xi))
        if rem != Rt.zero():
            return k
        k += 1
        q = quo


def fisher_zeros(L):
    # def_finite_lattice_fisher_zeros のモデル: Z_L の QQbar における相異なる根の全体。
    return partition_polynomial(L).roots(QQbar, multiplicities=False)


def dsq2(xi, c):
    a = xi.real()
    b = xi.imag()
    assert xi == QQbar(a) + QQbar(b) * OMEGA
    return (a - AA(c[0])) * (a - AA(c[0])) + (b - AA(c[1])) * (b - AA(c[1]))


CENTERS = [(QQ(0), QQ(0)), (QQ(-1), QQ(0)), (QQ(1) / 2, QQ(1) / 3)]
RADII = [QQ(1) / 2, QQ(1), QQ(2)]


def main():
    print("1. 円板内の各零点の重複度は 1 以上である（準備）")
    for L in range(1, 3):
        Z = partition_polynomial(L)
        lift = lift_F(Z)
        assert lift != Rt.zero()
        for xi in fisher_zeros(L):
            # aev_ξ(Ẑ_L^F) = Ev^F_ξ(Z_L) = 0
            assert lift(xi) == QQbar(0)
            assert mult(xi, lift) >= 1
    print("   通過")

    print("2. N_L(c,r) <= N^mult_L(c,r)（各項 1 以上と有限和の単調性）")
    print("3. N^mult_L(c,r) <= 2 L^2（係数の上界 2L^2 からの和の上界）")
    for L in range(1, 3):
        Z = partition_polynomial(L)
        lift = lift_F(Z)
        top = 2 * L * L
        for k in range(top + 1, top + 4):
            assert lift[k] == QQbar(0)
        F = fisher_zeros(L)
        mults = {xi: mult(xi, lift) for xi in F}
        for c in CENTERS:
            dsqs = {xi: dsq2(xi, c) for xi in F}
            for r in RADII:
                inside = [xi for xi in F if dsqs[xi] < AA(r) * AA(r)]
                N = ZZ(len(inside))
                Nmult = ZZ(sum(mults[xi] for xi in inside))
                assert all(mults[xi] >= 1 for xi in inside)
                assert N <= Nmult
                assert Nmult <= ZZ(top)
                # 密度の上界も同じ 2 であること
                assert QQ(N) / QQ(L ** 2) <= QQ(2)
                assert QQ(Nmult) / QQ(L ** 2) <= QQ(2)
    print("   通過（2 と 3 をまとめて確認した）")

    print("4. 円板を全体に取ると N^mult は Ẑ_L^F の全重複度の和で、やはり 2L^2 以下")
    for L in range(1, 3):
        lift = lift_F(partition_polynomial(L))
        total = ZZ(sum(mult(xi, lift) for xi in fisher_zeros(L)))
        assert total <= ZZ(2 * L * L)
    print("   通過")


main()
