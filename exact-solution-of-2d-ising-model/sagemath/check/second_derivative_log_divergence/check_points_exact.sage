# 対象ラベル: second_derivative_log_divergence
# 被積分関数の各点の行（Step 2・Step 3・Step 4・Step 5）を、具体の点で AA（実代数的数）の厳密計算で確かめる。浮動小数点は使わない。
# 点の選び方: κ = 2 log u（u ∈ QQ, 1 < u ≤ 5/4 なので 0 < κ ≤ 2 log(5/4) < 1/2）、θ = πp（p ∈ QQ ∩ [0, 2]）。
#   exp(κ/2) = u（検算の側で使う標準の事実）なので δ = sinh(κ/2) = (u − 1/u)/2、cosh(κ/2) = (u + 1/u)/2 は QQ、
#   sin^2(θ/2) = (1 − cos πp)/2 は 1 の冪根の実部から作り、選ぶ点では QQ に入る（計算を速くするため）。exp(γ/2) = r + √(r^2+1)（def_arcsinh）も AA。
# c_0 = 1 − π^2/24 が入る行（sin(θ/2) ≥ c_0 θ/2）は π を含むので check_bounds_with_balls.sage で確かめる。
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
def cos_pi(p):                     # cos(πp) = exp(iπp) の実部。選ぶ点では有理数なので QQ に落とす（最小多項式が 1 次であることを確かめる）
    p = QQ(p)
    c = AA((QQbar.zeta(2 * p.denominator()) ^ p.numerator()).real())
    mp = c.minpoly()
    assert mp.degree() == 1
    return QQ(-mp[0])

