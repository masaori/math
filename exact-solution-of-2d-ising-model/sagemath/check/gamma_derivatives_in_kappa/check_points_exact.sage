# 対象ラベル: gamma_derivatives_in_kappa
# 主張 (1)〜(4) と証明の各行を、具体の点で AA（実代数的数）の厳密計算で確かめる。浮動小数点は使わない。
# 点の選び方: κ = 2 log u（u ∈ QQ_{>0}）、θ = πp（p ∈ QQ）。このとき（検算の側で使う標準の事実）
#   exp(κ/2) = u なので sinh(κ/2) = (u − 1/u)/2 などは QQ、sin^2(θ/2) = (1 − cos πp)/2 は AA（1 の冪根の実部）。
#   arcsinh(r) = log(r + √(r^2+1))（def_arcsinh）なので exp(γ/2) = x := r + √(r^2+1) ∈ AA で、
#   sinh(γ/2) = (x − 1/x)/2 などは exp ∘ log = id により AA の元になる。
# 導関数の値は、Sage の記号微分（SR の diff。検算 check_lines_in_ideal.sage の導分 D とは独立）で
#   γ(θ, κ) = 2 arcsinh(√(sinh^2(κ/2) + sin^2(θ/2))) を微分し、点を代入して AA に直したものと比べる。
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

def cos_pi(p):
    p = QQ(p)
    z = QQbar.zeta(p.denominator() * 2) ^ (p.numerator())   # exp(iπp)
    return AA(z.real())

ks, ths = SR.var('ks ths')
g_sr = 2 * arcsinh(sqrt(sinh(ks / 2)^2 + sin(ths / 2)^2))
dg_sr = g_sr.diff(ks)
d2g_sr = dg_sr.diff(ks)
def sr_at(expr, u0, p):
    e = expr.subs({ks: 2 * log(u0), ths: pi * p})
    return AA(e.exponentialize())   # sinh(−log(1/3)) のように SR が畳まない形を exp で書き直してから AA へ

def point(u0, p):
    u0 = QQ(u0)
    shk, chk = (u0 - 1 / u0) / 2, (u0 + 1 / u0) / 2
    sh, ch = (u0^2 - u0^(-2)) / 2, (u0^2 + u0^(-2)) / 2
    q = (1 - cos_pi(p)) / 2                     # sin^2(θ/2)
    S = AA(shk)^2 + q
    r = S.sqrt()
    t = (1 + S).sqrt()
    x = r + (r^2 + 1).sqrt()                    # exp(γ/2)
    return dict(shk=AA(shk), chk=AA(chk), sh=AA(sh), ch=AA(ch), q=q, S=S, r=r, t=t, x=x,
                shg2=(x - 1 / x) / 2, chg2=(x + 1 / x) / 2, shg=(x^2 - x^(-2)) / 2, chg=(x^2 + x^(-2)) / 2)

