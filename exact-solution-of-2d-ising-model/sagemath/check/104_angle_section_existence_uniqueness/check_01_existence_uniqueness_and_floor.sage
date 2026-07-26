# ---------------------------------------------------------
# <angle_section_existence_uniqueness>
#   theta in R について 0 <= theta - 2 n pi < 2 pi なる n in Z がただ一つ存在する。
#
# 検証の方法（独立経路）:
#   存在・一意性: floor を使わず、整数 n を十分広い窓で走査して
#     「条件 0 <= theta-2n pi < 2pi を満たす n」の個数を数える。ちょうど 1 個であること。
#   floor との一致: 別途 n' = floor(theta / 2pi) を計算し、走査で見つけた n と一致すること。
#   （走査は条件の直接評価、floor は別の計算経路なので、両者の一致は非自明な確認になる。）
#
# 境界: theta = 2 k pi ちょうど（n = k、theta-2n pi = 0）と
#       theta = 2 k pi - eps（n = k-1、theta-2n pi が 2pi の直下）を必ず含める。
#       境界の判定は 300 bit の実数演算で行い、|v| < 2^-150 を厳密な 0 とみなす。
#       theta は pi の有理数倍または有理数なので、非零な v がこの閾値を下回ることはない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(300)
EPS0 = RF(2) ** (-150)

def sgn0(v):
    r = RF(SR(v))
    if abs(r) < EPS0:
        return 0
    return 1 if r > 0 else -1

def floor_tol(t):
    """floor。ただし t が整数から 2^-100 以内なら、その整数とみなす。
    theta = 2 k pi ちょうどのとき t = k を 300 bit 演算では厳密に表せないため
    （k pi の丸めで t = k - 2^-297 などになりうる）、この補正が要る。"""
    r = Integer(t.round())
    if abs(t - r) < RF(2) ** (-100):
        return r
    return Integer(t.floor())


def count_valid_n(theta, width=6):
    """0 <= theta - 2 n pi < 2 pi を満たす整数 n を窓の中で全部集める。"""
    theta = SR(theta)
    center = floor_tol(RF(theta) / RF(2 * pi))
    out = []
    for n in range(center - width, center + width + 1):
        v = theta - 2 * n * pi
        if sgn0(v) >= 0 and sgn0(v - 2 * pi) < 0:
            out.append(Integer(n))
    return out

# theta の候補: pi の有理数倍（境界 2 k pi ちょうどを含む）と有理数
THETAS = []
for k in [-3, -2, -1, 0, 1, 2, 3, 10, -10]:
    THETAS.append(SR(2 * k) * pi)                       # 境界ちょうど（v=0）
    THETAS.append(SR(2 * k) * pi + SR(pi) / 2)
    THETAS.append(SR(2 * k) * pi + pi)
    THETAS.append(SR(2 * k) * pi + SR(3) / 2 * pi)
    THETAS.append(SR(2 * k) * pi - SR(pi) / 10**6)      # 2 pi の直下（v が 2pi 近傍）
    THETAS.append(SR(2 * k) * pi + SR(pi) / 10**6)      # 0 の直上
for q in [0, 1, -1, QQ(1)/3, -QQ(1)/3, 7, -7, 1000, -1000, QQ(22)/7, -QQ(355)/113]:
    THETAS.append(SR(q))
# 本プロジェクトで実際に現れる theta_mu = 2 pi mu / M
for M in [2, 3, 4, 5, 8]:
    for mu in range(-2 * M, 2 * M + 1):
        THETAS.append(SR(2 * mu) * pi / M)

rep = CheckReport("<angle_section_existence_uniqueness> 0<=theta-2n pi<2pi なる n の存在と一意性")

n_boundary = 0
for theta in THETAS:
    ns = count_valid_n(theta)
    ok = rep.truth(len(ns) == 1, "n はちょうど 1 個 (theta=%s, 見つかった n=%s)" % (theta, ns))
    if not ok:
        continue
    n = ns[0]
    v = theta - 2 * n * pi
    rep.truth(sgn0(v) >= 0, "0 <= theta-2n pi (theta=%s)" % theta)
    rep.truth(sgn0(v - 2 * pi) < 0, "theta-2n pi < 2pi (theta=%s)" % theta)
    if sgn0(v) == 0:
        n_boundary += 1
    # floor との一致
    n_floor = floor_tol(RF(theta) / RF(2 * pi))
    rep.truth(n == n_floor,
              "n = floor(theta/2pi) (theta=%s, n=%s, floor=%s)" % (theta, n, n_floor))

print("  走査した theta: %d 個、うち theta-2n pi = 0 ちょうど（境界）: %d 個"
      % (len(THETAS), n_boundary))

rep.finish()
