# 対象ラベル: claim_height_one_boundary_vertical_internal_parity
# 第二行: 高さ差の順序を反転する。
from itertools import product

for below, above in product((ZZ(0), ZZ(1)), repeat=2):
    assert (below != above) == (above != below)

print("RESULT: PASS — 縦内部辺の高さ差の対称性の四組")
