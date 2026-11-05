# 対象ラベル: claim_height_one_boundary_vertical_seam_parity
# 第二行: 高さ差の順序反転。
from itertools import product

for last, first in product((ZZ(0), ZZ(1)), repeat=2):
    assert (last != first) == (first != last)

print("RESULT: PASS — 高さ差の順序反転の四組")
