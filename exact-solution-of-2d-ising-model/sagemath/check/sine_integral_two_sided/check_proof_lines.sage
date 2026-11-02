# 対象ラベル: sine_integral_two_sided
# 証明の記号: θ ∈ [0, π]、p := θ/2、s := sin p、D1 := √(δ²+p²)、D2 := √(δ²+s²)、c := c0 = 1 - π²/24。
# 確かめる行:
# - 準備: 0 ≤ c p ≤ s、δ² ≤ D1²、δ² ≤ D2²、0 < δ ≤ D1, D2。
# - 各点の大小: s² の鎖（3 行）、D2² の鎖（3 行）、D2 ≤ D1、1/D1 の鎖（3 行）。
# - 下からの評価の鎖（4 行）。
# - 差の各点評価の準備: p - s の鎖（3 行）、0 ≤ p + s ≤ 2p、p ≤ D1、(c p)² の鎖（5 行）、c p ≤ D2、分母の鎖（4 行）。
# - 差の各点評価の鎖（12 行）と p = 0 の場合。F' = θ。積分の鎖（5 行）。上からの評価の鎖（7 行）。
# 帰属:
# - 等号の行と、不等号の各行の「右辺 - 左辺」を非負の因子の積に分けた式は、δ, p, s, c, D1, D2, π を不定元とした
#   有理関数体 QQ(δ, p, s, c, D1, D2, π) で厳密に。D1² = δ²+p²、D2² = δ²+s² を使う行は、その関係式の生成する
#   イデアルを法として多項式環で厳密に。
# - 各点の大小は、θ = 2qπ（p = qπ、q は [0, 1/2] を 12 等分した点）で s = sin(qπ) を AA で厳密に作り（共通の準備
#   sine_cosine_by_definition.sage）、p・π・c0 は Arb のボールで囲んで比べる（π が QQ・AA に入らないための ℝ への脱出）。
# - 積分の行と主張は、δ ∈ QQ_{>0} の点で Arb の厳密な数値積分のボールで確かめる（共通の準備 log_integral_by_balls.sage）。
#   被積分関数の sin は Arb の sin（標準の正弦）で、本文の sin と一致することを格子点の AA の値で確かめる
#   （remark_real_analysis_facts_R3_R4 が前提にしている一致の点検であり、一致そのものの証明ではない）。
load("../../_shared/log_integral_by_balls.sage")
load("../../_shared/sine_cosine_by_definition.sage")

