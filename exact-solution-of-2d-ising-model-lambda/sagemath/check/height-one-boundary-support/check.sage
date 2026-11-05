# 対象ラベル: claim_height_one_boundary_support
# 両側の二値高さから作る境界係数の支持を整数で検算する。
from itertools import product

for left, right in product((ZZ(0), ZZ(1)), repeat=2):
    coefficient = left - right
    assert (coefficient != 0) == (left != right)
    assert coefficient in (ZZ(-1), ZZ(0), ZZ(1))
    if left == right:
        assert coefficient == 0

print("PASS: 二値高さの全四組で横辺・縦辺の境界係数を検算")
