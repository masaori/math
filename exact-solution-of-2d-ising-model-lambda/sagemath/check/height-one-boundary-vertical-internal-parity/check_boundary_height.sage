# 対象ラベル: claim_height_one_boundary_vertical_internal_parity
# 第一行: 縦内部辺の境界係数の支持と両側の二値高さの差。
from itertools import product

for below, above in product((ZZ(0), ZZ(1)), repeat=2):
    boundary = below - above
    assert (boundary != 0) == (below != above)

print("RESULT: PASS — 縦内部辺の境界係数と高さ差の四組")
