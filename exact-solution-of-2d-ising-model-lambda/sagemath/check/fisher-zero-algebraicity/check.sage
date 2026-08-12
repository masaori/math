# 対象ラベル: def_qbar_polynomial_evaluation, def_finite_lattice_fisher_zeros,
# claim_fisher_zero_algebraicity
# ZZ[x] と QQbar による厳密計算だけを使う。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def check_fisher_zero_algebraicity():
    checked_roots = 0
    for L in range(1, 4):
        Z = partition_polynomial(L)
        assert Z(1) == 2 ** (L ** 2)
        assert Z != 0
        roots = Z.roots(QQbar, multiplicities=False)
        for xi in roots:
            assert QQbar(Z(xi)) == 0
            checked_roots += 1
    # L=1 だけでは根が無いので、検査自体が空になっていないことも確認する。
    assert checked_roots > 0
    print("claim_fisher_zero_algebraicity: %d 個の Fisher 零点ですべて通過" % checked_roots)


check_fisher_zero_algebraicity()
