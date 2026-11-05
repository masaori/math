# 対象ラベル: second_derivative_log_divergence
# ℝ への脱出を含む行（積分・実対数・初等関数の値・π）を、ボール（RealBallField(256)）と Arb の数値積分で確かめる。
# - 「有理数の四則・大小比較」の行: QQ で厳密に（浮動小数点なし）。
# - cosh・sinh の値は本文の exp の部分和に尾の評価を半径として足したボール（body_real_exp_ball）から作る。
#   log・π・平方根・sin は Arb のもの（本文の log は exp の逆写像、sin は弧の長さで定めた arcsin の逆で、標準のものに等しい）。
# - 積分は ComplexBallField(256).integral（被積分関数は実軸の近傍で解析的。S ≥ δ^2 > 0 なので平方根の分岐に触れない）。
#   (R3)〜(R6) を当てた行は、行の両辺の積分を別々に計算して、等号はボールの重なり（差の半径 < 2^{-100}）、
#   不等号はボールの確かな大小で判定する（判定の決まりは sagemath/_shared/isotropic_balls.sage）。
# - (R5)（微分と積分の交換）だけは、積分の値と差分商を比べるので許容誤差を置く（下の DIFF_TOL の注を見よ）。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/isotropic_balls.sage")
CB = ComplexBallField(PREC)
def le(x, y):              # x ≤ y が確かに成り立つ、または両辺が等しい
    return bool(RB(x) <= RB(y)) or is_zero(RB(x) - RB(y)) is True
def dec(s):
    i, f = s.split('.')
    return QQ(Integer(i + f)) / 10^len(f)
PI = RB.pi()

# ---- 数値の評価（remark_real_analysis_escape_chapter_E が持ち込むもの）と pi_squared_numerical_bounds
c4, s4, c2 = bcosh(QQ(1)/4), bsinh(QQ(1)/4), bcosh(QQ(1)/2)
check("数値の評価 sinh(1/4) ≤ 0.2527", s4 <= dec('0.2527'))
check("数値の評価 cosh(1/4) ≤ 1.0315", c4 <= dec('1.0315'))
check("数値の評価 log cosh(1/4) ≤ 0.0310", c4.log() <= dec('0.0310'))
check("数値の評価 cosh(1/2) ≤ 1.1277", c2 <= dec('1.1277'))
check("数値の評価 0.6931 ≤ log 2 ≤ 0.6932", dec('0.6931') <= RB(2).log() and RB(2).log() <= dec('0.6932'))
check("数値の評価 log(2π) ≤ 1.8380", (2 * PI).log() <= dec('1.8380'))
check("remark_real_analysis_facts_R3_R4 の 3.141592 ≤ π ≤ 3.141593", dec('3.141592') <= PI and PI <= dec('3.141593'))
check("数値の評価の段（QQ）: 3.141593 ≤ 3.1416、2·3.141592 = 6.283184 ≥ 6.2831", dec('3.141593') <= dec('3.1416') and 2 * dec('3.141592') == dec('6.283184') and dec('6.283184') >= dec('6.2831'))
check("数値の評価の段: log 1 = log 1 + log 1 より log 1 = 0、2π > 1 より log(2π) > 0", is_zero(RB(1).log()) is True and RB(2 * PI) > 1 and (2 * PI).log() > 0)
check("pi_squared_numerical_bounds: 9.8696 ≤ π^2", dec('9.8696') <= PI^2)
c0 = 1 - PI^2 / 24                                          # def_sine_bound_constant
B = PI^2 / (12 * c0 * (1 + c0))                             # def_sine_integral_constant
check("sine_bound_constant_numerical_bounds: c_0 ≥ 0.5887", dec('0.5887') <= c0)
check("sine_integral_constant_numerical_bound: B ≤ 0.88", B <= dec('0.88'))
check("対照: sinh(1/4) ≤ 0.2526 は成り立たない", not (s4 <= dec('0.2526')))
check("対照: cosh(1/4) ≤ 1.0314 は成り立たない", not (c4 <= dec('1.0314')))
check("対照: log 2 ≤ 0.6931 は成り立たない", not (RB(2).log() <= dec('0.6931')))
check("対照: π ≤ 3.14159 は成り立たない", not (PI <= dec('3.14159')))

