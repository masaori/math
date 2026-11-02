# 対象ラベル: closed_form_log_integral
# 準備の鎖 (W/δ)² = W²/δ² = (δ² + θ²/4)/δ² = (θ/(2δ))² + 1 = q² + 1 と √(q²+1) = W/δ、√1 = 1、q' = 1/(2δ)、
# F' の鎖の五行、F(0) の鎖の七行、積分の鎖の五行を確かめる。
# 帰属:
# - 準備の鎖は QQ(δ, θ)[W]/(W² - δ² - θ²/4) の等号として厳密に（W は √(δ² + θ²/4) の満たす関係式だけを持つ）。
#   √(q²+1) = W/δ と √1 = 1 は、有理数の点で AA の非負の平方根（一意）として厳密に。
# - F' の鎖の 1 行目は SR の記号微分（微分の公式と arcsinh_derivative は本文の事実で、SR の arcsinh の微分はそれと同じ公式）を
#   有理数の点で QQbar へ送り、2〜5 行目の値と厳密に比べる。
# - F(0) の鎖は AA と本文の exp の部分和（exp 0 = 1 が QQ で厳密）で。
# - 積分の鎖は、Arb の厳密な数値積分のボールと 2 arcsinh(π/(2δ)) のボール（RealBallField(512)）で比べる。
#   積分と π と arcsinh の値が QQ・AA に入らないための ℝ への脱出である。
load("../../_shared/log_integral_by_balls.sage")
K = PolynomialRing(QQ, 'dl,th').fraction_field(); dl, th = K.gens()
RW.<Wv> = K[]; Q.<W> = RW.quotient(Wv^2 - dl^2 - th^2/4)
q = th / (2*dl)
assert (W/dl)^2 == W^2/dl^2 == (dl^2 + th^2/4)/dl^2 == (th/(2*dl))^2 + 1 == q^2 + 1
print("準備の鎖が QQ(δ,θ)[W]/(W²-δ²-θ²/4) で成り立つ")
assert AA(1).sqrt() == 1
POINTS = [(QQ(1)/100, QQ(0)), (QQ(1)/10, QQ(1)), (QQ(1)/2, QQ(3)), (QQ(1), QQ(3141)/1000), (QQ(7), QQ(2))]   # θ ∈ [0, π]
ts, ds = SR.var('ts ds')
Fexpr = 2 * arcsinh(ts / (2*ds))
assert bool(diff(ts / (2*ds), ts) == 1/(2*ds))                       # q' = 1/(2δ)
Fprime = diff(Fexpr, ts)
qprime = diff(ts / (2*ds), ts)
for d0, t0 in POINTS:
    q0 = t0 / (2*d0); W0 = AA(d0^2 + t0^2/4).sqrt()
    assert AA(q0^2 + 1).sqrt() == W0 / d0                                  # √(q²+1) = W/δ（一意性）
    line1 = QQbar(Fprime.subs(ts=t0, ds=d0))
    line2 = 2 * (1 / QQbar(q0^2 + 1).sqrt()) * QQbar(qprime.subs(ts=t0, ds=d0))   # q'(θ) は SR の微分の値
    line3 = 2 * (1 / QQbar(q0^2 + 1).sqrt()) * (1/(2*d0))
    line3b = 2 * (1 / (QQbar(W0) / d0)) * (1/(2*d0))
    line4 = 2 * (d0 / QQbar(W0)) * (1/(2*d0))
    line5 = 1 / QQbar(W0)
    assert line1 == line2 == line3 == line3b == line4 == line5
print(f"{len(POINTS)} 点の (δ, θ) で √(q²+1) = W/δ と F' の鎖の六行が QQbar で厳密に一致する")
exp0 = entry11(matrix_partial_sum(one_by_one(QQ, QQ(0)), 30)); assert exp0 == 1
F0 = [arcsinh_ball(0), log_ball(0 + AA(0^2 + 1).sqrt()), log_ball(AA(1).sqrt()), log_ball(1), log_ball(exp0)]
assert all(x.is_exact() and x == 0 for x in F0)
print("F(0) の鎖: arcsinh 0 = log(0+√1) = log √1 = log 1 = log(exp 0) = 0 が厳密に成り立つ")
for d0 in [QQ(1)/1000, QQ(1)/100, QQ(1)/10, QQ(1)/2, QQ(1), QQ(5)]:
    I = integral_over_zero_pi(lambda th_, an: 1 / (CBF256(d0^2) + th_^2/4).sqrt(analytic=an))
    Fpi = 2 * (RBF512.pi() / (2*d0)).arcsinh()
    assert surely_equal(I, Fpi - 0)                                     # 積分の鎖の両端（(R4) の当てはめ）
    assert surely_equal(Fpi, 2 * log_ball(RBF512.pi()/(2*d0) + (RBF512.pi()^2/(4*d0^2) + 1).sqrt()))   # F(π) を def_arcsinh で
print("6 点の δ で ∫_0^π dθ/√(δ²+θ²/4) が 2 arcsinh(π/(2δ)) とボールで一致する")
d0 = QQ(1)/10
I = integral_over_zero_pi(lambda th_, an: 1 / (CBF256(d0^2) + th_^2/4).sqrt(analytic=an))
assert surely_lt((RBF512.pi() / (2*d0)).arcsinh(), I)
print("対照: 係数 2 を落とした arcsinh(π/(2δ)) とは一致しない")
print("RESULT: PASS")
