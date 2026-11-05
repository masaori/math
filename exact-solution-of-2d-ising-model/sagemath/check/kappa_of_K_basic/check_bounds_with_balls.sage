# 対象ラベル: kappa_of_K_basic
# (4)・(5) の不等式の鎖、端点の式、数値の評価、(1) の狭義単調増加と h の単調減少に使う (R4) の行を確かめる。
# - 「Q の四則と大小」の行: QQ で厳密に（浮動小数点なし）。
# - ℝ への脱出（RealBallField(256)）: cosh(1/5)・sinh(1/5)・sinh(2K_c ± 1/5) と、具体の K での主張。
#   cosh・sinh の値は本文の exp の部分和に尾の評価を半径として足したボール（body_real_exp_ball）から作る。
#   exp(2K_c) = 1 + √2 は AA で厳密に持ち、ボールにするだけ。K_c ± 1/10 の端点は exp(2K) = (1 + √2)exp(±1/5) で作る。
#   κ(K) = 2K − 2K^* = log(exp(2K) tanh K) = log(w(w − 1)/(w + 1))（w = exp(2K)）の log は Arb の log
#   （本文の log は exp の逆写像で、本文の exp は標準の exp に等しい）。積分は Arb の数値積分（ComplexBallField.integral）
#   で囲み、(R4) を当てた行の両辺が重なることだけを見る。判定の決まりは sagemath/_shared/isotropic_balls.sage。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/isotropic_balls.sage")
def le(x, y):              # x ≤ y が確かに成り立つ、または両辺が等しい
    return bool(RB(x) <= RB(y)) or is_zero(RB(x) - RB(y)) is True
def dec(t):
    i, f = t.split('.')
    return QQ(Integer(i + f)) / 10^len(f)

# ---- 準備: 数値の評価（remark_real_analysis_escape_chapter_E が持ち込むもの）
c5, s5 = bcosh(QQ(1)/5), bsinh(QQ(1)/5)
check("数値の評価 1.02006 ≤ cosh(1/5) ≤ 1.020067", dec('1.02006') <= c5 and c5 <= dec('1.020067'))
check("数値の評価 0.201336 ≤ sinh(1/5) ≤ 0.2013361", dec('0.201336') <= s5 and s5 <= dec('0.2013361'))
check("対照: cosh(1/5) ≤ 1.020066 は成り立たない", not (c5 <= dec('1.020066')))
check("対照: sinh(1/5) ≤ 0.2013360 は成り立たない（0.201336 < sinh(1/5)）", not (s5 <= dec('0.201336')))
r2 = AA(2).sqrt(); wc = 1 + r2
R2 = RB(r2)
# ---- 端点の式 sinh(2K_c ± 1/5) = cosh(1/5) ± √2 sinh(1/5)、cosh(2K_c − 1/5) = √2 cosh(1/5) − sinh(1/5)
for sg in [1, -1]:
    wq = RB(wc) * bexp(sg * QQ(1)/5)                    # exp(2K_c ± 1/5)
    lhs = (wq - 1/wq) / 2                                # sinh の定義
    eq(lhs, (RB(wc - 1/wc) / 2) * c5 + sg * (RB(wc + 1/wc) / 2) * s5, f"端点の式 1 行目（sinh_addition_formula）sg={sg}")
    eq(lhs, c5 + sg * R2 * s5, f"端点の式 2 行目 = cosh(1/5) {'+' if sg > 0 else '−'} √2 sinh(1/5)")
    ne(lhs, c5 - sg * R2 * s5, f"対照 端点の式の複号を逆にすると一致しない sg={sg}")
wm = RB(wc) * bexp(-QQ(1)/5)
cosh_m = (wm + 1/wm) / 2
sinh_m = (wm - 1/wm) / 2
eq(cosh_m, (RB(wc + 1/wc)/2) * c5 - (RB(wc - 1/wc)/2) * s5, "cosh(2K_c − 1/5) 1 行目（cosh_addition_formula の複号 −）")
eq(cosh_m, R2 * c5 - s5, "cosh(2K_c − 1/5) 2 行目 = √2 cosh(1/5) − sinh(1/5)")

