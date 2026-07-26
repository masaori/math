# ---------------------------------------------------------
# <cos_arctan_sin_arctan> の前提となる定義の整合性
#   本文（<calc_formulae_014_definition_inverse_trig_functions>）は
#     arctan(x) := arcsin( x / sqrt(1+x^2)^{(R_{>=0})} )
#     cos(theta) := sqrt(1 - (sin theta)^2)^{(R_{>=0})}   (|theta| <= pi/2)
#   と定めている。check_01 では Sage の arctan / cos / sin を本文の定義の実装として
#   使っているので、その一致をここで確認する（一致しないと check_01 の左辺が
#   本文の左辺でなくなる）。
#
# さらに本文の証明の途中式
#   cos(arcsin(t)) = sqrt(1 - t^2),  sin(arcsin(t)) = t
# を独立に確認する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(300)
ITERS = 250

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

XS = [RF(v) for v in [
    0, 1/10**6, -1/10**6, 1/3, -1/3, 1/2, -1/2, 1, -1, 2, -2,
    4/3, -4/3, 10, -10, 100, -100, 10**6, -10**6,
]]
TS = [RF(v) for v in [
    0, 1/10**6, -1/10**6, 1/4, -1/4, 1/2, -1/2, 3/5, -3/5,
    9/10, -9/10, 1, -1,
]]

rep = CheckReport("<cos_arctan_sin_arctan> の土台: arctan の定義と arcsin の性質")

for x in XS:
    t = x / sqrt_nonneg_bisect(1 + x**2)
    rep.truth(-1 <= t <= 1, "x/sqrt(1+x^2) in [-1,1] @x=%s" % x)
    rep.close(float(RF(x).arctan()), float(RF(t).arcsin()),
              "arctan(x) = arcsin(x/sqrt(1+x^2)) @x=%s" % x)

for t in TS:
    a = RF(t).arcsin()
    rep.truth(-RF(pi) / 2 <= a <= RF(pi) / 2, "arcsin(t) in [-pi/2,pi/2] @t=%s" % t)
    rep.close(float(a.sin()), float(t), "sin(arcsin t) = t @t=%s" % t)
    # cos(theta) := sqrt(1 - sin^2 theta)（本文の定義）と Sage の cos の一致
    rep.close(float(a.cos()), float(sqrt_nonneg_bisect(1 - t**2)),
              "cos(arcsin t) = sqrt(1-t^2) @t=%s" % t)
    # arcsin の奇関数性（本文の定義は y'<0 側を -arcsin(-y') で定めている）
    rep.close(float(RF(-t).arcsin()), float(-a), "arcsin(-t) = -arcsin(t) @t=%s" % t)

rep.finish()