# ---- 等号と、不等号の差の因数分解（QQ(δ, p, s, c, D1, D2, π)） ----
K = PolynomialRing(QQ, 'dl,p,s,c,D1,D2,pv,th').fraction_field()
dl, p, s, c, D1, D2, pv, th = K.gens()
den = D1*D2*(D1 + D2)
# s² の鎖: s·p - s·s = s(p - s) ≥ 0、p·p - s·p = p(p - s) ≥ 0
assert s^2 == s*s and s*p - s*s == s*(p - s) and p*p - s*p == p*(p - s) and p*p == p^2
# 1/D1 の鎖
assert 1/D1 == D2 * (1/(D1*D2)) and D1*(1/(D1*D2)) - D2*(1/(D1*D2)) == (D1 - D2)/(D1*D2) and D1*(1/(D1*D2)) == 1/D2
# p - s の鎖の 3 行目: θ = 2p のとき θ³/48 = p³/6
assert (2*p)^3/48 == p^3/6
# 0 ≤ p + s ≤ 2p: 2p - (p + s) = p - s
assert (p + p) - (p + s) == p - s and p + p == 2*p
# (c p)² の鎖: c p·s - c p·c p = c p (s - c p)、s·s - c p·s = s(s - c p)、(δ²+s²) - s² = δ²
assert (c*p)^2 == c*p*c*p and c*p*s - c*p*c*p == c*p*(s - c*p) and s*s - c*p*s == s*(s - c*p) and (dl^2 + s^2) - s*s == dl^2
# 分母の鎖
assert den - p*D2*(D1 + D2) == (D1 - p)*D2*(D1 + D2)
assert p*D2*(D1 + D2) - p*c*p*(D1 + D2) == (D2 - c*p)*p*(D1 + D2)
assert p*c*p*(D1 + D2) - p*c*p*(p + c*p) == ((D1 - p) + (D2 - c*p))*p*c*p
assert p*c*p*(p + c*p) == c*(1 + c)*p^3
# 準備の p² = θ²/4（D1 = √(δ²+θ²/4) の根拠）
assert (th/2)^2 == th^2/4
# 分母の逆数の評価: 1/den = (c(1+c)p³/den)(1/(c(1+c)p³))、差は (den - c(1+c)p³)/(den·c(1+c)p³) ≥ 0、den/den·(1/(c(1+c)p³)) = 1/(c(1+c)p³)
m = c*(1 + c)*p^3
assert 1/den == (m/den)*(1/m) and (den/den)*(1/m) - (m/den)*(1/m) == (den - m)/(den*m) and (den/den)*(1/m) == 1/m
print("各点の大小・準備・分母の鎖・分母の逆数の評価の等号と差の因数分解が有理関数体で成り立つ")
# 差の各点評価の鎖
l0 = 1/D2 - 1/D1
l1 = (D1 - D2)/(D1*D2)
l2 = (D1 - D2)*(D1 + D2)/den
l3 = (D1^2 - D2^2)/den
l4 = ((dl^2 + p^2) - (dl^2 + s^2))/den
l5 = (p^2 - s^2)/den
l6 = (p - s)*(p + s)/den
l7 = (p^3/6)*(p + s)/den
l8 = (p^3/6)*(2*p)/den
l9 = (p^4/3)*(1/den)
l10 = (p^4/3)*(1/(c*(1 + c)*p^3))
l11 = p/(3*c*(1 + c))
l12 = th/(6*c*(1 + c))
assert l0 == l1 == l2 == l3                                                           # 1〜3 行目
assert l4 == l5 == l6                                                                 # 5・6 行目
assert l7 - l6 == (p^3/6 - (p - s)) * ((p + s)/den)                                   # 7 行目: (p³/6 - (p - s)) ≥ 0 と (p+s)/den ≥ 0
assert l8 - l7 == (2*p - (p + s)) * ((p^3/6)/den)                                     # 8 行目: (2p - (p+s)) ≥ 0 と (p³/6)/den ≥ 0
assert l9 == l8                                                                       # 9 行目
assert l10 - l9 == (p^4/3) * (den - c*(1 + c)*p^3) / (den * c*(1 + c)*p^3)           # 10 行目: 分母の鎖の差 ≥ 0
assert l11 == l10                                                                     # 11 行目
assert l12.subs(th=2*p) == l11                                                        # 12 行目
# 4 行目は D1² = δ²+p²、D2² = δ²+s² を使う。分子の差がイデアルに入ることで見る。
Rp.<Dl, P, S, E1, E2> = QQ[]
I = Rp.ideal([E1^2 - Dl^2 - P^2, E2^2 - Dl^2 - S^2])
assert (E1^2 - E2^2) - ((Dl^2 + P^2) - (Dl^2 + S^2)) in I                             # 4 行目
assert E2^2 - (Dl^2 + S^2) in I and E1^2 - (Dl^2 + P^2) in I                          # D2² の鎖の 1・3 行目
print("差の各点評価の鎖の 12 行が有理関数体（4 行目は D1²・D2² の関係式のイデアル）で成り立つ")
# F(θ) = θ²/2 の導関数と、積分の鎖・上からの評価の鎖の等号（π を不定元 pv に）
Rt.<t> = QQ[]
assert (t^2/2).derivative(t) == QQ(1)/2*(1*t + t*1) == t
assert 1/(6*c*(1 + c)) * (pv^2/2 - 0^2/2) == pv^2/(12*c*(1 + c))                     # 積分の鎖の 3・4 行目
assert 1/D2 == 1/D1 + (1/D2 - 1/D1)                                                   # 上からの評価の 2 行目
print("F' = θ と積分の鎖の 3〜5 行目、上からの評価の 2 行目が成り立つ")

