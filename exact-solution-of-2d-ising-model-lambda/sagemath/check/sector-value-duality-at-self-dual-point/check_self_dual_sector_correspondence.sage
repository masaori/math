# 対象ラベル: claim_self_dual_point_low_high_sector_correspondence
# 式ペア: H_L^{a,b}(x_sd) = (1+x_sd)^(2L^2) G_L^{a,b}(x_sd)
# 帰属: QQbar
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for L in (1, 2, 3):
    high, low = sector_polynomials(L)
    for sector in high:
        assert QQbar(high[sector](self_dual_point)) == \
            (1 + self_dual_point) ** (2 * L * L) * QQbar(low[sector](self_dual_point))
print('RESULT: PASS')