# ---- 有理数の四則・大小比較の行（QQ で厳密に）
check("Step 4: 2·0.2527^2/9.8696 ≤ 0.0130", 2 * dec('0.2527')^2 / dec('9.8696') <= dec('0.0130'))
check("Step 4: (3.1416/2)·1.0315 ≤ 1.6203", dec('3.1416') / 2 * dec('1.0315') <= dec('1.6203'))
check("Step 4: max{0.0130 + 0.88, 1.6203} ≤ 1.621", max(dec('0.0130') + dec('0.88'), dec('1.6203')) <= dec('1.621'))
check("Step 5: 2·1.0315^2/0.5887 ≤ 3.615", 2 * dec('1.0315')^2 / dec('0.5887') <= dec('3.615'))
check("対照 Step 5: 2·1.0315^2/0.5887 ≤ 3.614 は成り立たない", not (2 * dec('1.0315')^2 / dec('0.5887') <= dec('3.614')))
check("Step 6: 2·((1/2)·1.0315)^2 ≤ 0.532（κ^2 の係数。cosh(1/4) ≤ 1.0315 を使う）", 2 * (dec('1.0315') / 2)^2 <= dec('0.532'))
check("Step 6: −2·(−0.6931) − 1 = 0.3862 > 0", -2 * (-dec('0.6931')) - 1 == dec('0.3862') and dec('0.3862') > 0)
check("Step 6: (1/4)·0.6932 ≤ 0.1733", dec('0.6932') / 4 <= dec('0.1733'))
check("Step 6: 0.532·0.1733 ≤ 0.093", dec('0.532') * dec('0.1733') <= dec('0.093'))
check("Step 6: 1.1277·(1.8380 + 0.0310) ≤ 2.108", dec('1.1277') * (dec('1.8380') + dec('0.0310')) <= dec('2.108'))
check("Step 6: 0.093 + 2.108 = 2.201", dec('0.093') + dec('2.108') == dec('2.201'))
check("Step 7: (1.1277/2)·1.621 ≤ 0.915", dec('1.1277') / 2 * dec('1.621') <= dec('0.915'))
check("Step 7: 2.201 + 0.915 + 3.615 = 6.731", dec('2.201') + dec('0.915') + dec('3.615') == dec('6.731'))
check("Step 7: 6.731/6.2831 ≤ 1.08 ≤ 6/5", dec('6.731') / dec('6.2831') <= dec('1.08') and dec('1.08') <= QQ(6)/5)

# ---- 被積分関数（θ は複素のボール z。実軸の近傍で解析的）
def integrands(kap):
    d = bsinh(kap / 2); chh = bcosh(kap / 2); shk = bsinh(kap); chk = bcosh(kap)
    dC, chkC, shkC = CB(d), CB(chk), CB(shk)
    def parts(z, an):
        S = dC^2 + (z / 2).sin()^2
        r = S.sqrt(analytic=an); t = (1 + S).sqrt(analytic=an)
        return S, r, t
    def gam(z, an):                    # γ = 2 arcsinh(r) = 2 log(r + √(r^2+1))（def_arcsinh）
        S, r, t = parts(z, an)
        return 2 * (r + t).log(analytic=an)
    def dgam(z, an):                   # gamma_derivatives_in_kappa (2): sinh κ/sinh γ、sinh γ = 2rt
        S, r, t = parts(z, an)
        return shkC / (2 * r * t)
    def d2gam(z, an):                  # cosh κ/sinh γ − sinh^2κ cosh γ/sinh^3γ（γ の定義から sinh γ・cosh γ を作る）
        S, r, t = parts(z, an)
        x = r + t
        shg = (x^2 - x^(-2)) / 2; chg = (x^2 + x^(-2)) / 2
        return chkC / shg - shkC^2 * chg / shg^3
    return dict(d=d, chh=chh, shk=shk, chk=chk, parts=parts, gam=gam, dgam=dgam, d2gam=d2gam, dC=dC, shkC=shkC, chkC=chkC)
def integ(f, a, b):
    return CB.integral(f, a, b).real()
