# 対象ラベル: gamma_derivatives_in_kappa
# 証明の等号の行を、u := exp(κ/2)、q := sin^2(θ/2)、r := √S、t := √(1+S) と、それぞれの逆数を変数に持つ
# QQ 上の多項式環で、関係式のイデアルを法として厳密に確かめる（グレブナー基底）。浮動小数点は使わない。
# 書き換え（検算の側で使う事実。本文の証明には無い）: sinh(κ/2) = (u − u^{-1})/2、cosh(κ/2) = (u + u^{-1})/2、
#   sinh κ = (u^2 − u^{-2})/2、cosh κ = (u^2 + u^{-2})/2（def_cosh_sinh と exp の指数法則）。
# 微分は κ についての導分 D で表す: D(u) = u/2（exp' = exp と合成）、D(q) = 0（θ は固定）、
#   D(r) = D(S)/(2r)（(√)'(w) = 1/(2√w) と合成）、D(t) = D(S)/(2t)。D がイデアルを保つこと（導分が well-defined）も確かめる。
#   微分の公式そのものは本文が外部から持ち込む事実で、ここでは当てはめた各行の両辺の一致を確かめる。
#   導関数の値そのものは check_points_exact.sage で Sage の記号微分（D と独立）と比べる。
import sys
ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

P = PolynomialRing(QQ, 'u,ui,q,r,ri,t,ti', order='degrevlex')
u, ui, q, r, ri, t, ti = P.gens()
shk, chk = (u - ui) / 2, (u + ui) / 2            # sinh(κ/2), cosh(κ/2)
sh, ch = (u^2 - ui^2) / 2, (u^2 + ui^2) / 2      # sinh κ, cosh κ
S = shk^2 + q
rels = [u * ui - 1, r^2 - S, t^2 - (1 + S), r * ri - 1, t * ti - 1]
I = P.ideal(rels)
G = I.groebner_basis()
def red(f):
    return P(f).reduce(G)
def eqI(a, b):
    return red(a - b) == 0

# 導分 D（κ についての微分）
DS_gen = None
def D(f):
    f = P(f)
    dS = P(S.derivative(u) * (u / 2) + S.derivative(ui) * (-ui / 2))
    imgs = {u: u / 2, ui: -ui / 2, q: P(0),
            r: dS * ri / 2, t: dS * ti / 2}
    imgs[ri] = -ri^2 * imgs[r]
    imgs[ti] = -ti^2 * imgs[t]
    return sum(f.derivative(x) * imgs[x] for x in P.gens())

for g in rels:
    check(f"導分 D はイデアルを保つ: D({g}) ∈ I", red(D(g)) == 0)
check("準備: D(sinh(κ/2)) = cosh(κ/2)/2（sinh_derivative と合成）", eqI(D(shk), chk / 2))
check("準備: D(sinh κ) = cosh κ（sinh_derivative）", eqI(D(sh), ch))
check("準備: 倍角 sinh κ = 2 sinh(κ/2) cosh(κ/2)", eqI(sh, 2 * shk * chk))
check("準備: cosh^2 − sinh^2 = 1（κ/2 で）", eqI(chk^2 - shk^2, 1))

# γ の側: sinh(γ/2) = r、cosh(γ/2) = t（(1) の前半。値の一致は check_points_exact.sage で定義から確かめる）
shg2, chg2 = r, t
shg, chg = 2 * r * t, 1 + 2 * r^2                # sinh γ、cosh γ（(1) の後半）
check("(1) cosh(γ/2) の鎖 2 行目: (cosh γ/2)^2 = 1 + (sinh γ/2)^2", eqI(chg2^2, 1 + shg2^2))
check("(1) cosh(γ/2) の鎖 3→4 行目: 1 + r^2 = 1 + S", eqI(1 + r^2, 1 + S))
check("(1) cosh(γ/2) の鎖 4→5 行目: t^2 = 1 + S（t の定義）", eqI(t^2, 1 + S))
check("(1) sinh γ の鎖: 2 sinh(γ/2)cosh(γ/2) = 2rt", eqI(2 * shg2 * chg2, shg))
check("(1) sinh γ の鎖: (rt)^2 = r^2 t^2 = S(1+S)", eqI((r * t)^2, r^2 * t^2) and eqI(r^2 * t^2, S * (1 + S)))
check("(1) cosh γ の鎖: 1 + 2 sinh^2(γ/2) = 1 + 2r^2 = 1 + 2S", eqI(1 + 2 * shg2^2, 1 + 2 * r^2) and eqI(1 + 2 * r^2, 1 + 2 * S))
check("(1) 半角公式と倍角公式の整合: cosh γ = cosh^2(γ/2) + sinh^2(γ/2)、sinh γ^2 = cosh γ^2 − 1", eqI(chg, chg2^2 + shg2^2) and eqI(shg^2, chg^2 - 1))
check("対照: sinh γ を 2√S（t を落とす）にすると一致しない", not eqI(shg, 2 * r))

# ∂S/∂κ の鎖（10 行）
dshk = D(shk)
LS = [D(S),
      D(shk^2) + D(q),                           # 和（q は θ だけの定数）
      D(shk^2) + 0,                              # 定数関数の導関数 0
      dshk * shk + shk * dshk,                   # 積
      2 * shk * dshk,                            # 交換律と同類項
      2 * shk * chk * QQ(1)/2,                   # 合成・定数倍・sinh' = cosh（3 行をまとめて値で）
      QQ(1)/2 * 2 * shk * chk,                   # 交換律
      QQ(1)/2 * sh]                              # 倍角