# ---- (4) の鎖の各行（下界）。QQ の行は厳密、他はボールで
lo = [sinh_m, c5 - R2 * s5, dec('1.02006') - R2 * s5, dec('1.02006') - dec('1.414214') * s5,
      RB(dec('1.02006') - dec('1.414214') * dec('0.2013361'))]
for j in range(4):
    check(f"sinh 2K の下界の鎖 {j+1}→{j+2} 行目（≥ または =）", lo[j] >= lo[j + 1] or is_zero(lo[j] - lo[j + 1]) is True)
check("sinh 2K の下界の鎖 最後の行（QQ）: 1.02006 − 1.414214·0.2013361 ≥ 0.7353",
      dec('1.02006') - dec('1.414214') * dec('0.2013361') >= dec('0.7353'))
wp = RB(wc) * bexp(QQ(1)/5)
sinh_p = (wp - 1/wp) / 2
up = [sinh_p, c5 + R2 * s5, dec('1.020067') + R2 * s5, dec('1.020067') + dec('1.414214') * s5,
      RB(dec('1.020067') + dec('1.414214') * dec('0.2013361'))]
for j in range(4):
    check(f"sinh 2K の上界の鎖 {j+1}→{j+2} 行目（≤ または =）", up[j] <= up[j + 1] or is_zero(up[j] - up[j + 1]) is True)
check("sinh 2K の上界の鎖 最後の行（QQ）: 1.020067 + 1.414214·0.2013361 ≤ 1.3048",
      dec('1.020067') + dec('1.414214') * dec('0.2013361') <= dec('1.3048'))
check("対照: 上界 1.3047 は QQ の行で成り立たない", not (dec('1.020067') + dec('1.414214') * dec('0.2013361') <= dec('1.3047')))
check("2K_c − 1/5 > 0（sinh(2K_c − 1/5) ≥ 0.7353 > 0 から）: exp(2K_c − 1/5) > 1", wm > 1)
check("κ' の下界の最後の行（QQ）: 2 + 2/1.3048 ≥ 3.53", 2 + 2 / dec('1.3048') >= dec('3.53'))
check("κ' の上界の最後の行（QQ）: 2 + 2/0.7353 ≤ 4.72", 2 + 2 / dec('0.7353') <= dec('4.72'))
cm = [cosh_m, R2 * c5 - s5, dec('1.414214') * c5 - s5, dec('1.414214') * dec('1.020067') - s5,
      RB(dec('1.414214') * dec('1.020067') - dec('0.201336'))]
for j in range(4):
    check(f"cosh(2K_c − 1/5) の上界の鎖 {j+1}→{j+2} 行目", cm[j] <= cm[j + 1] or is_zero(cm[j] - cm[j + 1]) is True)
check("cosh(2K_c − 1/5) の鎖 最後の行（QQ）: 1.414214·1.020067 − 0.201336 ≤ 1.2413",
      dec('1.414214') * dec('1.020067') - dec('0.201336') <= dec('1.2413'))
check("|κ''| の最後の行（QQ）: 4·1.2413/0.7353^2 ≤ 9.19", 4 * dec('1.2413') / dec('0.7353')^2 <= dec('9.19'))
check("|(κ'^2)'| の最後の行（QQ）: 2·4.72·9.19 ≤ 87", 2 * dec('4.72') * dec('9.19') <= 87)
check("(5) の最後の行（QQ）: 4.72·(1/10) = 0.472", dec('4.72') / 10 == dec('0.472'))
check("(5) の最後の行（QQ）: 87/3.53 ≤ 24.7", 87 / dec('3.53') <= dec('24.7'))

