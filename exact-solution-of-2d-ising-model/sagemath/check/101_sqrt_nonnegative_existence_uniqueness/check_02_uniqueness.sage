# ---------------------------------------------------------
# <sqrt_nonnegative_existence_uniqueness>（一意性）
#   y_1, y_2 >= 0 かつ y_1^2 = y_2^2 ならば y_1 = y_2
#
# 有理数（厳密演算）で全 pair を走査する。丸めが入らないので同値性を厳密に判定できる。
# 反例探索の方針: 仮定「y >= 0」を外すと一意性は破れる（y と -y）。
# それも合わせて確認し、仮定が効いていることを示す。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

NONNEG = [QQ(v) for v in [
    0, 1/10**6, 1/1000, 1/7, 1/3, 1/2, 2/3, 1, 5/4, 3/2, 2, 7/3, 3, 5, 10,
    100, 1000, 10**6, 4407/10000, 813/1000, 17/10,
]]

rep = CheckReport("<sqrt_nonnegative_existence_uniqueness> 一意性（y_1,y_2>=0, y_1^2=y_2^2 => y_1=y_2）")

n_pairs = 0
for y1 in NONNEG:
    for y2 in NONNEG:
        n_pairs += 1
        if y1**2 == y2**2:
            rep.truth(y1 == y2, "y_1=%s, y_2=%s: y_1^2=y_2^2 => y_1=y_2" % (y1, y2))
print("  走査した pair: %d 組" % n_pairs)

# y=0 の場合（本文の場合分け x=0）: y^2=0 => y=0
for y in NONNEG:
    if y**2 == 0:
        rep.truth(y == 0, "y^2=0 => y=0 @y=%s" % y)

# 仮定 y>=0 を外すと破れること
n_broken = 0
for y in NONNEG:
    if y != 0 and (-y)**2 == y**2 and (-y) != y:
        n_broken += 1
rep.truth(n_broken == len([y for y in NONNEG if y != 0]),
          "仮定 y>=0 を外すと非零の全例で一意性が破れる（仮定が効いている）")

rep.finish()
