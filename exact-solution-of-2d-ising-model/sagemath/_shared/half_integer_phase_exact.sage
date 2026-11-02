# 共通: 半整数運動量 θ̃_μ の位相 exp(-i(xθ̃_μ)_C) と、全実数上の cos・sin の値を、厳密に作る。
#
# 厳密に持つもの:
# - 整数と有理数は ZZ・QQ。θ̃_μ := 2π(μ_R - 1/2)/(M_col)_R（antiperiodic_exp_sum）は π の有理数倍なので、
#   実数 2πq（q ∈ QQ）を有理数 q で持つ（theta_over_2pi）。
# - exp(i(2πq)_C) を 1 の冪根 ζ_d^m（q = m/d）として QQbar で持つ（E）。
# - 全実数上の cos(2πq)・sin(2πq) は E(q) の実部・虚部として AA で持つ（cos2pi・sin2pi）。本文の def_sin・def_cos は
#   [-π/2, π/2] でしか定めておらず、全実数への拡張は未整備（euler_formula_cos_sin の前置き）なので、ここで使う値は
#   通常の cos・sin の値であり、本文が未整備の拡張を先取りしている。この表し方は Euler の公式を前提にしているので、
#   cos・sin の値と本文の exp の値を結ぶ行は、別に Arb の cos・sin（arb_cos2pi など）と本文の exp のボール
#   （body_exp_i_ball）でも確かめる。
# - π が式に現れる角度の鎖は、π を不定元 pi_ に置いた QQ 上の有理関数体で持つ（ANGLE_FIELD）。
#
# ℝ への脱出: RB・CB（512 bit の Arb のボール）。π は RB.pi()（区間として π を厳密に含む）。

ANGLE_FIELD = FractionField(PolynomialRing(QQ, ['pi_', 'mu', 'M', 'j']))
pi_, mu_, M_, j_ = ANGLE_FIELD.gens()


def theta_tilde_formula(mu, M):
    """θ̃_μ の定義の式 2π(μ_R - 1/2)/(M_col)_R を、μ・M を有理関数体の元のまま組む。"""
    return 2 * pi_ * (mu - QQ(1) / 2) / M


def theta_over_2pi(M, mu):
    """θ̃_μ/(2π) = (μ_R - 1/2)/(M_col)_R ∈ QQ。"""
    return (QQ(mu) - QQ(1) / 2) / QQ(M)


def E(q):
    """exp(i(2πq)_C)（q ∈ QQ）を 1 の冪根で表す QQbar の元。"""
    q = QQ(q)
    return QQbar.zeta(q.denominator()) ** (q.numerator() % q.denominator())


def cos2pi(q):
    """全実数上の cos(2πq)（AA）。"""
    return AA(E(q).real())


def sin2pi(q):
    """全実数上の sin(2πq)（AA）。"""
    return AA(E(q).imag())


I_QQBAR = QQbar(I)


def to_C(r):
    """inclusion_rr_to_cc: r ↦ r_C。AA の元を QQbar へ送る。"""
    return QQbar(r)


RB = RealBallField(512)
CB = ComplexBallField(512)
PI = RB.pi()


def arb_cos2pi(q):
    """Arb の cos(2πq) のボール（E を経ない独立の計算）。"""
    return (2 * PI * RB(QQ(q))).cos()


def arb_sin2pi(q):
    return (2 * PI * RB(QQ(q))).sin()


def body_exp_i_ball(xb, N=None):
    """本文の exp（def_scalar_exp。部分和の極限）の値 exp(i(x)_C) を、x を囲む実数のボールから
    部分和 Σ_{p=0}^{N} (ix)^p/p! を冪を右から 1 つずつ掛けて組み、尾 Σ_{p>N} r^p/p! ≤ 2r^{N+1}/(N+1)!
    （N + 2 ≥ 2r、r は |x| の上界）を半径に足したボールで囲む。N = 4⌈r⌉ + 60。"""
    xb = RB(xb)
    r = xb.abs().upper()
    if N is None:
        N = 4 * ceil(r) + 60
    assert N + 2 >= 2 * r
    z = CB(0, 1) * CB(xb)
    S = CB(0)
    power = CB(1)
    for p in range(N + 1):
        S = S + power / factorial(p)
        power = power * z
    tail = 2 * RB(r) ** (N + 1) / factorial(N + 1)
    out = S.add_error(tail.upper())
    assert RR(out.rad()) < RR(2) ** -100
    return out


def qqbar_ball(z):
    return CB(QQbar(z))


def check_adjacent(lines, label):
    """lines = [(名前, 値), ...] の隣り合う値が厳密に等しいことを確かめる。"""
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        assert v0 == v1, f"{label}: {n0} ≠ {n1}"