# ---- 主張を具体の K で。K は QQ の格子点と端点 K_c ± 1/10
def pt_from_w(w2):            # w2 = exp(2K) のボールから
    sh2 = (w2 - 1/w2) / 2; ch2 = (w2 + 1/w2) / 2
    kap = (w2 * (w2 - 1) / (w2 + 1)).log()
    kp = 2 + 2 / sh2
    kpp = -4 * ch2 / sh2^2
    return dict(sh2=sh2, ch2=ch2, kap=kap, kp=kp, kpp=kpp, dG=2 * kp * kpp)
Kc = RB(wc).log() / 2
pts = []
for K in [dec('0.3407'), dec('0.36'), dec('0.4'), dec('0.44'), dec('0.4407'), dec('0.45'), dec('0.5'), dec('0.54'), dec('0.5406')]:
    d = pt_from_w(bexp(2 * K)); d['dist'] = (RB(K) - Kc).abs(); d['tag'] = f"K={K}"
    # κ(K) = 2K − 2K^*（def_isotropic_kappa_of_K・def_isotropic_dual_coupling）と log(w(w−1)/(w+1)) の一致
    eq(2 * K + btanh(K).log(), d['kap'], f"κ(K) = 2K − 2K^* = log(w(w−1)/(w+1)) {d['tag']}")
    pts.append(d)
for sg in [1, -1]:
    d = pt_from_w(RB(wc) * bexp(sg * QQ(1)/5)); d['dist'] = RB(QQ(1)/10); d['tag'] = f"K=K_c{'+' if sg > 0 else '−'}1/10"
    pts.append(d)
for d in pts:
    t = d['tag']
    check(f"前提 |K − K_c| ≤ 1/10 {t}", le(d['dist'], QQ(1)/10))
    check(f"(4) 0.7353 ≤ sinh 2K ≤ 1.3048 {t}", dec('0.7353') <= d['sh2'] and d['sh2'] <= dec('1.3048'))
    check(f"(4) 3.53 ≤ κ'(K) ≤ 4.72 {t}", dec('3.53') <= d['kp'] and d['kp'] <= dec('4.72'))
    check(f"(4) |κ''(K)| ≤ 9.19 {t}", d['kpp'].abs() <= dec('9.19'))
    check(f"(4) |(κ'^2)'(K)| ≤ 87 {t}", d['dG'].abs() <= 87)
    check(f"(5) 3.53|K − K_c| ≤ |κ(K)| {t}", le(dec('3.53') * d['dist'], d['kap'].abs()))
    check(f"(5) |κ(K)| ≤ 4.72|K − K_c| {t}", le(d['kap'].abs(), dec('4.72') * d['dist']))
    check(f"(5) 4.72|K − K_c| ≤ 0.472 {t}", le(dec('4.72') * d['dist'], dec('0.472')))
    check(f"(5) |κ'(K)^2 − 16| ≤ 24.7|κ(K)| {t}", le((d['kp']^2 - 16).abs(), dec('24.7') * d['kap'].abs()))
# ---- 具体の K で (4) の κ'・|κ''|・|(κ'^2)'| の鎖と (5) の二つの鎖を一行ずつ（K は QQ の格子点。a = min{K,K_c}、b = max{K,K_c}）
CB = ComplexBallField(PREC)
def kap_c(z):  return 2 * z + ((z.exp() - (-z).exp()) / (z.exp() + (-z).exp())).log()
def kp_c(z):   return 2 + 2 / (2 * z).sinh()
def kpp_c(z):  return -4 * (2 * z).cosh() / (2 * z).sinh()^2
def h_c(z):    return z.cosh() / z.sinh()^2
def hp_c(z):   return (-1 - z.cosh()^2) / z.sinh()^3
def chain(rels, vals, name):
    for j, r in enumerate(rels):
        x, y = vals[j], vals[j + 1]
        good = (r == '=' and is_zero(RB(x) - RB(y)) is True) or (r == '<=' and le(x, y)) or (r == '>=' and le(y, x))
        check(f"{name} {j+1}→{j+2} 行目（{r}）", good)
