# 対象ラベル: claim_height_one_boundary_horizontal_internal_parity
# 第二行: 内部一歩の高さ差と横辺の通過偶奇。
from itertools import product

for left, parity in product((ZZ(0), ZZ(1)), repeat=2):
    right = (left + parity) % 2
    assert (right != left) == (parity == 1)

print("RESULT: PASS — 内部一歩の二値高さと通過偶奇の四組")
