# 対象ラベル: riemann_sum_to_integral の検算の共通の準備（check_ で始まらないので単独では走らない）
#
# 数の表し方:
#   証明に現れる点 t は、すべて「有理数 q の π 倍」t = qπ である（区間の端 2π(μ-1)/M・2πμ/M、代表点 2π(μ-δ)/M、
#   δ ∈ QQ のとき）。点は有理数 q で持つ。
#   関数の値・積分・上限は、R = AA[p]（p は π を表す不定元）の元で持つ。π は代数的数でないので、
#   AA[p] の二つの元が等しいことと、p に π を代入した実数が等しいことは同値である（等号は厳密に判定できる）。
#   1/(2π) を含む値は R の分数体 RF の元で持つ。
#   大小は、差が RF で 0 なら等しい、0 でなければ p に π を入れた値を 256 ビットのボールで囲み、ボールが 0 を含まず
#   符号が決まることを確かめる（ボールの演算は丸めの誤差を半径に含むので、符号の判定は厳密である）。
#   π と cos(qπ) の値は R の外へ出ない（cos(qπ) は AA の元）。浮動小数点数は使わない。

R = PolynomialRing(AA, "p")
p = R.gen()          # π
RB = RealBallField(256)
PI_B = RB.pi()

RF = R.fraction_field()   # 1/(2π) を含む行（Step 5）のため。等号は分数体で厳密に判定する

def poly_ball(x):
    return sum(RB(c.interval_exact(RealIntervalField(300))) * PI_B ** i for i, c in enumerate(R(x).list()))

def to_ball(x):
    x = RF(x)
    return poly_ball(x.numerator()) / poly_ball(x.denominator())

def leq(a, b):
    """a ≤ b を厳密に判定する（判定できなければ例外）。"""
    d = RF(b) - RF(a)
    if d == 0:
        return True
    bd = to_ball(d)
    if bd > 0:
        return True
    if bd < 0:
        return False
    raise ValueError("符号を決められない")

def lt(a, b):
    return RF(a) != RF(b) and leq(a, b)

def rabs(x):
    return RF(x) if leq(0, x) else -RF(x)

def rmax(xs):
    m = xs[0]
    for x in xs[1:]:
        if leq(m, x):
            m = x
    return RF(m)

def pt(q):
    """有理数 q が表す点 qπ を R の元にする。"""
    return QQ(q) * p

# 1 の冪根から cos(qπ)・sin(qπ) を AA の元として作る（q ∈ QQ）
def cos_qpi(q):
    q = QQ(q); z = QQbar.zeta(2 * q.denominator()) ** q.numerator()
    return AA((z + z ** -1) / 2)

def sin_qpi(q):
    q = QQ(q); z = QQbar.zeta(2 * q.denominator()) ** q.numerator()
    return AA((z - z ** -1) / (2 * QQbar.gen()))

# 試験関数。どれも [0,2π] 上で区分的に単調で、
#   value(q)      = g(qπ)
#   prim(q)       = G(qπ)（G は原始関数。G' = g は記号微分で別に確かめる）
#   kinks         = 単調性が変わる点（q の集合）。|g(t) - c| の区間上の上限は端点かこれらの点で取られる
#   omega(qh)     = ω(qh·π)（証明の連続度。式は各関数の注記どおり。標本の点で上界であり、達成点があることを別に確かめる）
#   witness(qh)   = ω を達成する点の組 (qs, qt)（|s - t| ≤ h）
x_sym = var("x_sym")

class Square:
    name = "g(t) = t^2"
    sym = x_sym ** 2
    sym_prim = x_sym ** 3 / 3
    kinks = []
    def value(self, q): return pt(q) ** 2
    def prim(self, q): return pt(q) ** 3 / 3
    def omega(self, qh):
        # [0,2π] 上で単調増加なので、ω(h) = g(2π) - g(2π - h) = 4πh - h^2（h ≤ 2π）、h ≥ 2π なら 4π^2
        qh = min(QQ(qh), 2)
        return pt(2) ** 2 - pt(2 - qh) ** 2
    def witness(self, qh):
        qh = min(QQ(qh), 2)
        return (2 - qh, QQ(2))