hm = cosh_m / sinh_m^2
KcB = RB(wc).log() / 2
for K in [dec('0.3407'), dec('0.36'), dec('0.4'), dec('0.44'), dec('0.4407'), dec('0.45'), dec('0.5'), dec('0.54'), dec('0.5406')]:
    t = f"K={K}"
    sh2, ch2 = bsinh(2 * K), bcosh(2 * K)
    kp = 2 + 2 / sh2; kpp = -4 * ch2 / sh2^2
    check(f"(4) sinh 2K の下界の鎖 1 行目 sinh 2K ≥ sinh(2K_c − 1/5) {t}", le(sinh_m, sh2))
    check(f"(4) sinh 2K の上界の鎖 1 行目 sinh 2K ≤ sinh(2K_c + 1/5) {t}", le(sh2, sinh_p))
    chain(['=', '>=', '>='], [kp, 2 + 2 / sh2, 2 + 2 / RB(dec('1.3048')), RB(dec('3.53'))], f"(4) κ' の下界の鎖 {t}")
    chain(['=', '<=', '<='], [kp, 2 + 2 / sh2, 2 + 2 / RB(dec('0.7353')), RB(dec('4.72'))], f"(4) κ' の上界の鎖 {t}")
    hK = ch2 / sh2^2
    chain(['=', '=', '<=', '=', '<=', '<=', '<='],
          [kpp.abs(), 4 * ch2 / sh2^2, 4 * hK, 4 * hm, 4 * cosh_m / sinh_m^2, 4 * dec('1.2413') / sinh_m^2,
           RB(4 * dec('1.2413') / dec('0.7353')^2), RB(dec('9.19'))], f"(4) |κ''| の鎖 {t}")
    dG = 2 * kp * kpp
    chain(['=', '<=', '<='], [dG.abs(), 2 * kp * kpp.abs(), RB(2 * dec('4.72') * dec('9.19')), RB(87)], f"(4) |(κ'^2)'| の鎖 {t}")
    # (5): a, b は K と K_c の小さい方と大きい方。積分は Arb で、端点の K_c はボールの中心を使い、K_c のボールの半径ぶんの誤差を足す
    # 端点に QQ の中心 kc_mid を使い、|kc_mid − K_c| ≤ kc_err。被積分関数は区間上で絶対値 87 以下なので、積分の誤差は 87·kc_err 以下
    kc_mid = KcB.mid().exact_rational(); kc_err = 2 * KcB.rad().exact_rational()
    a, b = (QQ(K), kc_mid) if K < kc_mid else (kc_mid, QQ(K))
    dist = (RB(K) - KcB).abs()
    I_kp = CB.integral(lambda z, _: kp_c(z), a, b).real().add_error(RB(87 * kc_err).upper())
    I_353 = CB.integral(lambda z, _: CB(dec('3.53')), a, b).real().add_error(RB(87 * kc_err).upper())
    I_472 = CB.integral(lambda z, _: CB(dec('4.72')), a, b).real().add_error(RB(87 * kc_err).upper())
    kapK = 2 * K + btanh(K).log()
    kapKc = kap_c(CB(KcB)).real()
    kapb, kapa = (kapKc, kapK) if K < kc_mid else (kapK, kapKc)
    chain(['=', '=', '<=', '=', '=', '=', '=', '=', '<=', '=', '=', '<=', '='],
          [dec('3.53') * dist, dec('3.53') * RB(b - a).add_error(RB(kc_err).upper()), I_353, I_kp, kapb - kapa, (kapK - kapKc).abs(), kapK.abs(),
           kapb - kapa, I_kp, I_472, dec('4.72') * RB(b - a).add_error(RB(kc_err).upper()), dec('4.72') * dist, RB(dec('4.72') / 10), RB(dec('0.472'))],
          f"(5) 一つ目の鎖 {t}")
    I_G = CB.integral(lambda z, _: 2 * kp_c(z) * kpp_c(z), a, b).real().add_error(RB(87 * kc_err).upper())
    I_m87 = CB.integral(lambda z, _: CB(-87), a, b).real().add_error(RB(87 * kc_err).upper())
    I_87 = CB.integral(lambda z, _: CB(87), a, b).real().add_error(RB(87 * kc_err).upper())
    ba = RB(b - a).add_error(RB(kc_err).upper())
    chain(['=', '<=', '<=', '='], [-87 * ba, I_m87, I_G, I_87, 87 * ba], f"(5) ∫G' の挟み込みの鎖 {t}")
    GK, GKc = kp^2, kp_c(CB(KcB)).real()^2
    Gb, Ga = (GKc, GK) if K < kc_mid else (GK, GKc)
    chain(['=', '=', '=', '<=', '=', '<=', '<='],
          [(kp^2 - 16).abs(), (GK - GKc).abs(), (Gb - Ga).abs(), I_G.abs(), 87 * ba, 87 * dist, 87 * kapK.abs() / dec('3.53'),
           dec('24.7') * kapK.abs()], f"(5) 二つ目の鎖 {t}")