US = [QQ(5)/4, QQ(11)/10, QQ(101)/100, QQ(1001)/1000]
PS = [QQ(0), QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(4)/3, QQ(3)/2, QQ(5)/3, QQ(2)]   # sin^2(θ/2) ∈ {0, 1/4, 1/2, 3/4, 1}
for u in US:
    d = (u - 1/u) / 2; ch = (u + 1/u) / 2
    shk = (u^2 - u^(-2)) / 2; chk = (u^2 + u^(-2)) / 2
    check(f"Step 0: δ > 0 [u={u}]", d > 0)
    check(f"Step 0: κ = 2 log u ≤ 1/2（u^4 ≤ 2.71 < e） [u={u}]", u^4 <= QQ(271)/100)
    check(f"sinh κ = 2δ cosh(κ/2)（sinh_double_angle_formula） [u={u}]", shk == 2 * d * ch)
    check(f"cosh κ − 1 = 2δ^2（cosh_half_angle_formula） [u={u}]", chk - 1 == 2 * d^2)
    for p in PS:
        tag = f"u={u}, p={p}"
        q = (1 - cos_pi(p)) / 2
        # Step 2: θ ↦ 2π − θ で sin^2(θ/2) は不変
        check(f"Step 2: sin^2((2π−θ)/2) = sin^2(θ/2) [{tag}]", (1 - cos_pi(2 - p)) / 2 == q)
        S = AA(d)^2 + q
        r = S.sqrt(); t = (1 + S).sqrt()
        x = r + (r^2 + 1).sqrt()
        shg = (x^2 - x^(-2)) / 2; chg = (x^2 + x^(-2)) / 2
        # Step 3 の準備
        check(f"Step 3: S > 0、r > 0、t ≥ 1 [{tag}]", S > 0 and r > 0 and t >= 1)
        shg2 = (x - 1 / x) / 2; chg2 = (x + 1 / x) / 2
        check(f"Step 3: sinh(γ/2) = r、cosh(γ/2) = t、sinh γ = 2 sinh(γ/2)cosh(γ/2) [{tag}]",
              shg2 == r and chg2 == t and (x^2 - x^(-2)) / 2 == 2 * shg2 * chg2)
        check(f"Step 4 準備: 0 ≤ sin^2(θ/2) ≤ 1、r^2 = δ^2 + sin^2(θ/2) ≤ δ^2 + 1 = cosh^2(κ/2)、r ≤ cosh(κ/2) [{tag}]",
              0 <= q <= 1 and r^2 == d^2 + q and r^2 <= d^2 + 1 and d^2 + 1 == ch^2 and r <= ch)
        check(f"Step 3: √(S(1+S)) = rt [{tag}]", (S * (1 + S)).sqrt() == r * t)
        check(f"Step 3: sinh γ = 2√(S(1+S)) = 2rt、cosh γ = 1 + 2S（γ の定義から） [{tag}]",
              shg == 2 * (S * (1 + S)).sqrt() and shg == 2 * r * t and chg == 1 + 2 * S)
        d2g = chk / shg - shk^2 * chg / shg^3
        check(f"Step 3 1→2 行目: ∂²γ/∂κ² = cosh κ/(2rt) − sinh^2κ cosh γ/sinh^3γ [{tag}]",
              d2g == chk / (2 * r * t) - shk^2 * chg / shg^3)
        # Step 4 の各点の鎖
        L = [1/r - 1/(r*t), (1/r) * (1 - 1/t), (1/r) * (t - 1) / t, (1/r) * (t - 1) * (t + 1) / (t * (t + 1)),
             (1/r) * (t^2 - 1) / (t * (t + 1)), (1/r) * S / (t * (t + 1))]
        for j in range(5):
            check(f"Step 4 各点の鎖 {j+1}→{j+2} 行目 [{tag}]", L[j] == L[j + 1])
        check(f"Step 4: 値は 0 以上 [{tag}]", L[0] >= 0)
        check(f"Step 4: t(t+1) ≥ 2 [{tag}]", t * (t + 1) >= 2)
        U = [L[5], (1/r) * S / 2, r^2 / (2 * r), r / 2, AA(ch) / 2]
        check(f"Step 4 上界の鎖 1→2 行目（≤） [{tag}]", U[0] <= U[1])
        check(f"Step 4 上界の鎖 2→3→4 行目（=） [{tag}]", U[1] == U[2] and U[2] == U[3])
        check(f"Step 4 上界の鎖 4→5 行目（≤）と r^2 ≤ δ^2 + 1 = cosh^2(κ/2) [{tag}]",
              U[3] <= U[4] and r^2 <= d^2 + 1 and d^2 + 1 == ch^2)
        # Step 5 の各点の鎖
        F = [chg / shg^3, (1 + 2*S) / (2*r*t)^3, (1 + 2*S) / (8 * r^3 * t^3), 2 * (1 + S) / (8 * r^3 * t^3),
             2 * t^2 / (8 * r^3 * t^3), 1 / (4 * r^3 * t), 1 / (4 * r^3), 1 / (4 * S * r)]
        check(f"Step 5 1→2→3 行目（=） [{tag}]", F[0] == F[1] and F[1] == F[2])
        check(f"Step 5 3→4 行目（≤） [{tag}]", F[2] <= F[3])
        check(f"Step 5 4→5→6 行目（=） [{tag}]", F[3] == F[4] and F[4] == F[5])
        check(f"Step 5 6→7 行目（≤） [{tag}]", F[5] <= F[6])
        check(f"Step 5 7→8 行目: 1/(4r^3) = 1/(4S^{{3/2}})（S^{{3/2}} = S√S） [{tag}]",
              F[6] == F[7] and F[7] == 1 / (4 * S * S.sqrt()))
        check(f"Step 5: 2 行目の値 > 0 と被積分関数 sinh^2κ cosh γ/sinh^3γ ≥ 0 [{tag}]", F[1] > 0 and shk^2 * F[0] >= 0)
        if p == 0:
            check(f"対照 Step 4: θ = 0 では各点の上界 r/2 を r^2/2 にすると破れる [{tag}]", not (L[0] <= r^2 / 2))
            check(f"対照 Step 5: θ = 0 では 1/(4r^3) を 1/(8r^3) にすると破れる [{tag}]", not (F[0] <= 1 / (8 * r^3)))
print(f"真偽の確認 {n['all']} 件（うち対照 {n['control']} 件）")
print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
