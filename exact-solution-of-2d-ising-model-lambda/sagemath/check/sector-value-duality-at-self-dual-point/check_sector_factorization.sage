# 対象ラベル: claim_sector_value_duality_at_algebraic_point
# 式ペア: H_L^{a,b}(xi) = (1+xi)^(2L^2) G_L^{a,b}(KW(xi))
# 帰属: QQbar
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

points = (QQbar(1) / 2, QQbar(2).sqrt() - 1, QQbar(-2).sqrt() + 2)
for L in (1, 2, 3):
    high, low = sector_polynomials(L)
    for xi in points:
        dual = (1 - xi) * (1 + xi) ** (-1)
        for sector in high:
            assert QQbar(high[sector](xi)) == (1 + xi) ** (2 * L * L) * QQbar(low[sector](dual))
print('RESULT: PASS')
