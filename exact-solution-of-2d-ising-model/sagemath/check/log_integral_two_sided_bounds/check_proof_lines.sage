# 対象ラベル: log_integral_two_sided_bounds
# 準備の 2y = π/δ、1/(4y²) = δ²/π²、下からの評価の三行、上からの評価の四行を確かめる。
# 帰属:
# - 準備と分配則の行は、π を不定元 p に置いた QQ(p, δ) の等号として厳密に。
# - 大小の行と主張は、δ ∈ QQ_{>0} の点で、積分を Arb の厳密な数値積分のボールで、log・arcsinh・π を Arb のボールで囲んで確かめる
#   （値が QQ・AA に入らないための ℝ への脱出）。
load("../../_shared/log_integral_by_balls.sage")
K = PolynomialRing(QQ, 'p,dl').fraction_field(); p, dl = K.gens()
yv = p / (2*dl)
assert 2*yv == p/dl and 1/(4*yv^2) == dl^2/p^2
assert 2*(p/dl + dl^2/p^2) == 2*(p/dl) + 2*dl^2/p^2                     # 上からの評価の 4 行目（分配則。log は形だけ）
print("準備の 2y = π/δ、1/(4y²) = δ²/π² と分配則の行が QQ(p, δ) で成り立つ")
assert PI_BALL.lower() >= QQ(3141592)/10^6 > 0
DS = [QQ(1)/1000, QQ(1)/100, QQ(1)/10, QQ(1)/2, QQ(1), QQ(2), QQ(10)]
for d0 in DS:
    pi_b = RBF512.pi(); y0 = pi_b / (2*d0)
    I = integral_over_zero_pi(lambda th_, an: 1 / (CBF256(d0^2) + th_^2/4).sqrt(analytic=an))
    a0 = 2 * y0.arcsinh(); assert surely_equal(I, a0)                   # 両方の評価の 1 行目（closed_form_log_integral）
    low = 2 * (2*y0).log(); assert surely_le(low, a0)                     # 下からの評価の 2 行目
    assert surely_equal(low, 2 * (pi_b/d0).log())                        # 下からの評価の 3 行目
    up2 = 2 * ((2*y0).log() + 1/(4*y0^2)); assert surely_le(a0, up2)     # 上からの評価の 2 行目
    up3 = 2 * ((pi_b/d0).log() + d0^2/pi_b^2); assert surely_equal(up2, up3)
    up4 = 2 * (pi_b/d0).log() + 2*d0^2/pi_b^2; assert surely_equal(up3, up4)
    assert surely_le(2 * (pi_b/d0).log(), I) and surely_le(I, up4)       # 主張
print(f"{len(DS)} 点の δ で両方の評価の各行と主張がボールで確定する")
d0 = QQ(1)/10
I = integral_over_zero_pi(lambda th_, an: 1 / (CBF256(d0^2) + th_^2/4).sqrt(analytic=an))
assert surely_lt(2 * (RBF512.pi()/d0).log(), I)
print("対照: 上の余り 2δ²/π² を落とした 2 log(π/δ) は上界にならない（δ = 1/10）")
print("RESULT: PASS")
