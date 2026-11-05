# 対象ラベル: claim_height_one_boundary_horizontal_seam_parity
# 第二行: 切断線一歩の高さ差と横辺の通過偶奇。
from itertools import product

for last, parity in product((ZZ(0), ZZ(1)), repeat=2):
    first = (last + parity) % 2
    assert (first != last) == (parity == 1)

print("RESULT: PASS — 切断線一歩の二値高さと通過偶奇の四組")
