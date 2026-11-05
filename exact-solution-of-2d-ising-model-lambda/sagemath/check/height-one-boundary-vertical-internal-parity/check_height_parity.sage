# 対象ラベル: claim_height_one_boundary_vertical_internal_parity
# 第三行: 閉歩道の縦内部一歩の高さ差と通過偶奇。
from itertools import product

for below, parity in product((ZZ(0), ZZ(1)), repeat=2):
    above = (below + parity) % 2
    assert (above != below) == (parity == 1)

print("RESULT: PASS — 縦内部一歩の二値高さと通過偶奇の四組")
