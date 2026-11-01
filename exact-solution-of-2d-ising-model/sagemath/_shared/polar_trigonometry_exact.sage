# 共通: π の有理数倍の角度での cos・sin、ℂ の積、φ_cartesian・φ_polar・s_{[0,2π)}・√z を厳密に作る
# 極座標表現の類・代表元の積は sagemath/_shared/polar_representation.sage を使う。
# ここでは、角度を π の有理数倍 qπ（q ∈ QQ）に限り、cos・sin・φ_cartesian・φ_polar・s_{[0,2π)}・ℂ の積を厳密に作る。
# 浮動小数点と RR / CC への脱出はない。
#
# cos(qπ), sin(qπ) は 1 の冪根 e^{iqπ} = ζ_{2d}^{m}（q = m/d）の実部と虚部として QQbar で厳密に作る。
# 本文の def_sin・def_cos は主値区間 [-π/2, π/2] でしか定めていない（def_phi_cartesian が未完と書いている点）。
# ここで使う値は、その外では通常の cos・sin の値であり、本文が未整備の拡張を先取りしている。
load("../../_shared/polar_representation.sage")   # check/<対象名>/ から読む前提の相対パス

def q_of(t):
    """角度 t = qπ の q。t が π の有理数倍でなければ止める。"""
    assert is_angle(t) and t[0] == 0
    return QQ(t[1])

def cos_sin(t):
    q = q_of(t)
    m, d = q.numerator(), q.denominator()
    zeta = QQbar.zeta(2 * d) ^ (m % (2 * d))
    return AA(zeta.real()), AA(zeta.imag())

# ℂ の元は実部と虚部の対 (x, y) ∈ AA × AA で持つ（definition_of_cc の形）。
def cc_mul(z, w):
    """ℂ の積の定義: (x, y)·(x', y') = (xx' - yy', xy' + yx')。"""
    (x, y), (xp, yp) = z, w
    return (x * xp - y * yp, x * yp + y * xp)

def phi_cartesian(p):
    """def_phi_cartesian: [(r, θ)] ↦ (r cos θ, r sin θ)。代表元 p から計算する。"""
    rr, t = p
    c, s = cos_sin(t)
    return (AA(rr) * c, AA(rr) * s)

def n_of_section(t):
    """0 ≤ t - 2nπ < 2π を満たす n ∈ Z（angle_section_existence_uniqueness）。候補を総当たりし、ただ一つであることも確かめる。"""
    q = q_of(t)
    cands = [k for k in range(floor(q / 2) - 3, floor(q / 2) + 4) if 0 <= q - 2 * k < 2]
    assert len(cands) == 1
    return ZZ(cands[0])

def section(t):
    """section_of_angle_representation: s_{[0,2π)}([t]) = t - 2nπ。"""
    return t - 2 * n_of_section(t) * pi_

def sqrt_aa(x):
    """definition_of_sqrt_r_positive: y ≥ 0 かつ y^2 = x を満たすただ一つの y。"""
    y = AA(x).sqrt()
    assert y >= 0 and y ^ 2 == x
    return y

def phi_polar_equals(z, p):
    """def_phi_polar(z) = [p] を、arctan の値を作らずに厳密に判定する。
    x > 0 のとき φ_polar(z) = [(√(x²+y²), arctan(y/x) + c)]（c = 0）、x < 0 のとき c = ±π。
    arctan(t) = arcsin(t/√(1+t²))（def_arctan）であり、arcsin は [-1,1] → [-π/2,π/2] の全単射で sin がその逆写像
    （arcsin_is_bijection・def_sin）なので、α ∈ [-π/2, π/2] について arctan(t) = α ⟺ sin α = t/√(1+t²)。
    そこで p の角度から c と 2kπ を引いて [-π/2, π/2] に入る α を作り、sin α = t/√(1+t²) を確かめる。
    このとき φ_polar(z) = [(√(x²+y²), α + c)] で、α + c = θ_p - 2kπ だから類は [p] に一致する。"""
    x, y = z
    rr, t = p
    R = sqrt_aa(x ^ 2 + y ^ 2)
    if x == 0:
        if y > 0:
            return polar_equiv((y, pi_ / 2), p)
        if y < 0:
            return polar_equiv((-y, -pi_ / 2), p)
        return polar_equiv(ZERO, p)
    if R != rr:
        return False
    c = Ang(0) if x > 0 else (pi_ if y >= 0 else -pi_)
    q = q_of(t - c)
    ks = [k for k in range(floor(q / 2) - 2, floor(q / 2) + 3) if -QQ(1)/2 <= q - 2 * k <= QQ(1)/2]
    if len(ks) != 1:
        return False
    alpha = t - c - 2 * ks[0] * pi_
    tt = y / x
    return cos_sin(alpha)[1] == tt / sqrt_aa(1 + tt ^ 2)

def section_by_floor(t):
    """s_{[0,2π)}([t]) を n_of_section を通さずに求める: t = qπ のとき t - 2·⌊q/2⌋·π。"""
    q = q_of(t)
    return t - 2 * floor(q / 2) * pi_

def sqrt_cc_by_definition(z, p):
    """def_sqrt_cc: √z = φ_cartesian([(√(pr_1(φ_polar(z))), ½·s_{[0,2π)}(pr_2(φ_polar(z))))])。
    φ_polar(z) = [p] を確かめてから、pr_1 = p の半径、pr_2 は first_and_second_projections どおり
    半径が 0 なら [0]_angle、正なら [p の角度]_angle とする。s_{[0,2π)} は section_by_floor で求める。"""
    assert phi_polar_equals(z, p)
    rr, t = p
    t2 = Ang(0) if rr == 0 else t
    return phi_cartesian((sqrt_aa(rr), section_by_floor(t2) / 2))