def G(kap):
    return integ(integrands(kap)['gam'], 0, 2 * CB.pi()) / (4 * PI)
def G1(kap):
    return integ(integrands(kap)['dgam'], 0, 2 * CB.pi()) / (4 * PI)
def G2(kap):
    return integ(integrands(kap)['d2gam'], 0, 2 * CB.pi()) / (4 * PI)

# (R5) の行の確かめ: G' と G'' の積分の値を、G と G' の中心差分商 (F(κ+h) − F(κ−h))/(2h)（h = κ/100）と比べる。
# 差分商の誤差は h^2 |F'''|/6 程度で、ここで選ぶ κ では 10^{-5} を下回る（F = G で G''' ~ 1/(2πκ)、F = G' で ~ 1/(2πκ^2)。
# h = κ/100 なので h^2/κ^2 = 10^{-4}）。DIFF_TOL はこの見積もりに余裕を持たせた値で、証明の行の判定ではなく
# 「積分記号下の微分で得た値が G の導関数に一致する」ことの数値の裏付けである。
DIFF_TOL = RB(10)^(-3)
KAPS = [QQ(1)/2, QQ(2)/5, QQ(1)/4, QQ(1)/10, QQ(1)/50, QQ(1)/500]
for kap in KAPS:
    tag = f"κ={kap}"
    V = integrands(kap)
    d, chh, shk, chk = V['d'], V['chh'], V['shk'], V['chk']
    parts = V['parts']
    # Step 0
    check(f"Step 0: 0 < δ ≤ sinh(1/4) ≤ 0.2527 [{tag}]", RB(0) < d and le(d, s4) and le(s4, dec('0.2527')))
    # Step 1
    g1 = G1(kap)
    h = kap / 100
    check(f"Step 1 (R5): G' の積分と G の差分商の差 ≤ 10^-3 [{tag}]", ((G(kap + h) - G(kap - h)) / (2 * h) - g1).abs() <= DIFF_TOL)
    absint = integ(lambda z, an: V['dgam'](z, an), 0, 2 * CB.pi())     # κ > 0 で ∂γ/∂κ > 0 なので |·| はそのまま
    check(f"Step 1: ∂γ/∂κ > 0（θ = 0, π/2, π） [{tag}]", all(RB(V['dgam'](CB(th), False).real()) > 0 for th in [0, PI / 2, PI]))
    check(f"Step 1: |G'| ≤ (1/4π)∫|∂γ/∂κ| ≤ (1/4π)∫1 = 1/2 [{tag}]",
          le(g1.abs(), absint / (4 * PI)) and le(absint / (4 * PI), 2 * PI / (4 * PI)))
    eq(2 * PI / (4 * PI), QQ(1)/2, f"Step 1: (1/4π)·2π = 1/2 [{tag}]")
    # Step 1・Step 2: G''
    g2 = G2(kap)
    check(f"Step 1 (R5): G'' の積分と G' の差分商の差 ≤ 10^-3 [{tag}]", ((G1(kap + h) - G1(kap - h)) / (2 * h) - g2).abs() <= DIFF_TOL)
    I0pi = integ(V['d2gam'], 0, CB.pi()); Ipi2pi = integ(V['d2gam'], CB.pi(), 2 * CB.pi())
    eq(Ipi2pi, I0pi, f"Step 2 (R6): ∫_π^{{2π}} ∂²γ = ∫_0^π ∂²γ [{tag}]")
    eq(g2, (I0pi + Ipi2pi) / (4 * PI), f"Step 2 (R3): 区間の分割 [{tag}]")
    eq(g2, I0pi / (2 * PI), f"Step 2: G'' = (1/2π)∫_0^π ∂²γ [{tag}]")
    # Step 3
    def f_J(z, an):
        S, r, t = parts(z, an); return 1 / (r * t)
    def f_T(z, an):
        S, r, t = parts(z, an)
        x = r + t; shg = (x^2 - x^(-2)) / 2; chg = (x^2 + x^(-2)) / 2
        return V['shkC']^2 * chg / shg^3
    J = integ(f_J, 0, CB.pi()); T = integ(f_T, 0, CB.pi())
    eq(I0pi, chk / 2 * J - T, f"Step 3: ∫_0^π ∂²γ = (cosh κ/2)J − T [{tag}]")
    # Step 4
    def f_I0(z, an):
        S, r, t = parts(z, an); return 1 / r
    I0 = integ(f_I0, 0, CB.pi())
    Dlt = integ(lambda z, an: f_I0(z, an) - f_J(z, an), 0, CB.pi())
    check(f"Step 4: 0 ≤ ∫(1/r − 1/(rt)) [{tag}]", RB(0) <= Dlt)
    eq(Dlt, I0 - J, f"Step 4 (R3): ∫(1/r − 1/(rt)) = ∫1/r − J [{tag}]")
    Ich = integ(lambda z, an: CB(chh) / 2, 0, CB.pi())
    check(f"Step 4: ∫1/r − J ≤ ∫cosh(κ/2)/2 [{tag}]", le(Dlt, Ich))
    eq(Ich, PI / 2 * chh, f"Step 4 (R4): ∫cosh(κ/2)/2 = (π/2)cosh(κ/2) [{tag}]")
    Lpd = (PI / d).log()
    R0 = I0 - 2 * Lpd
    check(f"Step 4 (sine_integral_two_sided): 0 ≤ R_0 ≤ 2δ^2/π^2 + B [{tag}]", RB(0) <= R0 and le(R0, 2 * d^2 / PI^2 + B))
    R = J - 2 * Lpd
    eq(R, R0 - (I0 - J), f"Step 4: R = R_0 − (∫1/r − J) [{tag}]")
    check(f"Step 4: R ≥ −(∫1/r − J) ≥ −(π/2)cosh(κ/2) [{tag}]", le(-(I0 - J), R) and le(-PI / 2 * chh, -(I0 - J)))
    check(f"Step 4: R ≤ R_0 ≤ 2δ^2/π^2 + B [{tag}]", le(R, R0) and le(R0, 2 * d^2 / PI^2 + B))
    check(f"Step 4: |R| ≤ max{{2δ^2/π^2 + B, (π/2)cosh(κ/2)}} [{tag}]", le(R.abs(), 2 * d^2 / PI^2 + B) or le(R.abs(), PI / 2 * chh))
    check(f"Step 4: max の各項の数値の行: 2δ^2/π^2 + B ≤ 2·0.2527^2/9.8696 + 0.88、(π/2)cosh(κ/2) ≤ (3.1416/2)·1.0315 [{tag}]",
          le(2 * d^2 / PI^2 + B, 2 * dec('0.2527')^2 / dec('9.8696') + dec('0.88')) and le(PI / 2 * chh, dec('3.1416') / 2 * dec('1.0315')))
    check(f"Step 4: |R| ≤ 1.621 [{tag}]", R.abs() <= dec('1.621'))
    # Step 5
    check(f"Step 5: T ≥ 0 [{tag}]", RB(0) <= T)
    def f_S32(z, an):
        S, r, t = parts(z, an); return 1 / (S * r)
    c0C = CB(c0)
    def f_w32(z, an):
        w = V['dC']^2 + c0C^2 * z^2 / 4
        return 1 / (w * w.sqrt(analytic=an))
    I_S = integ(f_S32, 0, CB.pi()); I_w = integ(f_w32, 0, CB.pi())
    TT = [T, shk^2 / 4 * I_S, shk^2 / 4 * I_w, shk^2 / 4 * 2 / (c0 * d^2), 4 * d^2 * chh^2 / 4 * 2 / (c0 * d^2),
          2 * chh^2 / c0, 2 * dec('1.0315')^2 / dec('0.5887')]
    check(f"Step 5 T の鎖 1→2 行目（≤） [{tag}]", le(TT[0], TT[1]))
    check(f"Step 5 T の鎖 2→3 行目（≤） [{tag}]", le(TT[1], TT[2]))
    check(f"Step 5 T の鎖 3→4 行目（three_halves_power_integral_bound。≤） [{tag}]", le(TT[2], TT[3]))
    eq(TT[3], TT[4], f"Step 5 T の鎖 4 行目 = 5 行目（sinh κ = 2δ cosh(κ/2)） [{tag}]")
    eq(TT[4], TT[5], f"Step 5 T の鎖 5 行目 = 6 行目 [{tag}]")
    check(f"Step 5 T の鎖 6→7 行目（≤） [{tag}]", le(TT[5], TT[6]))
    for th in [QQ(0), QQ(1)/10, QQ(1)/2, QQ(1), QQ(2), QQ(3), PI]:
        sh2 = (RB(th) / 2).sin()
        w = d^2 + c0^2 * RB(th)^2 / 4; Sv = d^2 + sh2^2; rv = Sv.sqrt()
        check(f"Step 5: sin(θ/2) ≥ c_0θ/2 ≥ 0 と S ≥ w ≥ δ^2 > 0（θ = {th}） [{tag}]",
              le(c0 * th / 2, sh2) and le(0, c0 * th / 2) and le(w, Sv) and le(d^2, w) and d^2 > 0)
        check(f"Step 5: √w ≤ r、w^{{3/2}} = w√w ≤ S r = S^{{3/2}}、1/S^{{3/2}} ≤ 1/w^{{3/2}}（θ = {th}） [{tag}]",
              le(w.sqrt(), rv) and le(w * w.sqrt(), Sv * rv) and le(1 / (Sv * rv), 1 / (w * w.sqrt())))
    # Step 6
    k = RB(kap)
    check(f"Step 6: κ/2 ≤ δ ≤ (κ/2)cosh(κ/2) [{tag}]", le(k / 2, d) and le(d, k / 2 * chh))
    check(f"Step 6: 2/cosh(κ/2) ≤ κ/δ ≤ 2 [{tag}]", le(2 / chh, k / d) and le(k / d, 2))
    rho = (k / d).log() - RB(2).log()
    eq(-chh.log(), (2 / chh).log() - RB(2).log(), f"Step 6: −log cosh(κ/2) = log(2/cosh(κ/2)) − log 2 [{tag}]")
    check(f"Step 6: log(2/cosh(κ/2)) − log 2 ≤ ρ ≤ log 2 − log 2 = 0 [{tag}]", le((2 / chh).log() - RB(2).log(), rho) and le(rho, RB(2).log() - RB(2).log()))
    eq(Lpd, (1 / k).log() + PI.log() + (k / d).log(), f"Step 6: log(π/δ) = log(1/κ) + log π + log(κ/δ) [{tag}]")
    eq(Lpd, (1 / k).log() + (2 * PI).log() + rho, f"Step 6: log(π/δ) = log(1/κ) + log(2π) + ρ [{tag}]")
    check(f"Step 6: cosh(κ/2) ≤ cosh(1/4)、|ρ| ≤ log cosh(κ/2) ≤ log cosh(1/4) ≤ 0.0310 [{tag}]",
          le(chh, c4) and le(rho.abs(), chh.log()) and le(chh.log(), c4.log()) and le(c4.log(), dec('0.0310')))
    eq(chk * Lpd - (1 / k).log(), (chk - 1) * (1 / k).log() + chk * ((2 * PI).log() + rho), f"Step 6: cosh κ log(π/δ) − log(1/κ) の分解 [{tag}]")
    eq(chk - 1, 2 * bsinh(kap / 2)^2, f"Step 6: cosh κ − 1 = 2 sinh^2(κ/2) [{tag}]")
    check(f"Step 6: 2 sinh^2(κ/2) ≤ 2((κ/2)cosh(κ/2))^2 ≤ 2((κ/2)cosh(1/4))^2 ≤ 0.532κ^2 [{tag}]",
          le(2 * d^2, 2 * (k / 2 * chh)^2) and le(2 * (k / 2 * chh)^2, 2 * (k / 2 * c4)^2) and le(2 * (k / 2 * c4)^2, dec('0.532') * k^2))
    check(f"Step 6: log(1/κ) > 0、cosh κ − 1 ≥ 0 [{tag}]", (1 / k).log() > 0 and chk - 1 >= 0)
    # F(s) := −s^2 log s と (R4)・(R3)
    Fk = -k^2 * k.log(); Fh = -RB(1/4) * RB(1/2).log()
    eq(Fk, k^2 * (1 / k).log(), f"Step 6: κ^2 log(1/κ) = F(κ) [{tag}]")
    IFp = integ(lambda s, an: s * (-2 * s.log(analytic=an) - 1), CB(kap), CB(1/2)) if kap < QQ(1)/2 else RB(0)
    eq(Fk, Fh - IFp, f"Step 6 (R4): F(κ) = F(1/2) − ∫_κ^{{1/2}} F' [{tag}]")
    check(f"Step 6: F'(s) = s(−2 log s − 1) > 0（s = κ, 1/2 と中点） [{tag}]",
          all(RB(s) * (-2 * RB(s).log() - 1) > 0 for s in [kap, QQ(1)/2, (kap + QQ(1)/2) / 2]))
    check(f"Step 6 (R3): ∫_κ^{{1/2}} F' ≥ 0 [{tag}]", le(0, IFp))
    eq(Fh, RB(2).log() / 4, f"Step 6: F(1/2) = (1/4)log 2 [{tag}]")
    first = (chk - 1) * (1 / k).log()
    check(f"Step 6: 0 ≤ (cosh κ − 1)log(1/κ) ≤ 0.532κ^2 log(1/κ) ≤ 0.532·0.1733 [{tag}]",
          le(0, first) and le(first, dec('0.532') * k^2 * (1 / k).log()) and le(k^2 * (1 / k).log(), dec('0.1733')))
    second = chk * ((2 * PI).log() + rho)
    check(f"Step 6: |cosh κ(log(2π) + ρ)| ≤ cosh κ(|log 2π| + |ρ|) ≤ 1.1277(1.8380 + 0.0310) [{tag}]",
          le(second.abs(), chk * ((2 * PI).log().abs() + rho.abs())) and le(chk, c2) and le(chk * ((2 * PI).log().abs() + rho.abs()), dec('2.108')))
    check(f"Step 6: |cosh κ log(π/δ) − log(1/κ)| ≤ 2.201 [{tag}]", le((chk * Lpd - (1 / k).log()).abs(), dec('2.201')))
    # Step 7
    eq(2 * PI * g2, chk / 2 * J - T, f"Step 7: 2πG'' = (cosh κ/2)J − T [{tag}]")
    eq(2 * PI * g2, chk / 2 * (2 * Lpd + R) - T, f"Step 7: = (cosh κ/2)(2log(π/δ) + R) − T [{tag}]")
    eq(2 * PI * g2, chk * Lpd + chk / 2 * R - T, f"Step 7: = cosh κ log(π/δ) + (cosh κ/2)R − T [{tag}]")
    tot = (2 * PI * g2 - (1 / k).log()).abs()
    check(f"Step 7: |2πG'' − log(1/κ)| ≤ |…| + (cosh κ/2)|R| + |T| ≤ 6.731 [{tag}]",
          le(tot, (chk * Lpd - (1 / k).log()).abs() + chk / 2 * R.abs() + T.abs()) and le(tot, dec('6.731')))
    err = (g2 - (1 / k).log() / (2 * PI)).abs()
    eq(err, tot / (2 * PI), f"Step 7: |G'' − (1/2π)log(1/κ)| = (1/2π)|2πG'' − log(1/κ)| [{tag}]")
    check(f"主張: |G'| ≤ 1/2 と |G''(±κ) − (1/2π)log(1/|κ|)| ≤ 6/5 [{tag}]", le(g1.abs(), QQ(1)/2) and le(err, QQ(6)/5))
    print(f"κ={kap}: G''={g2.mid().n(digits=8)}, |G''−(1/2π)log(1/κ)|={err.mid().n(digits=6)}, R={R.mid().n(digits=6)}, T={T.mid().n(digits=6)}")
check("対照: 主張の定数 6/5 を 1/20 にすると κ = 1/2 で破れる", not le((G2(QQ(1)/2) - (2 * RB(1)).log() / (2 * PI)).abs(), QQ(1)/20))
V10 = integrands(QQ(1)/10)
J10 = integ(lambda z, an: 1 / (V10['parts'](z, an)[1] * V10['parts'](z, an)[2]), 0, CB.pi())
check("対照: κ = 1/10 で R = J − 2log(π/δ) < 0（Step 4 の R の下界に差の評価が要る）", RB(J10 - 2 * (PI / V10['d']).log()) < 0)
finish()
