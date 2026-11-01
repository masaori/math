# 共通: 極座標表現 (R_{>=0} × R)/~ の元を厳密に扱う準備
#   角度表現の同値類（angle_equivalence_class）、極座標表現の同値類（polar_equivalence_class）、
#   極座標表現の演算（operations_on_polar_representation）の代表元どうしの積。
# 浮動小数点と RR / CC への脱出はない。
#
# (一般の点) 半径・角度・整数 n, n'・π を QQ 上の不定元とする多項式環 Rpoly とその有理関数体 Fr。
#   等号の行は、両辺を別々の式から作り、多項式（有理関数）として一致することで確かめる。
# (具体の点) 半径は AA（実代数的数）の非負の元、角度は a + b·π（a, b ∈ QQ）の形の実数に取る。
#   π は無理数なので、a + b·π = a' + b'·π（a, b, a', b' ∈ QQ）と (a, b) = (a', b') は同値である。よって角度を
#   QQ 上の一変数多項式環 Ang の一次以下の元として持てば、角度の等号・和・差・符号反転が厳密に計算でき、
#   角度の同値 θ ~angle θ' ⟺ ∃ n ∈ Z, θ - θ' = 2nπ も「θ - θ' の定数項が 0 で、π の係数の半分が整数」として厳密に判定できる。

Rpoly.<r, r1, r2, r3, rp, rt, rtp, th, th1, th2, th3, thp, tht, thtp, n, np, PI> = PolynomialRing(QQ)
Fr = Rpoly.fraction_field()

Ang.<pi_> = PolynomialRing(QQ)   # 角度 a + b·π を a + b·pi_ と持つ

def is_angle(t):
    return t.parent() is Ang and t.degree() <= 1

def angle_equiv(t, tp):
    """角度表現の同値類: ∃ n ∈ Z, t - tp = 2nπ。差の定数項が 0 で、π の係数 c について c/2 ∈ Z となることと同値。"""
    assert is_angle(t) and is_angle(tp)
    d = t - tp
    return d[0] == 0 and (d[1] / 2) in ZZ

def angle_witness(t, tp):
    """t - tp = 2nπ を満たす n（angle_equiv が真のときだけ呼ぶ）。"""
    d = t - tp
    nn = ZZ(d[1] / 2)
    assert d == 2 * nn * pi_
    return nn

def is_pair(p):
    """p が R_{>=0} × R の元（の、ここで扱う形のもの）であること。"""
    rr, t = p
    return rr in AA and AA(rr) >= 0 and is_angle(t)

def polar_equiv(p, q):
    """極座標表現の同値類: (r,θ) ~ (r',θ') ⟺ r = r' = 0 ∨ (r = r' ∧ θ ~angle θ')。類の等号はこの判定で確かめる。"""
    assert is_pair(p) and is_pair(q)
    (a, t), (b, tp) = p, q
    return (a == 0 and b == 0) or (a == b and angle_equiv(t, tp))

def mul_rep(p, q):
    """極座標表現の演算の右辺の代表元: (r,θ), (r',θ') ↦ (rr', θ+θ')。"""
    (a, t), (b, tp) = p, q
    return (AA(a) * AA(b), t + tp)

E = (AA(1), Ang(0))          # 単位元 e := [(1,0)]
ZERO = (AA(0), Ang(0))       # [(0,0)]

# 具体の代表元。零の半径・有理数・無理数の半径、π の有理数倍と有理数の角度を含む。
SAMPLE = [
    (AA(0), Ang(0)), (AA(0), Ang(3)/7 + 5*pi_), (AA(1), Ang(0)), (AA(1), pi_),
    (AA(2), Ang(1)/3 - pi_/4), (AA(1)/5, -Ang(2) + 3*pi_), (AA(2).sqrt(), pi_/2),
    (AA(3).nth_root(3), Ang(-7)), (AA(10)^6, Ang(1)/2 + 11*pi_/6),
]
NONZERO = [p for p in SAMPLE if p[0] != 0]

def other_reps(p):
    """p と同値な別の代表元を作る。半径が正なら角度へ 2nπ を足し、半径が零なら角度を任意に替える。"""
    a, t = p
    if a == 0:
        return [(AA(0), t + Ang(1)/2), (AA(0), -t - 3*pi_ + 4)]
    return [(a, t + 2*k*pi_) for k in (-3, 1, 5)]