# ---- 各点の大小（θ = 2qπ、s を AA で厳密に、p・π・c0 をボールで） ----
c0b = 1 - PI_BALL^2/24
assert (c0b - QQ(5887)/10000).lower() >= 0 and c0b.lower() > 0
DS = [QQ(1)/100, QQ(1)/10, QQ(1), QQ(3)]
n_pt = 0
for d0 in DS:
    for q in HALF_GRID:
        s_ex = sin_exact(q)
        if q == 0:
            # p = 0 の場合: s = sin 0 = 0 = p、D2 = D1、差は 0 = θ/(6c0(1+c0))（θ = 0）
            assert s_ex == 0
            D1e = sqrt_nonneg(AA(d0)^2 + 0); D2e = sqrt_nonneg(AA(d0)^2 + s_ex^2)
            assert D1e == D2e and 1/D2e - 1/D1e == 0
            continue
        pb = angle_ball(q); sb = ball(s_ex)
        D1b = (d0^2 + pb^2).sqrt(); D2b = (d0^2 + sb^2).sqrt()
        # 準備
        assert surely_ge(c0b*pb, 0) and surely_ge(sb, c0b*pb) and surely_ge(pb, sb)
        assert surely_ge(D1b^2, RBF256(d0)^2) and surely_ge(D2b^2, RBF256(d0)^2)
        assert surely_ge(D1b, RBF256(d0)) and surely_ge(D2b, RBF256(d0))
        # 各点の大小
        assert surely_ge(sb*pb, sb*sb) and surely_ge(pb*pb, sb*pb)
        assert surely_ge(d0^2 + pb^2, d0^2 + sb^2) and surely_ge(D1b, D2b)
        assert surely_ge(D1b*(1/(D1b*D2b)), D2b*(1/(D1b*D2b))) and surely_ge(1/D2b, 1/D1b)
        # 差の各点評価の準備
        assert surely_ge(pb^3/6, pb - sb)
        assert surely_ge(pb + sb, 0) and surely_ge(2*pb, pb + sb)
        assert surely_ge(D1b, pb)
        cp = c0b*pb
        assert surely_ge(cp*sb, cp*cp) and surely_ge(sb*sb, cp*sb) and surely_ge(d0^2 + sb^2, sb*sb) and surely_ge(D2b, cp)
        db = D1b*D2b*(D1b + D2b)
        chain_den = [db, pb*D2b*(D1b + D2b), pb*cp*(D1b + D2b), pb*cp*(pb + cp)]
        for a_, b_ in zip(chain_den, chain_den[1:]):
            assert surely_ge(a_, b_)
        assert surely_ge(D1b + D2b, pb + cp)                                            # p + c0p ≤ D1 + D2
        assert surely_gt(c0b*(1 + c0b)*pb^3, 0)
        assert surely_ge(1/(c0b*(1 + c0b)*pb^3), 1/db)                                   # 分母の逆数の評価
        # 差の各点評価の鎖の大小（7・8・10 行目）と結論
        v6 = (pb - sb)*(pb + sb)/db; v7 = (pb^3/6)*(pb + sb)/db; v8 = (pb^3/6)*(2*pb)/db
        v10 = (pb^4/3)/(c0b*(1 + c0b)*pb^3)
        assert surely_ge(v7, v6) and surely_ge(v8, v7) and surely_ge(v10, v8)
        assert surely_ge(2*pb/(6*c0b*(1 + c0b)), 1/D2b - 1/D1b) and surely_ge(1/D2b - 1/D1b, 0)
        # Arb の sin（積分で使う）が本文の sin（AA の値）を囲むこと
        assert (pb.sin() - sb).contains_zero()
        n_pt += 1
print(f"{n_pt} 個の (δ, θ) の点で、準備・各点の大小・差の各点評価の鎖の不等号と結論がボールで確定する（θ = 0 は AA で厳密に）")

# ---- 積分の行と主張（Arb の厳密な数値積分） ----
def f2(d0):
    return lambda th_, an: 1 / (CBF256(d0^2) + (th_/2).sin()^2).sqrt(analytic=an)
def f1(d0):
    return lambda th_, an: 1 / (CBF256(d0^2) + th_^2/4).sqrt(analytic=an)
pi_b = RBF512.pi()
c0B = 1 - pi_b^2/24
B = pi_b^2/(12*c0B*(1 + c0B))
Ith = integral_over_zero_pi(lambda th_, an: th_)
assert surely_equal(Ith, pi_b^2/2 - 0)                                                 # (R4) を F に
for d0 in DS:
    I2 = integral_over_zero_pi(f2(d0)); I1 = integral_over_zero_pi(f1(d0))
    Id = integral_over_zero_pi(lambda th_, an, d0=d0: f2(d0)(th_, an) - f1(d0)(th_, an))
    lg = 2*(pi_b/d0).log()
    # 下からの評価
    assert surely_le(I1, I2) and surely_le(lg, I1)
    # 積分の鎖
    Ilin = integral_over_zero_pi(lambda th_, an: th_/(6*CBF256(c0B)*(1 + CBF256(c0B))))
    assert surely_le(Id, Ilin)                                                         # 1 行目
    assert surely_equal(Ilin, Ith/(6*c0B*(1 + c0B)))                                   # 2 行目（(R3) の線型性）
    assert surely_equal(Ith/(6*c0B*(1 + c0B)), pi_b^2/(12*c0B*(1 + c0B))) and surely_equal(pi_b^2/(12*c0B*(1 + c0B)), B)
    # 上からの評価
    assert surely_equal(I2, I1 + Id)                                                   # 3 行目（(R3) の線型性）
    up = lg + 2*d0^2/pi_b^2
    assert surely_le(I1 + Id, up + Id) and surely_le(up + Id, up + B)
    assert surely_le(lg, I2) and surely_le(I2, up + B)                                 # 主張
print(f"{len(DS)} 点の δ で、下からの評価・積分の鎖・上からの評価の各行と主張がボールで確定する")
d0 = QQ(1)/100
I2 = integral_over_zero_pi(f2(d0))
assert surely_lt(2*(pi_b/d0).log() + 2*d0^2/pi_b^2, I2)
print("対照: B を落とした 2 log(π/δ) + 2δ²/π² は上界にならない（δ = 1/100）")
print("RESULT: PASS")
