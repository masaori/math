# 対象ラベル: claim_self_dual_point_low_high_sector_correspondence
# 式ペア: KW(x_sd) = x_sd
# 帰属: QQbar
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

assert 1 + self_dual_point != 0
assert (1 - self_dual_point) * (1 + self_dual_point) ** (-1) == self_dual_point
print('RESULT: PASS')
