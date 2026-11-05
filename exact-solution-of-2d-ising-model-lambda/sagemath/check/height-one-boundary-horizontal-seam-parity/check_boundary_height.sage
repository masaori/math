# 対象ラベル: claim_height_one_boundary_horizontal_seam_parity
# 第一行: 横切断線上の境界係数の支持と両側の二値高さの差。
from itertools import product

for first, last in product((ZZ(0), ZZ(1)), repeat=2):
    boundary = first - last
    assert (boundary != 0) == (first != last)

print("RESULT: PASS — 境界係数と高さ差の四組")
