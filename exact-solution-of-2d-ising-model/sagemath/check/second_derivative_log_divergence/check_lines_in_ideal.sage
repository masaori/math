# 対象ラベル: second_derivative_log_divergence
# 証明の等号の行のうち、点の値によらない代数の行を、QQ 上の多項式環のイデアルの所属で厳密に確かめる（浮動小数点なし）。
# 変数: d = δ = sinh(κ/2)、ch = cosh(κ/2)、q = sin^2(θ/2)、r = √S、t = √(1+S)（S = d^2 + q）と、その逆数
#   di = 1/d、ri = 1/r、ti = 1/t、tpi = 1/(t+1)、c0、c0i = 1/c0。
# 関係式: ch^2 = 1 + d^2（cosh_sinh_basic_properties (2)）、r^2 = S、t^2 = 1 + S、各逆数の積 = 1。
# exp(γ/2) = r + t（def_arcsinh: arcsinh(r) = log(r + √(r^2+1)) で √(r^2+1) = t）、exp(−γ/2) = t − r。
# 対数の値（log(1/κ)・log(2π)・ρ など）は独立な不定元として扱い、行が多項式の恒等式であることだけを見る。
import sys
ok = True
n = {"all": 0, "control": 0}
def check(name, cond):
    global ok
    n["all"] += 1
    if name.startswith("対照"):
        n["control"] += 1
    if not cond:
        print("FAIL " + name)
    ok = ok and bool(cond)

P = PolynomialRing(QQ, 'd,di,ch,q,r,ri,t,ti,tpi,c0,c0i')
d, di, ch, q, r, ri, t, ti, tpi, c0, c0i = P.gens()
S = d^2 + q
I = P.ideal([ch^2 - 1 - d^2, r^2 - S, t^2 - 1 - S, d*di - 1, r*ri - 1, t*ti - 1, (t + 1)*tpi - 1, c0*c0i - 1])
def same(a, b, name):
    check(name, (a - b) in I)
def differ(a, b, name):
    check(name, (a - b) not in I)

x, xi = r + t, t - r                                   # exp(γ/2)、exp(−γ/2)
same(x * xi, 1, "exp(γ/2)·exp(−γ/2) = 1（t − r が r + t の逆数）")
shg = (x^2 - xi^2) / 2; chg = (x^2 + xi^2) / 2          # sinh γ、cosh γ（def_cosh_sinh）
shk = 2 * d * ch                                         # sinh κ（sinh_double_angle_formula）
chk = ch^2 + d^2                                         # cosh κ = cosh^2(κ/2) + sinh^2(κ/2)（cosh_addition_formula）

# ---- Step 3
same(shg, 2 * r * t, "Step 3: sinh γ = 2rt")
same(chg, 1 + 2 * S, "Step 3: cosh γ = 1 + 2S（gamma_derivatives_in_kappa (1)）")
same((r * t)^2, S * (1 + S), "Step 3: (rt)^2 = r^2 t^2 = S(1+S)")
differ(shg, 2 * r, "対照 Step 3: sinh γ = 2r ではない")
# 1 行目の被積分関数 cosh κ/sinh γ − sinh^2κ cosh γ/sinh^3 γ と 2 行目の cosh κ/(2rt) − …（1/sinh γ = ri ti/2）
same(chk * (ri * ti / 2) * shg, chk, "Step 3 1→2 行目: (cosh κ/(2rt))·sinh γ = cosh κ")

# ---- Step 4 の各点の鎖（等号の行）
L = [ri - ri * ti,                                       # 1/r − 1/(rt)
     ri * (1 - ti),                                      # (1/r)(1 − 1/t)
     ri * (t - 1) * ti,                                  # (1/r)(t − 1)/t
     ri * (t - 1) * (t + 1) * ti * tpi,                  # (1/r)(t−1)(t+1)/(t(t+1))
     ri * (t^2 - 1) * ti * tpi,                          # (1/r)(t^2 − 1)/(t(t+1))
     ri * S * ti * tpi]                                  # (1/r) S/(t(t+1))
for j in range(len(L) - 1):
    same(L[j], L[j + 1], f"Step 4 各点の鎖 {j+1}→{j+2} 行目")
