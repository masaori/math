# 対象ラベル: claim_fisher_zero_density_in_rational_disc_le_two
#
# 主張: L >= 1、c ∈ Q×Q、r ∈ Q_{>0} について ν_L(c,r) := N_L(c,r)/L^2 ∈ Q は 2 以下である。
# L = 1, 2 と有理円板 9 組で（L = 3 は AA の厳密比較が長すぎるので除く）、F_L（Z_L の QQbar における相異なる根）から N_L(c,r) を
# 厳密に数え、本文の一続きの鎖の各段
#   ν_L = N_L/L^2 <= |F_L|/L^2 <= 2L^2/L^2 = 2
# を QQ の厳密計算で確かめる。0 <= ν_L（定義ブロックの帰属）も見る。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)


def fisher_zeros(L):
    # def_finite_lattice_fisher_zeros のモデル: Z_L の QQbar における相異なる根の全体。
    return partition_polynomial(L).roots(QQbar, multiplicities=False)


def dsq2(xi, c):
    # def_rational_disc の dsq_2 のモデル（AA の元を厳密に返す）。
    a = xi.real()
    b = xi.imag()
    assert xi == QQbar(a) + QQbar(b) * OMEGA
    return (a - AA(c[0])) * (a - AA(c[0])) + (b - AA(c[1])) * (b - AA(c[1]))


def in_disc(xi, c, r):
    return dsq2(xi, c) < AA(r) * AA(r)


CENTERS = [(QQ(0), QQ(0)), (QQ(-1), QQ(0)), (QQ(1) / 2, QQ(1) / 3)]
RADII = [QQ(1) / 2, QQ(1), QQ(2)]


def check_claim():
    count = 0
    for L in range(1, 3):
        F = fisher_zeros(L)
        L2 = QQ(L ** 2)
        assert L2 > 0
        for c in CENTERS:
            dsqs = [dsq2(xi, c) for xi in F]      # 中心ごとに 1 回だけ厳密に計算する
            for r in RADII:
                N = ZZ(len([d for d in dsqs if d < AA(r) * AA(r)]))
                # def_fisher_zero_count_in_rational_disc: N_L <= |F_L|
                assert N <= len(F)
                nu = QQ(N) / L2                      # def_fisher_zero_density_in_rational_disc
                assert nu in QQ and nu >= 0
                # 鎖の各段
                assert nu == QQ(N) / L2
                assert QQ(N) / L2 <= QQ(len(F)) / L2
                assert QQ(len(F)) / L2 <= QQ(2 * L ** 2) / L2
                assert QQ(2 * L ** 2) / L2 == 2
                assert nu <= 2
                count += 1
        print("  L=%d: |F_L|=%d, 円板 %d 組で ν_L <= 2" % (L, len(F), len(CENTERS) * len(RADII)))
    print("claim_fisher_zero_density_in_rational_disc_le_two: %d 検査すべて通過" % count)


check_claim()
