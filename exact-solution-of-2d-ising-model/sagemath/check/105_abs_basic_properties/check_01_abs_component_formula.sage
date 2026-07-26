# ---------------------------------------------------------
# <abs_basic_properties> (1)(2)(3)
#   (1) z=(x,y) について |z| = sqrt(x^2+y^2)^{(R_{>=0})}
#   (2) |z|^2 = x^2 + y^2
#   (3) |z| = 0 <=> z = 0_C
#
# 独立経路:
#   左辺 |z| は定義（<def_abs_arg>）どおり pr_1(phi_polar(z)) を、<def_phi_polar> の
#   6 通りの場合分けをそのまま写した素朴実装で計算する（_prelude.sage）。
#   右辺 sqrt(x^2+y^2) は組み込みの平方根を使わず二分法で構成する。
#   特に x=0 の 3 行は phi_polar が y / -y / 0 を返すので、
#   そこが sqrt(x^2+y^2) と一致することが本文 Step 1 の非自明な中身である。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '../100_cosh_sinh_basic_properties/_prelude.sage'))

RF400 = RealField(400)

def sqrt_nonneg_bisect(a):
    a = RF400(a)
    lo, hi = RF400(0), RF400(1) + a
    for _ in range(320):
        mid = (lo + hi) / 2
        if mid * mid <= a:
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2

rep = CheckReport("<abs_basic_properties> (1)(2)(3) 絶対値の成分表示と非退化性")

n_xzero = 0
for z in NAIVE_TEST_POINTS_ALL:
    x, y = RF400(SR(z[0])), RF400(SR(z[1]))
    lhs = RF400(SR(abs_naive(z)))              # pr_1(phi_polar(z))
    rhs = sqrt_nonneg_bisect(x**2 + y**2)      # 二分法で作った sqrt
    denom = float(max(RF400(1), rhs))
    rep.close(float(lhs) / denom, float(rhs) / denom, "(1) |z|=sqrt(x^2+y^2) @z=%s" % (z,))
    rep.truth(lhs >= 0, "(1) |z|>=0 @z=%s" % (z,))
    if sgn0(z[0]) == 0:
        n_xzero += 1
    # (2)
    rep.close(float(lhs**2 / denom**2), float((x**2 + y**2) / RF400(denom)**2),
              "(2) |z|^2=x^2+y^2 @z=%s" % (z,))
    # (3)
    rep.truth((sgn0(SR(abs_naive(z))) == 0) == (sgn0(z[0]) == 0 and sgn0(z[1]) == 0),
              "(3) |z|=0 <=> z=0 @z=%s" % (z,))

print("  走査した点: %d 個（うち x=0 の場合分けを踏むもの: %d 個）"
      % (len(NAIVE_TEST_POINTS_ALL), n_xzero))

rep.finish()
