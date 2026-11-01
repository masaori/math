# 対象ラベル: arcsin_is_bijection
# 共通の準備。二通りの帰属で確かめる。
#
# (厳密) y を AA（実代数的数）に取る。AA は可算で、平方根・四則・等号・大小が厳密に決定できる。
#   定義 def_arcsin の点 P := (sqrt(1-y^2), y)、点の並び、弦の長さの二乗はこちらで扱う。
#
# (R への脱出) 弧の長さ l(AP) と π は実数で AA に収まらないので、RealBallField（値と誤差の上界の組。
#   丸めの誤差も包含に入る）で扱う。l(AP) は次の二つの折れ線で上下から挟む。
#   - 内接折れ線（弧の上の点を順に結ぶ弦）の長さ: 弧の長さは内接折れ線の長さの上限なので下界。
#   - 外接折れ線（隣り合う点での接線の交点を経る折れ線）の長さ: 弧が外接折れ線より長くないことは
#     外部文献の範囲の性質で、検算はこれを認めて上界に使う。
#   比べるときは区間の端点（区間演算で得た厳密な上界・下界）を使い、浮動小数点の値をそのまま比べない。
#   Sage が持つ標準の arcsin は使わない（本文の定義と一致することを前提にしないため）。

RB = RealBallField(256)

A_POINT = (AA(1), AA(0))

# [0,1] の具体の y。端点・有理数・無理数（sqrt(2)/2, sqrt(3)/2）・端点のごく近く（1 - 10^-6）を含む。
Y_NONNEG = sorted([AA(0), AA(1)/7, AA(1)/3, AA(1)/2, AA(3)/5, AA(2).sqrt()/2, AA(4)/5,
                   AA(3).sqrt()/2, AA(99)/100, 1 - AA(10)^-6, AA(1)])
# [-1,1] の具体の y。負の側は定義の第二の式 arcsin(y') := -arcsin(-y')（-1 <= y' < 0）で扱う。
Y_ALL = sorted(set([-y for y in Y_NONNEG] + Y_NONNEG))

N = 512   # 折れ線の辺の数

def point_P(y):
    """def_arcsin の第一の式の点 P := (sqrt(1-y^2), y)（0 <= y <= 1）を AA で作る。"""
    assert 0 <= y <= 1
    return ((1 - y^2).sqrt(), y)

def chord_sq(P, Q):
    """二点の距離の二乗（AA で厳密）。"""
    return (P[0] - Q[0])^2 + (P[1] - Q[1])^2

def _arc_vertices(y, n):
    """A から P := point_P(y) までの弧の上の n+1 点を RB で返す。

    t ↦ ((1-t^2)/(1+t^2), 2t/(1+t^2)) は t ∈ [0,1] で単位円の第一象限の弧を A（t=0）から (0,1)（t=1）へ
    単調に進む。t_P := y/(1+x_P) で P に着くので、t = k t_P / n（k = 0..n）に頂点を置く。
    n を 8 → 64 → 512 と増やすと、t の刻みは前の刻みの細分になる。
    """
    xP, yP = point_P(y)
    tP = RB(yP / (1 + xP))
    pts = []
    for k in range(n + 1):
        t = tP * k / n
        pts.append(((1 - t^2) / (1 + t^2), 2 * t / (1 + t^2)))
    return pts

def _dist(p, q):
    return ((p[0] - q[0])^2 + (p[1] - q[1])^2).sqrt()

def inscribed_length(y, n=N):
    """内接折れ線の長さ（l(AP) の下界）。"""
    pts = _arc_vertices(y, n)
    return sum((_dist(pts[k], pts[k + 1]) for k in range(n)), RB(0))

def circumscribed_length(y, n=N):
    """外接折れ線の長さ（l(AP) の上界）。

    単位円の点 p での接線は {v | v·p = 1}。隣り合う p, q（間の角が π 未満なので p·q > -1）の接線の交点は
    Q := (p + q)/(1 + p·q) で、折れ線 p → Q → q の長さを足す。
    """
    pts = _arc_vertices(y, n)
    total = RB(0)
    for k in range(n):
        p, q = pts[k], pts[k + 1]
        d = 1 + p[0] * q[0] + p[1] * q[1]
        Q = ((p[0] + q[0]) / d, (p[1] + q[1]) / d)
        total += _dist(p, Q) + _dist(Q, q)
    return total

def arcsin_enclosure(y, n=N):
    """def_arcsin の二つの式どおりに arcsin(y) を挟む厳密な下端と上端（実数の組）を返す。

    0 <= y <= 1 なら [内接, 外接]、-1 <= y < 0 なら -arcsin(-y) なので [-外接(-y), -内接(-y)]。
    """
    if y >= 0:
        return inscribed_length(y, n).lower(), circumscribed_length(y, n).upper()
    return -circumscribed_length(-y, n).upper(), -inscribed_length(-y, n).lower()