US = [QQ(2), QQ(3), QQ(1)/2, QQ(5)/4, QQ(1)/3]          # κ = 2 log u ≠ 0（負の κ を含む）
PS = [QQ(0), QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(2), QQ(-1)/4, QQ(7)/3]
for u0 in US + [QQ(1)]:
    for p in PS:
        V = point(u0, p)
        tag = f"u={u0}, p={p}"
        # 主張の前提: S ≥ 0
        check(f"S ≥ 0 [{tag}]", V["S"] >= 0)
        check(f"q = sin^2(θ/2) ∈ [0,1] [{tag}]", 0 <= V["q"] <= 1)
        # (1) を定義から: sinh(γ/2) = √S、cosh(γ/2) = √(1+S)、sinh γ = 2√(S(1+S))、cosh γ = 1 + 2S
        check(f"(1) sinh(γ/2) = √S [{tag}]", V["shg2"] == V["r"])
        check(f"(1) cosh(γ/2) = √(1+S) [{tag}]", V["chg2"] == V["t"])
        check(f"(1) sinh γ = 2√(S(1+S)) [{tag}]", V["shg"] == 2 * (V["S"] * (1 + V["S"])).sqrt())
        check(f"(1) cosh γ = 1 + 2S [{tag}]", V["chg"] == 1 + 2 * V["S"])
        # (1) の鎖の行
        check(f"(1) cosh(γ/2) > 0 と √((cosh γ/2)^2) = cosh γ/2 [{tag}]", V["chg2"] > 0 and (V["chg2"]^2).sqrt() == V["chg2"])
        check(f"(1) (cosh γ/2)^2 = 1 + (sinh γ/2)^2 [{tag}]", V["chg2"]^2 == 1 + V["shg2"]^2)
        check(f"(1) sinh γ = 2 sinh(γ/2)cosh(γ/2) = 2rt [{tag}]", V["shg"] == 2 * V["shg2"] * V["chg2"] == 2 * V["r"] * V["t"])
        check(f"(1) rt ≥ 0、√((rt)^2) = rt [{tag}]", V["r"] * V["t"] >= 0 and ((V["r"] * V["t"])^2).sqrt() == V["r"] * V["t"])
        check(f"(1) cosh γ = 1 + 2 sinh^2(γ/2) = 1 + 2r^2 [{tag}]", V["chg"] == 1 + 2 * V["shg2"]^2 == 1 + 2 * V["r"]^2)
        check(f"t ≥ 1 [{tag}]", V["t"] >= 1)
        if u0 == 1:
            continue
        # (2) S > 0 と sinh γ > 0
        check(f"(2) κ/2 ≠ 0 ⟹ sinh(κ/2) ≠ 0 ⟹ sinh^2(κ/2) > 0 [{tag}]", V["shk"] != 0 and V["shk"]^2 > 0)
        check(f"(2) S ≥ sinh^2(κ/2) > 0 [{tag}]", V["S"] >= V["shk"]^2 > 0)
        check(f"(2) r > 0、2rt > 0、sinh γ > 0 [{tag}]", V["r"] > 0 and 2 * V["r"] * V["t"] > 0 and V["shg"] > 0)
        # (2) 導関数: SR の記号微分と主張の式
        dg = sr_at(dg_sr, u0, p)
        d2g = sr_at(d2g_sr, u0, p)
        check(f"(2) ∂S/∂κ = sinh κ/2（SR） [{tag}]", sr_at((sinh(ks / 2)^2 + sin(ths / 2)^2).diff(ks), u0, p) == V["sh"] / 2)
        S_sr = sinh(ks / 2)^2 + sin(ths / 2)^2
        check(f"(2) ∂γ/∂κ の 4・5 行目: d/dκ √S = (1/(2r))·∂S/∂κ（SR） [{tag}]", sr_at(sqrt(S_sr).diff(ks), u0, p) == (1 / (2 * V["r"])) * (V["sh"] / 2))
        check(f"(2) ∂γ/∂κ の 3〜8 行目: d/dκ arcsinh(√S) = (1/t)·(1/(2r))·∂S/∂κ（SR） [{tag}]", sr_at(arcsinh(sqrt(S_sr)).diff(ks), u0, p) == (1 / V["t"]) * (1 / (2 * V["r"])) * (V["sh"] / 2))
        check(f"(2) ∂γ/∂κ の 1・2 行目: ∂γ/∂κ = 2·d/dκ arcsinh(√S)（SR） [{tag}]", sr_at(dg_sr, u0, p) == 2 * sr_at(arcsinh(sqrt(S_sr)).diff(ks), u0, p))
        check(f"(2) ∂γ/∂κ = sinh κ/sinh γ [{tag}]", dg == V["sh"] / V["shg"])
        check(f"(2) ∂γ/∂κ = sinh κ/(2rt) = 2·(1/t)·(1/(2r))·(sinh κ/2) [{tag}]", dg == V["sh"] / (2 * V["r"] * V["t"]) == 2 * (1 / V["t"]) * (1 / (2 * V["r"])) * (V["sh"] / 2))
        check(f"(2) arcsinh'(r) = 1/√(r^2+1) = 1/t（SR の arcsinh の微分） [{tag}]", AA(arcsinh(SR.var('yy')).diff(SR.var('yy')).subs(yy=V["r"].radical_expression())) == 1 / V["t"])
        check(f"(2) ∂²γ/∂κ² = cosh κ/sinh γ − sinh^2 κ cosh γ/sinh^3 γ [{tag}]", d2g == V["ch"] / V["shg"] - V["sh"]^2 * V["chg"] / V["shg"]^3)
        check(f"(2) ∂²γ/∂κ² の鎖の 5 行目 (cosh κ sinh γ − sinh κ cosh γ·∂γ/∂κ)/sinh^2 γ [{tag}]", d2g == (V["ch"] * V["shg"] - V["sh"] * V["chg"] * dg) / V["shg"]^2)
        check(f"対照: ∂γ/∂κ ≠ sinh κ/(2 sinh γ) [{tag}]", dg != V["sh"] / (2 * V["shg"]))
        check(f"対照: ∂²γ/∂κ² ≠ cosh κ/sinh γ + sinh^2 κ cosh γ/sinh^3 γ [{tag}]", d2g != V["ch"] / V["shg"] + V["sh"]^2 * V["chg"] / V["shg"]^3)
        # (3)
        lhs3 = V["shg"]^2 - V["sh"]^2
        check(f"(3) sinh^2 γ − sinh^2 κ = 4 sin^2(θ/2)(1 + S + sinh^2(κ/2)) ≥ 0 [{tag}]", lhs3 == 4 * V["q"] * (1 + V["S"] + V["shk"]^2) and lhs3 >= 0)
        check(f"(3) |sinh κ| ≤ sinh γ [{tag}]", abs(V["sh"]) <= V["shg"])
        check(f"(3) |∂γ/∂κ| = |sinh κ|/sinh γ ≤ 1 [{tag}]", abs(dg) == abs(V["sh"]) / V["shg"] and abs(dg) <= 1)
        if V["q"] == 0:
            check(f"(3) θ ∈ 2πℤ では |∂γ/∂κ| = 1（評価は等号で達する） [{tag}]", abs(dg) == 1)
        else:
            check(f"(3) sin(θ/2) ≠ 0 では |∂γ/∂κ| < 1 [{tag}]", abs(dg) < 1)

