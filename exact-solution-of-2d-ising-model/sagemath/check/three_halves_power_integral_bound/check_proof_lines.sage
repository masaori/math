# 対象ラベル: three_halves_power_integral_bound
# w' の鎖の二行、r' の鎖の三行、G' の鎖の九行、r(π) > aπ/2 の背理法の鎖、1/r(π) の鎖の三行、積分の鎖の六行を確かめる。
# 帰属:
# - w' の鎖は QQ[a, δ, θ] の多項式の微分として厳密に。
# - r' と G' の鎖は、関数体 L = K(θ)[r]/(r² - δ² - a²θ²/4)（K = QQ(a, δ)）の θ についての微分 D で厳密に。
#   r² = w から 2r·D(r) = D(w) で D(r) が決まる。微分の公式の平方根・合成・商は本文が外部から持ち込む事実で、
#   関数体の微分はそれと同じ規則で計算される。G' の鎖の各行は L の元として互いに等しいことを見る。
# - r(π) と積分の大小は、(δ, a) ∈ QQ_{>0}² の点で Arb のボールで確かめる（π と積分の値が QQ・AA に入らないための ℝ への脱出）。
load("../../_shared/log_integral_by_balls.sage")
P.<a, dl, th> = PolynomialRing(QQ)
w = dl^2 + a^2*th^2/4
assert w.derivative(th) == 0 + (a^2/4) * (1*th + th*1) == a^2*th/2
print("w' の鎖が QQ[a,δ,θ] で成り立つ")
K0 = PolynomialRing(QQ, 'av,dv').fraction_field(); av, dv = K0.gens()
Ft.<t> = FunctionField(K0); RS.<S> = Ft[]; L.<r> = Ft.extension(S^2 - (dv^2 + av^2*t^2/4))
D = L.derivation()
wL = dv^2 + av^2*t^2/4
assert r^2 == wL
rp = D(r)
assert 2*r*rp == D(wL) == av^2*t/2
assert rp == (1/(2*r)) * D(wL) == (1/(2*r)) * (av^2*t/2) == av^2*t/(4*r)   # r' の鎖の三行
G = t / (dv^2 * r)
g1 = (1*dv^2*r - t*dv^2*rp) / (dv^2*r)^2
g1b = (dv^2*r - t*dv^2*(av^2*t/(4*r))) / (dv^2*r)^2
g2 = (dv^2*r - dv^2*(av^2*t^2/(4*r))) / (dv^4*r^2)
g3 = (dv^2*r^2 - dv^2*(av^2*t^2/4)) / (dv^4*r^3)
g4 = dv^2*(r^2 - av^2*t^2/4) / (dv^4*r^3)
g5 = dv^2*dv^2 / (dv^4*r^3)
g6 = 1 / (r^2*r)
g7 = 1 / (wL*r)
assert D(G) == g1 == g1b == g2 == g3 == g4 == g5 == g6 == g7
assert g7 != 1/wL                                                        # 対照: 3/2 乗の √w の因子は落とせない
print("r' の鎖と G' の鎖の九行（最後は def_three_halves_power の w√w）が関数体の微分で厳密に一致する")
# 背理法の鎖の 4〜6 行目、1/r(π) の鎖、積分の鎖の 4・6 行目は、π を不定元 p に置いた QQ(a,δ,p)[r]/(r²-δ²-a²p²/4) の等号で。
# 5 行目の < は差が δ² であることに帰着させる。
K1 = PolynomialRing(QQ, 'ac,dc,pc').fraction_field(); ac, dc, pc = K1.gens()
Rr.<rv> = K1[]; Qr.<rr> = Rr.quotient(rv^2 - dc^2 - ac^2*pc^2/4)
assert (ac*pc/2)*(ac*pc/2) == ac^2*pc^2/4 and (dc^2 + ac^2*pc^2/4) - ac^2*pc^2/4 == dc^2 and rr^2 == dc^2 + ac^2*pc^2/4
assert (ac*pc/2) * (2/(ac*pc*rr)) == 1/rr and rr * (2/(ac*pc*rr)) == 2/(ac*pc)          # 1/r(π) の鎖の両端の等号
assert pc/(dc^2*rr) - 0/(dc^2) == (pc/dc^2) * (1/rr)                                    # 積分の鎖の 3・4 行目（G(0) = 0）
assert (pc/dc^2) * (2/(ac*pc)) == 2/(ac*dc^2)                                         # 6 行目
print("背理法の鎖の等号、1/r(π) の鎖の等号、積分の鎖の 4・6 行目が QQ(a,δ,p)[r]/(r²-δ²-a²p²/4) で成り立つ")
POINTS = [(QQ(1)/100, QQ(1)/2), (QQ(1)/10, QQ(5887)/10000), (QQ(1), QQ(1)), (QQ(2), QQ(3)), (QQ(1)/2, QQ(10))]
for d0, a0 in POINTS:
    pi_b = RBF512.pi()
    w_pi = d0^2 + a0^2*pi_b^2/4; r_pi = w_pi.sqrt()
    half = a0*pi_b/2
    assert surely_lt(half, r_pi) and half.lower() > 0                    # r(π) > aπ/2 > 0
    assert surely_le(1/r_pi, 2/(a0*pi_b))
    I = integral_over_zero_pi(lambda th_, an: (lambda w_: 1 / (w_ * w_.sqrt(analytic=an)))(CBF256(d0^2) + CBF256(a0^2)*th_^2/4))
    assert surely_equal(I, pi_b/(d0^2*r_pi) - 0)                         # 積分の鎖の 1〜3 行目（(R4) の当てはめ）
    assert surely_le((pi_b/d0^2)*(1/r_pi), (pi_b/d0^2)*(2/(a0*pi_b)))    # 5 行目
    assert surely_le(I, 2/(a0*d0^2))                                     # 主張
print(f"{len(POINTS)} 点の (δ, a) で r(π) > aπ/2、積分の鎖の各行と主張がボールで確定する")
d0, a0 = QQ(1)/100, QQ(1)/2
I = integral_over_zero_pi(lambda th_, an: (lambda w_: 1 / (w_ * w_.sqrt(analytic=an)))(CBF256(d0^2) + CBF256(a0^2)*th_^2/4))
assert surely_lt(1/(a0*d0^2), I)
print("対照: 上界を半分の 1/(aδ²) にすると成り立たない（δ = 1/100, a = 1/2）")
print("RESULT: PASS")
