# ---------------------------------------------------------
# <cosh_sinh_basic_properties> (4)  a, b in R_{>0} について a^2 = b^2 <=> a = b
#
# 有理数（厳密演算）で全 pair を走査する。丸めが入らないので同値性を厳密に判定できる。
# 反例探索の方針:
#   - a != b なのに a^2 = b^2 になる正の pair があれば FAIL（乗法性の破れ）。
#   - 仮定「a,b > 0」を外すと主張が破れることも確認する（a>0, b=-a は a^2=b^2 だが a != b）。
#     これを確認しないと、仮定が効いているかを検証したことにならない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

POSITIVES = [QQ(v) for v in [
    1/10**6, 1/1000, 1/7, 1/3, 1/2, 2/3, 1, 5/4, 3/2, 2, 7/3, 3, 5, 10,
    100, 1000, 10**6, 4407/10000, 813/1000, 17/10,
]]

rep = CheckReport("<cosh_sinh_basic_properties> (4) a,b>0: a^2=b^2 <=> a=b")

n_eq_sq = 0
for a in POSITIVES:
    for b in POSITIVES:
        eq_sq = (a**2 == b**2)
        eq = (a == b)
        if eq_sq:
            n_eq_sq += 1
        rep.truth(eq_sq == eq, "a=%s, b=%s: (a^2=b^2) == (a=b)" % (a, b))

print("  a^2=b^2 となった pair: %d 組（すべて a=b のはず、pair 総数 %d）"
      % (n_eq_sq, len(POSITIVES)**2))

# 仮定 a,b>0 を外した場合: b = -a では a^2=b^2 だが a != b
n_broken = 0
for a in POSITIVES:
    b = -a
    if (a**2 == b**2) and (a != b):
        n_broken += 1
rep.truth(n_broken == len(POSITIVES),
          "仮定 a,b>0 を外すと全 %d 例で主張が破れる（仮定が効いている）" % len(POSITIVES))

rep.finish()
