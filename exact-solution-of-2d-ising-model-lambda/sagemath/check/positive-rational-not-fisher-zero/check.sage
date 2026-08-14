# 対象ラベル: claim_positive_rational_not_fisher_zero
# ZZ[x]・QQ・QQbar の厳密計算だけを使う。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

SAMPLE_POINTS = [QQ(1)/2, QQ(1)/3, QQ(2)/5, QQ(3)/7, QQ(9)/10, QQ(1)/40,
                 QQ(1), QQ(3)/2, QQ(2), QQ(5), QQ(41)/40]


def check_positive_rational_not_fisher_zero():
    for L in range(1, 4):
        Z = partition_polynomial(L)

        # 式変形の第 1〜2 行: Ev^F_q(Z_L) = Σ_m Ω_L(m) q^m = Z_L(q)。
        # 係数表示による和（QQbar の演算）と QQ の代入値が同じ元であること。
        for q in SAMPLE_POINTS:
            assert q > 0
            coeff_sum_qbar = sum(QQbar(Z[m]) * QQbar(q) ** m
                                 for m in range(2 * L ** 2 + 1))
            value_in_QQ = Z(q)
            assert coeff_sum_qbar == QQbar(value_in_QQ)
            # 第 3 行: Z_L(q) ∈ Q_{>0}、したがって零でない。
            assert value_in_QQ in QQ
            assert value_in_QQ > 0
            assert QQbar(value_in_QQ) != QQbar(0)

        # 結論: Fisher 零点（QQbar の中の根）に正の有理数が 1 つも無いこと。
        roots = Z.roots(QQbar, multiplicities=False)
        for xi in roots:
            if xi.imag() == 0:
                real_part = xi.real()
                if real_part in QQ:
                    assert QQ(real_part) <= 0
        print("L=%d: 零点 %d 個に正の有理数なし、正の有理点 %d 個で値は正"
              % (L, len(roots), len(SAMPLE_POINTS)))


check_positive_rational_not_fisher_zero()
print("claim_positive_rational_not_fisher_zero: すべて通過")