differ(L[4], ri * (t^2 + 1) * ti * tpi, "対照 Step 4: (t−1)(t+1) を t^2 + 1 にすると一致しない")
M = [ri * S / 2, r^2 * ri / 2, r / 2]                   # (1/r)(S/2)、r^2/(2r)、r/2
same(M[0], M[1], "Step 4 各点の上界 1→2 行目: (1/r)(S/2) = r^2/(2r)（S = r^2）")
same(M[1], M[2], "Step 4 各点の上界 2→3 行目: r^2/(2r) = r/2")
same(ch^2 - r^2, 1 - q, "Step 4 最後の行の理由: cosh^2(κ/2) − r^2 = 1 − sin^2(θ/2)")
same(ch^2, d^2 + 1, "Step 4 最後の行の理由: δ^2 + 1 = cosh^2(κ/2)")
# 差の評価の積分の段: R = J − 2Lpd = R_0 − (I_0 − J)（R_0 := I_0 − 2Lpd）
Q = PolynomialRing(QQ, 'J,I0,Lpd,T,ck,Lk,L2pi,rho,Rr')
J, I0, Lpd, T, ck, Lk, L2pi, rho, Rr = Q.gens()
check("Step 4: J − 2log(π/δ) = (I_0 − 2log(π/δ)) − (I_0 − J)", J - 2 * Lpd == (I0 - 2 * Lpd) - (I0 - J))
check("Step 4: J = 2log(π/δ) + R（R := J − 2log(π/δ)）", J == 2 * Lpd + (J - 2 * Lpd))

# ---- Step 5 の各点の鎖
E = [chg * (ri * ti / 2)^3,                              # (1+2S)/(2rt)^3
     (1 + 2 * S) * ri^3 * ti^3 / 8,                      # (1+2S)/(8 r^3 t^3)
     None,                                               # ≤ 2(1+S)/(8 r^3 t^3)（不等号）
     2 * t^2 * ri^3 * ti^3 / 8,                          # 2t^2/(8 r^3 t^3)
     ri^3 * ti / 4,                                      # 1/(4 r^3 t)
     None,                                               # ≤ 1/(4 r^3)（不等号）
     ri^3 / 4]                                           # 1/(4 S^{3/2})（S^{3/2} = S r = r^3）
same(E[0], E[1], "Step 5 1→2 行目: (1+2S)/(2rt)^3 = (1+2S)/(8r^3t^3)")
same(2 * (1 + S) * ri^3 * ti^3 / 8, E[3], "Step 5 3→4 行目: 2(1+S) = 2t^2")
same(E[3], E[4], "Step 5 4→5 行目: 2t^2/(8r^3t^3) = 1/(4r^3t)")
same(S * r, r^3, "Step 5 準備: S^{3/2} = S·r = r^3（def_three_halves_power）")
same(E[6] * S * r, QQ(1)/4, "Step 5 最後の行: (1/(4r^3))·S^{3/2} = 1/4")
same(2 * (1 + S) - (1 + 2 * S), P(1), "Step 5 2→3 行目の理由: 2(1+S) − (1+2S) = 1 ≥ 0")
differ(E[4], ri^3 * ti^3 / 4, "対照 Step 5: 1/(4r^3t) を 1/(4r^3t^3) にすると一致しない")
# T の鎖の 3→4→5 行目: (sinh^2κ/4)·2/(c0 δ^2) = (4δ^2 cosh^2(κ/2)/4)·2/(c0 δ^2) = 2cosh^2(κ/2)/c0
same(shk^2 / 4 * 2 * c0i * di^2, (4 * d^2 * ch^2 / 4) * 2 * c0i * di^2, "Step 5 T の鎖 3→4 行目（sinh κ = 2δ cosh(κ/2)）")
same((4 * d^2 * ch^2 / 4) * 2 * c0i * di^2, 2 * ch^2 * c0i, "Step 5 T の鎖 4→5 行目（δ > 0 で約分）")

# ---- Step 6
same(chk - 1, 2 * d^2, "Step 6: cosh κ − 1 = 2 sinh^2(κ/2)（cosh_half_angle_formula）")
check("Step 6: cosh κ·(log(1/κ) + log(2π) + ρ) − log(1/κ) = (cosh κ − 1)log(1/κ) + cosh κ(log(2π) + ρ)",
      ck * (Lk + L2pi + rho) - Lk == (ck - 1) * Lk + ck * (L2pi + rho))
check("対照 Step 6: 右辺の第 1 項の (cosh κ − 1) を cosh κ にすると一致しない",
      ck * (Lk + L2pi + rho) - Lk != ck * Lk + ck * (L2pi + rho))
# ---- Step 7
check("Step 7: (cosh κ/2)(2log(π/δ) + R) − T = cosh κ log(π/δ) + (cosh κ/2)R − T",
      (ck / 2) * (2 * Lpd + Rr) - T == ck * Lpd + (ck / 2) * Rr - T)
print(f"真偽の確認 {n['all']} 件（うち対照 {n['control']} 件）")
print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
