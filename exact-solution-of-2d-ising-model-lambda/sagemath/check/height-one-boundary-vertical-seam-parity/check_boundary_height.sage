# 対象ラベル: claim_height_one_boundary_vertical_seam_parity
# 第一行: 境界係数の支持と両側の二値高さの差。
from itertools import product

for last, first in product((ZZ(0), ZZ(1)), repeat=2):
    boundary = last - first
    assert (boundary != 0) == (last != first)

print("RESULT: PASS — 境界係数と高さ差の四組")
