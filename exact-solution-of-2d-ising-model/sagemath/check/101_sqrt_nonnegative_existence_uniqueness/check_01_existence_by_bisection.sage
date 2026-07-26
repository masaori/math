# ---------------------------------------------------------
# <sqrt_nonnegative_existence_uniqueness>（存在）
#
# 本文の存在証明は S = {s >= 0 | s^2 <= x} の上限 y := sup S が y^2 = x を満たす、
# という上限性質による構成である。ここでは同じ上限を**二分法**で近似的に構成し、
# 得られた y が y^2 = x を満たすことを確認する。
#
# 独立経路: Sage / numpy の組み込み平方根を一切使わず、
#   区間 [lo, hi] を「mid^2 <= x か否か」だけで半分に詰める
# という、証明中の S の定義そのものだけから y を作る。
# 比較対象の x は与えた値なので、y^2 と x の突き合わせは同語反復にならない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(400)
ITERS = 350   # 区間幅は 2^-350 倍まで詰まる

def sup_S_by_bisection(x):
    """S = {s>=0 | s^2 <= x} の上限を二分法で構成する。
    本文の証明のとおり 1+x は S の上界なので、初期区間を [0, 1+x] に取る。"""
    x = RF(x)
    lo, hi = RF(0), RF(1) + x
    for _ in range(ITERS):
        mid = (lo + hi) / 2
        if mid * mid <= x:      # mid in S
            lo = mid
        else:                   # mid は S の上界
            hi = mid
    return (lo + hi) / 2

XS = [RF(v) for v in [
    0, 1/10**8, 1/10**4, 1/100, 1/4, 1/3, 1/2, 1, 2, 3, 4, 5, 10,
    100, 12345, 10**6, 10**12,
    # 臨界点近傍の結合定数まわりで実際に現れる大きさ
    (2*0.4407)**2, 1 + (2*0.4407)**2, 2.7182818284590452,
    # cosh(2*10.4) ~ 5.4e8 の自乗（本プロジェクトで最大級の値）
    (5.4e8)**2,
]]

rep = CheckReport("<sqrt_nonnegative_existence_uniqueness> 存在（二分法で構成した y が y^2=x）")

for x in XS:
    y = sup_S_by_bisection(x)
    rep.truth(y >= 0, "y>=0 @x=%s" % x)
    # 相対誤差で比較（x が 1e17 規模になるため）
    denom = max(RF(1), x)
    rep.close(float((y * y) / denom), float(x / denom), "y^2 = x @x=%s" % x)

# 上界の主張 1+x が実際に S の上界であること（本文の補助主張）も確認する
for x in XS:
    s = RF(1) + x
    rep.truth(s * s > x, "1+x は S の上界（(1+x)^2 > x）@x=%s" % x)

rep.finish()