class Cosine:
    name = "g(t) = cos t"
    sym = cos(x_sym)
    sym_prim = sin(x_sym)
    kinks = [QQ(0), QQ(1), QQ(2)]
    def value(self, q): return R(cos_qpi(q))
    def prim(self, q): return R(sin_qpi(q))
    def omega(self, qh):
        # |cos s - cos t| = 2|sin((s+t)/2)||sin((s-t)/2)| ≤ 2 sin(h/2)（h ≤ π）。s+t = π, s - t = h で達成
        qh = min(QQ(qh), 1)
        return R(2 * sin_qpi(qh / 2))
    def witness(self, qh):
        qh = min(QQ(qh), 1)
        return ((1 + qh) / 2, (1 - qh) / 2)

class AbsAroundPi:
    name = "g(t) = |t - π|"
    sym = abs(x_sym - pi)
    sym_prim = None   # 原始関数は区分的（下の prim）
    kinks = [QQ(0), QQ(1), QQ(2)]
    def value(self, q): return rabs(pt(q) - p)
    def prim(self, q):
        # G(t) = -(π - t)^2/2（t ≤ π）、(t - π)^2/2（t ≥ π）。G は連続で、両側で G' = g
        d = pt(q) - p
        return d ** 2 / 2 if leq(0, d) else -d ** 2 / 2
    def omega(self, qh):
        # ||s-π| - |t-π|| ≤ |s - t| ≤ h。s = π, t = π + h で達成（h ≤ π）
        qh = min(QQ(qh), 1)
        return pt(qh)
    def witness(self, qh):
        qh = min(QQ(qh), 1)
        return (QQ(1), 1 + qh)

TEST_FUNCTIONS = [Square(), Cosine(), AbsAroundPi()]

def integral(g, qa, qb):
    """∫_{qaπ}^{qbπ} g(t) dt = G(qbπ) - G(qaπ)（qa ≤ qb）。"""
    return g.prim(qb) - g.prim(qa)

def sup_dev_on(g, qa, qb, qc):
    """sup_{t ∈ [qaπ, qbπ]} |g(t) - g(qcπ)|。|g - 定数| は単調な部分ごとに端で最大になるので、端点と kinks で取る。"""
    cands = [qa, qb] + [k for k in g.kinks if qa <= k <= qb]
    c = g.value(qc)
    return rmax([rabs(g.value(k) - c) for k in cands])

# 原始関数を通さない、独立な積分の値: Sage の記号積分を 256 ビットのボールで評価する。
# 等号は原始関数による厳密な値で確かめ、こちらは原始関数の取り違えを捕まえるための照合に使う（半径 1e-60 未満で一致を見る）。
def sym_integral_ball(g, qa, qb, c_sym=0):
    """∫_{qaπ}^{qbπ} (g(t) - c) dt を記号積分してボールにする。c_sym は定数の記号式。|t - π| は π で分けて積分する。"""
    a, b = QQ(qa) * pi, QQ(qb) * pi
    if isinstance(g, AbsAroundPi):
        val = 0
        if qa < 1:
            val += integrate(pi - x_sym - c_sym, x_sym, a, min(QQ(qb), 1) * pi)
        if qb > 1:
            val += integrate(x_sym - pi - c_sym, x_sym, max(QQ(qa), 1) * pi, b)
    else:
        val = integrate(g.sym - c_sym, x_sym, a, b)
    return RB(val)

def matches_ball(exact, ball):
    d = to_ball(exact) - ball
    return d.contains_zero() and d.rad() < QQ(10) ** -60

def sym_value(g, q):
    """g(qπ) の記号式（定数）。"""
    if isinstance(g, AbsAroundPi):
        return abs(QQ(q) * pi - pi)
    return g.sym.subs(x_sym == QQ(q) * pi)
