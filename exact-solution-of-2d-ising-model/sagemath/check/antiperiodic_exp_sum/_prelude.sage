# 対象ラベル: antiperiodic_exp_sum
# 共通の準備。
#
# 厳密に持つもの:
# - 自然数・整数・実数の像は、Sage の ZZ と QQ（ℝ の有理数の部分）で持つ。包含 ι_{N→Z}, ι_{Z→R} は
#   ZZ(n)・QQ(a) で、零・単位元・和・積・順序を保つ。
# - 指数の中の実数は、この証明では常に 2π × 有理数 の形である。そこで、実数 2πq（q ∈ QQ）を有理数 q で持ち、
#   exp(i(2πq)_C) を 1 の冪根 ζ_d^m（q = m/d）として UniversalCyclotomicField（UCF。代数的数の可算な部分体で、
#   等号は厳密に決定できる）で持つ（関数 E）。E(q) が本文の exp の値と一致することは、check_claim_ball.sage で
#   本文の exp の部分和と尾の上界のボールに入ることとして確かめる（ℝ への脱出はそこだけ）。
# - π そのものが式に現れる行（k_R θ̃_μ の鎖）は、π を不定元 pi_ に置いた QQ 上の有理関数体で持つ。
#   不定元で成り立つ有理式の等号は、π を代入しても成り立つ。
UCF = UniversalCyclotomicField()


def E(q):
    """exp(i(2πq)_C)（q ∈ QQ）を 1 の冪根 ζ_d^m（q = m/d、既約分数）で表す。"""
    q = QQ(q)
    return UCF.zeta(q.denominator()) ** q.numerator()


def to_C(a):
    """整数 a の像 a_C := (a_R)_C。"""
    return UCF(QQ(ZZ(a)))


def delta(N, mu, nu):
    """def_delta_M: δ^{N}_{(μ,ν)} は μ ≡ ν (mod N) なら 1、そうでなければ 0（ℂ の元）。N ∈ N_{≥1}。"""
    assert N >= 1
    return UCF(1) if (ZZ(mu) - ZZ(nu)) % N == 0 else UCF(0)


def minus_one_power(l):
    """(-1_C)^l（l ∈ Z）を本文の言葉どおり、非負の指数では積、負の指数では逆元の積として作る。"""
    m1 = UCF(-1)
    out = UCF(1)
    if l >= 0:
        for _ in range(l):
            out = out * m1
    else:
        inv = UCF(1) / m1
        for _ in range(-l):
            out = out * inv
    return out


def theta_tilde_over_2pi(M, mu):
    """θ̃_μ / (2π) = (μ_R - 1/2) / (M_col)_R（θ̃_μ の定義の式から 2π を外した有理数）。"""
    return (QQ(mu) - QQ(1) / 2) / QQ(M)


def S_claim_form(M, k):
    """主張の左辺 Σ_{μ=1}^{M} exp(i(k_R θ̃_{μ_Z})_C) を、θ̃ の定義の式のまま作る。"""
    return sum(E(QQ(k) * theta_tilde_over_2pi(M, mu)) for mu in range(1, M + 1))


def T(N, k):
    """T_{N,k} := Σ_{r=1}^{N} exp(i(2π r_R k_R / N_R)_C)。"""
    assert N >= 1
    return sum(E(QQ(r) * QQ(k) / QQ(N)) for r in range(1, N + 1))


M_RANGE = range(2, 9)


def K_RANGE(M):
    return range(-3 * M, 3 * M + 1)