# K_c での値
d = pt_from_w(RB(wc))
check("κ(K_c) = 0", is_zero(d['kap']) is True)
eq(d['kp'], 4, "κ'(K_c) = 2 + 2/1 = 4")
# 対照: 区間の外では (4) の評価が崩れる
dout = pt_from_w(bexp(2 * dec('0.2')))
check("対照: K = 0.2（|K − K_c| > 1/10）では κ'(K) ≤ 4.72 が成り立たない", not (dout['kp'] <= dec('4.72')))
dout2 = pt_from_w(bexp(2 * dec('0.7')))
check("対照: K = 0.7 では sinh 2K ≤ 1.3048 が成り立たない", not (dout2['sh2'] <= dec('1.3048')))

# ---- (R4) を当てた行: ∫_a^b κ' = κ(b) − κ(a)、∫_a^b h' = h(b) − h(a)、∫_a^b G' = G(b) − G(a)、定数の積分
for (a, b) in [(dec('0.3407'), dec('0.4407')), (dec('0.4407'), dec('0.5406')), (dec('0.1'), dec('2.0'))]:
    tag = f"[a,b]=[{a},{b}]"
    I = CB.integral(lambda z, _: kp_c(z), a, b)
    eq(I.real(), (kap_c(CB(b)) - kap_c(CB(a))).real(), f"(R4) ∫_a^b κ' = κ(b) − κ(a) {tag}")
    check(f"(1) κ(b) − κ(a) ≥ 2(b − a) > 0 {tag}", I.real() >= 2 * (b - a) and b > a)
    I3 = CB.integral(lambda z, _: CB(dec('3.53')), a, b)
    eq(I3.real(), dec('3.53') * (b - a), f"(R4) 定数の積分 ∫_a^b 3.53 = 3.53(b − a) {tag}")
    Ih = CB.integral(lambda z, _: hp_c(z), a, b)
    eq(Ih.real(), (h_c(CB(b)) - h_c(CB(a))).real(), f"(R4) ∫_a^b h' = h(b) − h(a) {tag}")
    check(f"h(b) ≤ h(a)（h の単調減少）{tag}", (h_c(CB(b)) - h_c(CB(a))).real() < 0)
    IG = CB.integral(lambda z, _: 2 * kp_c(z) * kpp_c(z), a, b)
    eq(IG.real(), (kp_c(CB(b))^2 - kp_c(CB(a))^2).real(), f"(R4) ∫_a^b G' = G(b) − G(a)（G = κ'^2）{tag}")
finish()