# κ = 0 の点: S = sin^2(θ/2)。θ = 0 では S = 0 で (2) の前提が崩れる（対照）
V = point(1, 0)
check("対照: κ = 0、θ = 0 では S = 0（(2) は κ ≠ 0 を要る）", V["S"] == 0)

# (4) κ_1 = 2 log(5/4)、κ_2 = 2 log 3 の格子 [0, 2π] × [κ_1, κ_2]
k1 = point(QQ(5)/4, 0)["shk"]
for u0 in [QQ(5)/4, QQ(3)/2, QQ(2), QQ(5)/2, QQ(3)]:
    for p in [QQ(j) / 4 for j in range(9)]:
        V = point(u0, p)
        tag = f"u={u0}, p={p}"
        check(f"(4) sinh(κ/2) ≥ sinh(κ_1/2) > 0 [{tag}]", V["shk"] >= k1 > 0)
        check(f"(4) S ≥ sinh^2(κ/2) ≥ sinh^2(κ_1/2) > 0 [{tag}]", V["S"] >= V["shk"]^2 >= k1^2 > 0)
        check(f"(4) sinh γ = 2rt ≥ 2r > 0 [{tag}]", V["shg"] == 2 * V["r"] * V["t"] and 2 * V["r"] * V["t"] >= 2 * V["r"] > 0)
check("対照: κ_1/2 > 0 でない u = 1/2 では sinh(κ/2) < 0", point(QQ(1)/2, 0)["shk"] < 0)

print(f"真偽の確認 {n['all']} 件（うち対照 {n['control']} 件）")
print("RESULT: PASS" if ok else "RESULT: FAIL")
if not ok:
    sys.exit(1)
