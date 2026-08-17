# 対象ラベル: claim_fisher_zero_set_nonempty
#
# 本文の各段を、ZZ[x] と QQbar の厳密計算で確認する。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def main():
    print("1. L=1 は例外で、Z_1=2 かつ Fisher 零点集合は空であること")
    Z1 = partition_polynomial(1)
    assert Z1 == 2
    assert Z1.roots(QQbar, multiplicities=False) == []
    print("   通過")

    print("2. L=2,3 では一スピンだけ反転した配位の破れボンド数が正で、その多重度も正であること")
    for L in [2, 3]:
        sigma = {v: (-1 if v == (0, 0) else 1) for v in vertices(L)}
        m = broken_bond_count(L, sigma)
        counts = multiplicity_vector(L)
        assert m >= 1
        assert counts[m] >= 1
        Z = partition_polynomial(L)
        assert Z[m] == counts[m]
        assert Z[m] != 0
    print("   通過")

    print("3. L=2,3 の分配多項式が QQbar に根を持ち、その根が Fisher 零点の定義を満たすこと")
    for L in [2, 3]:
        Z = partition_polynomial(L)
        roots = Z.roots(QQbar, multiplicities=False)
        assert len(roots) >= 1
        for xi in roots:
            assert QQbar(Z(xi)) == 0
    print("   通過")


main()
