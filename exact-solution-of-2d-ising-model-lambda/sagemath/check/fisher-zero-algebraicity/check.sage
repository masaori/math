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
        coefficient_sum = sum(ZZ(a) for a in Z.list())
        assert Z(1) == coefficient_sum
        assert coefficient_sum == sum(multiplicity_vector(L))
        roots_with_multiplicities = Z.roots(QQbar)
        roots = [xi for xi, multiplicity in roots_with_multiplicities]
        assert len(set(roots)) == len(roots)
        assert all(multiplicity > 0 for xi, multiplicity in roots_with_multiplicities)
        assert sum(multiplicity for xi, multiplicity in roots_with_multiplicities) == Z.degree()
        # 相異なる根の重複度が正確で、合計が次数なら、根の取り落としは無い。
        # 形式微分は ZZ[x] の係数操作であり、解析的な微分ではない。
        for xi, multiplicity in roots_with_multiplicities:
            derivative = Z
            for order in range(multiplicity):
                assert QQbar(derivative(xi)) == 0
                derivative = derivative.derivative()
            assert QQbar(derivative(xi)) != 0
        for xi in roots:
            value_from_coefficients = sum((QQbar(a) * xi ** m for m, a in enumerate(Z.list())), QQbar(0))
            assert value_from_coefficients == QQbar(Z(xi))
            assert value_from_coefficients == 0
            checked_roots += 1
    # L=1 だけでは根が無いので、検査自体が空になっていないことも確認する。
    assert checked_roots > 0
    print("claim_fisher_zero_algebraicity: %d 個の Fisher 零点ですべて通過" % checked_roots)


check_fisher_zero_algebraicity()