check("∂S/∂κ の 2→3 行目: D(q) = 0", D(q) == 0)
for j in range(len(LS) - 1):
    check(f"∂S/∂κ の鎖 {j+1}→{j+2} 行目", eqI(LS[j], LS[j + 1]))
check("∂S/∂κ の合成の行: D(sinh(κ/2)) = sinh'(κ/2)·D(κ/2) で D(κ/2) = 1/2", eqI(dshk, chk * QQ(1)/2))
check("対照: ∂S/∂κ を sinh κ（1/2 を落とす）にすると一致しない", not eqI(D(S), sh))

# ∂γ/∂κ の鎖（12 行）。arcsinh'(r) = 1/√(r^2+1) で、√(r^2+1) = t（r^2 + 1 = 1 + S、t ≥ 0）
check("∂γ/∂κ: r^2 + 1 = t^2（√(r^2+1) を t と書く根拠）", eqI(r^2 + 1, t^2))
dS = D(S)
# 3〜8 行目（合成・(√)'・arcsinh'）は D の作り方（D(r) := D(S)/(2r)）に入っているので、ここでは確かめない。
# それらは check_points_exact.sage で SR の記号微分と点で比べる。ここでは 9 行目の値から先を確かめる。
LG = [2 * ti * (ri / 2) * dS,                    # 9 行目 2·(1/t)·(1/(2r))·∂S/∂κ
      2 * ti * (ri / 2) * (sh / 2),              # 10 行目 上の ∂S/∂κ を代入
      sh * ri * ti / 2]                          # 11 行目 四則で sinh κ/(2rt)
for j in range(len(LG) - 1):
    check(f"∂γ/∂κ の鎖 {j + 9}→{j + 10} 行目", eqI(LG[j], LG[j + 1]))
check("∂γ/∂κ の 11→12 行目: 1/(2rt)·sinh γ = 1（sinh γ = 2rt）", eqI(ri * ti / 2 * shg, 1))
dgam = LG[-1]
check("∂γ/∂κ·sinh γ = sinh κ", eqI(dgam * shg, sh))
check("対照: ∂γ/∂κ を sinh κ/(2 sinh γ) にすると一致しない", not eqI(dgam * shg, sh / 2))

# ∂²γ/∂κ² の鎖（10 行）。∂γ/∂κ = sinh κ·(sinh γ)^{-1}、(sinh γ)^{-1} = ri·ti/2
inv_shg = ri * ti / 2
check("準備: (sinh γ)^{-1}·sinh γ = 1", eqI(inv_shg * shg, 1))
check("準備: D(sinh γ) = cosh γ·∂γ/∂κ（sinh' = cosh と合成。D は γ を通さないので式として確かめる）", eqI(D(shg), chg * dgam))
L2 = [D(sh * inv_shg),                                               # 1 行目
      (D(sh) * shg - sh * D(shg)) * inv_shg^2,                       # 商の微分
      (ch * shg - sh * D(shg)) * inv_shg^2,                          # sinh' = cosh
      (ch * shg - sh * chg * dgam) * inv_shg^2,                      # 合成（sinh'(γ) の値 cosh γ を置く）
      (ch * shg - sh * chg * dgam) * inv_shg^2,                      # sinh' = cosh（値は前の行と同じ）
      (ch * shg - sh * chg * sh * inv_shg) * inv_shg^2,              # ∂γ/∂κ を代入
      ch * shg * inv_shg^2 - sh * chg * (sh * inv_shg) * inv_shg^2,  # 分母の等しい分数の差
      ch * shg * inv_shg^2 - sh * chg * sh * inv_shg^3,              # 分数の積
      ch * inv_shg - sh * chg * sh * inv_shg^3,                      # 約分
      ch * inv_shg - sh^2 * chg * inv_shg^3]                         # 交換律と冪の記法
for j in range(len(L2) - 1):
    check(f"∂²γ/∂κ² の鎖 {j+1}→{j+2} 行目", eqI(L2[j], L2[j + 1]))
check("対照: ∂²γ/∂κ² の第 2 項の符号を + にすると一致しない", not eqI(L2[0], ch * inv_shg + sh^2 * chg * inv_shg^3))

# (3) の鎖（8 行）
a = shk^2
L3 = [shg^2 - sh^2,
      (2 * shg2 * chg2)^2 - (2 * shk * chk)^2,
      4 * shg2^2 * chg2^2 - 4 * shk^2 * chk^2,
      4 * shg2^2 * (1 + shg2^2) - 4 * shk^2 * (1 + shk^2),
      4 * r^2 * (1 + r^2) - 4 * shk^2 * (1 + shk^2),       # sinh(γ/2) = r
      4 * S * (1 + S) - 4 * a * (1 + a),
      4 * (S - a) * (1 + S + a),
      4 * q * (1 + S + a)]
for j in range(len(L3) - 1):
    check(f"(3) の鎖 {j+1}→{j+2} 行目", eqI(L3[j], L3[j + 1]))
check("(3) 因数分解の恒等式 S(1+S) − a(1+a) = (S−a)(1+S+a)（S, a を独立な不定元に）",
      (lambda R2: (lambda s, b: s * (1 + s) - b * (1 + b) == (s - b) * (1 + s + b))(*R2.gens()))(PolynomialRing(QQ, 's,b')))
check("対照: 因数を (S−a)(1+S−a) にすると一致しない", not eqI(L3[4], 4 * (S - a) * (1 + S - a)))

print("RESULT: PASS" if ok else "RESULT: FAIL")
if not ok:
    sys.exit(1)
