# 対象ラベル: claim_height_one_boundary_horizontal_internal_parity
# 第一行: 横内部辺の境界係数の支持と両側の二値高さの差。
from itertools import product

for right, left in product((ZZ(0), ZZ(1)), repeat=2):
    boundary = right - left
    assert (boundary != 0) == (right != left)

print("RESULT: PASS — 境界係数と高さ差の四組")
