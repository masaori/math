# ---------------------------------------------------------
# <negative_number_to_sqrt>   x < 0 について  x = -sqrt((-x)^2)^{(R_{>=0})}
#
# 独立経路: 右辺の平方根を、組み込みの sqrt ではなく
# <sqrt_nonnegative_existence_uniqueness> の存在証明と同じ二分法
# （S = {s>=0 | s^2 <= a} の上限）で構成する。
# 左辺は与えた x そのものなので、突き合わせは同語反復にならない。
#
# 反例探索の方針: 主張は x<0 でのみ成立する。x>0 では
#   -sqrt((-x)^2) = -x != x
# となるはずなので、x>0 でも走査して「符号が効いていること」を確認する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(400)
ITERS = 350

def sqrt_nonneg_bisect(a):
    a = RF(a)
    lo, hi = RF(0), RF(1) + a
    for _ in range(ITERS):
        mid = (lo + hi) / 2
        if mid * mid <= a:
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2

NEGS = [RF(v) for v in [
    -1/10**8, -1/1000, -1/2, -1, -2, -3, -5, -10, -100, -12345,
    -10**6, -2*0.4407, -2*0.813, -5.4e8, -1.7,
]]

rep = CheckReport("<negative_number_to_sqrt> x<0 => x = -sqrt((-x)^2)")

for x in NEGS:
    rhs = -sqrt_nonneg_bisect((-x)**2)
    denom = max(RF(1), abs(x))
    rep.close(float(x / denom), float(rhs / denom), "x = -sqrt((-x)^2) @x=%s" % x)

# 仮定 x<0 が効いていること: x>0 では -sqrt((-x)^2) = -x != x
n_broken = 0
POSS = [-v for v in NEGS]
for x in POSS:
    rhs = -sqrt_nonneg_bisect((-x)**2)
    if abs(rhs - x) > RF(1e-30) * max(RF(1), abs(x)):
        n_broken += 1
rep.truth(n_broken == len(POSS),
          "x>0 では全 %d 例で x != -sqrt((-x)^2)（仮定 x<0 が効いている）" % len(POSS))

# ついでに: x>0 では x = +sqrt(x^2) であること
for x in POSS:
    rhs = sqrt_nonneg_bisect(x**2)
    denom = max(RF(1), abs(x))
    rep.close(float(x / denom), float(rhs / denom), "x>0: x = sqrt(x^2) @x=%s" % x)

rep.finish()
