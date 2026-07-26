# ---------------------------------------------------------
# <cos_arctan_sin_arctan>
#   cos(arctan x) = 1 / sqrt(1+x^2)^{(R_{>=0})}
#   sin(arctan x) = x / sqrt(1+x^2)^{(R_{>=0})}
#
# 独立経路:
#   左辺は arctan の値を求めてから cos / sin を評価する（角度を経由する経路）。
#   右辺は x から代数的に組み上げる（角度を経由しない経路）。平方根は組み込みを使わず
#   <sqrt_nonnegative_existence_uniqueness> の存在証明と同じ二分法で構成する。
#
# 本文の arctan / sin / cos は円弧の長さと arcsin の逆関数として定義域を
# [-pi/2, pi/2] に制限して定義されている（<calc_formulae_014...>）。Sage の
# arctan / sin / cos はその範囲で本文の定義と一致するので、左辺の評価に用いる。
# 一致していること自体も check_02 で確認する。
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
    0, 1/10**8, -1/10**8, 1/1000, -1/1000, 1/3, -1/3, 1/2, -1/2,
    1, -1, 2, -2, 3, -3, 4/3, -4/3, 10, -10, 100, -100, 10**6, -10**6,
    # phi_polar で実際に現れる y/x（テスト点由来）
    4/3, -4/3, 3/7*(-5/4), 1/100, -1/100,
]]

rep = CheckReport("<cos_arctan_sin_arctan> cos/sin(arctan x) の閉じた表示")

for x in XS:
    t = RF(x).arctan()
    lhs_c, lhs_s = t.cos(), t.sin()
    d = sqrt_nonneg_bisect(1 + x**2)
    rhs_c, rhs_s = 1 / d, x / d
    rep.close(float(lhs_c), float(rhs_c), "cos(arctan x) @x=%s" % x)
    rep.close(float(lhs_s), float(rhs_s), "sin(arctan x) @x=%s" % x)
    # 値域: arctan の値は [-pi/2, pi/2]
    rep.truth(-RF(pi) / 2 <= t <= RF(pi) / 2, "arctan x in [-pi/2,pi/2] @x=%s" % x)
    # Pythagoras: 閉じた表示が単位円上にあること
    rep.close(float(rhs_c**2 + rhs_s**2), 1.0, "cos^2+sin^2=1（閉じた表示）@x=%s" % x)

rep.finish()
