# 対象ラベル: relation_of_gamma_2_theta_tilde
# 証明の鎖を、一般の点（不定元）で一行ずつ確かめる。各行は本文に書かれた式からそれぞれ別に作り、
# 隣り合う行が「その行の根拠が与える関係だけ」を法として一致することを見る。浮動小数点なし。
load("_prelude.sage")

rep = Report("relation_of_gamma_2_theta_tilde: 一般の点での鎖")

# ---- 準備の第一: cos(-θ)・sin(-θ)・exp(iθ) を exp(±iθ) で書く鎖 ----
K0.<I0> = QuadraticField(-1)
Rt.<t, Ep, Em> = PolynomialRing(K0)
Ft = Rt.fraction_field()

def exp_sym(arg):
    """exp を引数の多項式で引く: 引数が iθ なら Ep、-iθ なら Em（本文の exp(±iθ)）。それ以外は止める。"""
    if arg == I0 * t:
        return Ft(Ep)
    if arg == -I0 * t:
        return Ft(Em)
    raise ValueError(arg)

# i(-θ) = -iθ の鎖 4 行と -i(-θ) = iθ の鎖 2 行（θ は QQ(i)[θ] の不定元。ℝ の元 (-1)θ の像は (-1_C)θ）
m1c = K0(-1)
ineg_chain = [I0 * (-t), I0 * ((-1) * t), I0 * (m1c * t), (I0 * m1c) * t, (m1c * I0) * t, m1c * (I0 * t), -(I0 * t)]
for k in range(len(ineg_chain) - 1):
    rep.check(ineg_chain[k] == ineg_chain[k + 1], f"i(-θ) = -iθ の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(I0 * t != -(I0 * t), "i(-θ) = -iθ の鎖 否定の対照: iθ ≠ -iθ")
nn_chain = [-(I0 * (-t)), -(-(I0 * t)), I0 * t]
for k in range(len(nn_chain) - 1):
    rep.check(nn_chain[k] == nn_chain[k + 1], f"-i(-θ) = iθ の鎖 第 {k+1} 行 = 第 {k+2} 行")
cos_chain = [
    (exp_sym(I0 * (-t)) + exp_sym(-I0 * (-t))) / 2,   # euler_formula_cos_sin を -θ に適用
    (Ft(Em) + exp_sym(-(I0 * (-t)))) / 2,             # 上の i(-θ) = -iθ
    (Ft(Em) + Ft(Ep)) / 2,                           # 上の -i(-θ) = iθ
    (Ft(Ep) + Ft(Em)) / 2,                           # 和の可換律
]
cos_theta = (Ft(Ep) + Ft(Em)) / 2                    # euler_formula_cos_sin
for k in range(len(cos_chain) - 1):
    rep.check(cos_chain[k] == cos_chain[k + 1], f"cos(-θ) の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(cos_chain[-1] == cos_theta, "cos(-θ) の鎖 最終行 = cos θ")

sin_chain = [
    (exp_sym(I0 * (-t)) - exp_sym(-I0 * (-t))) / (2 * I0),
    (Ft(Em) - exp_sym(-(I0 * (-t)))) / (2 * I0),     # 上の i(-θ) = -iθ
    (Ft(Em) - Ft(Ep)) / (2 * I0),                    # 上の -i(-θ) = iθ
    (-(Ft(Ep) - Ft(Em))) / (2 * I0),                 # b - a = -(a - b)
    -((Ft(Ep) - Ft(Em)) / (2 * I0)),                 # (-x)/y = -(x/y)
]
rep.check(Ft(Em) - Ft(Ep) != Ft(Ep) - Ft(Em), "sin(-θ) の鎖 否定の対照: b - a ≠ a - b")
sin_theta = (Ft(Ep) - Ft(Em)) / (2 * I0)
for k in range(len(sin_chain) - 1):
    rep.check(sin_chain[k] == sin_chain[k + 1], f"sin(-θ) の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(sin_chain[-1] == -sin_theta, "sin(-θ) の鎖 最終行 = -sin θ")

euler_chain = [
    (Ft(Ep) + Ft(Em)) / 2 + I0 * ((Ft(Ep) - Ft(Em)) / (2 * I0)),
    (Ft(Ep) + Ft(Em)) / 2 + (I0 * (Ft(Ep) - Ft(Em))) / (2 * I0),   # x(y/z) = (xy)/z
    (Ft(Ep) + Ft(Em)) / 2 + ((Ft(Ep) - Ft(Em)) * I0) / (2 * I0),   # 積の可換律
    (Ft(Ep) + Ft(Em)) / 2 + (Ft(Ep) - Ft(Em)) / 2,                 # (xa)/(ya) = x/y
    ((Ft(Ep) + Ft(Em)) + (Ft(Ep) - Ft(Em))) / 2,                   # x/z + y/z = (x+y)/z
    ((Ft(Ep) + Ft(Em)) + (Ft(Ep) + (-Ft(Em)))) / 2,                # def_complex_difference
    (Ft(Ep) + (Ft(Em) + (Ft(Ep) + (-Ft(Em))))) / 2,                # 和の結合律
    (Ft(Ep) + ((Ft(Em) + Ft(Ep)) + (-Ft(Em)))) / 2,                # 和の結合律
    (Ft(Ep) + ((Ft(Ep) + Ft(Em)) + (-Ft(Em)))) / 2,                # 和の可換律
    (Ft(Ep) + (Ft(Ep) + (Ft(Em) + (-Ft(Em))))) / 2,                # 和の結合律
    (Ft(Ep) + (Ft(Ep) + 0)) / 2,                                   # 加法逆元
    (Ft(Ep) + Ft(Ep)) / 2,                                         # 零元
    (1 * Ft(Ep) + 1 * Ft(Ep)) / 2,                                 # 積の単位元
    ((1 + 1) * Ft(Ep)) / 2,                                        # 分配律
    ((QQ(1) + QQ(1)) * Ft(Ep)) / 2,                                # real_inclusion_preserves_sum
    (2 * Ft(Ep)) / 2,                                              # ℝ で 1 + 1 = 2
    Ft(Ep),                                                        # (2a)/2 = a
]
rep.check((Ft(Ep) - Ft(Em)) / 2 != (Ft(Ep) - Ft(Em)) / (2 * I0), "cos θ + i sin θ の鎖 否定の対照: 分母の i だけを落とすと（分子に i が残ると）等号が崩れる")
for k in range(len(euler_chain) - 1):
    rep.check(euler_chain[k] == euler_chain[k + 1], f"cos θ + i sin θ の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(cos_theta + I0 * sin_theta == euler_chain[0], "cos θ + i sin θ の鎖 第 1 行は euler_formula_cos_sin の代入")

# ---- 準備の第二: ī = -i（実数の対で） ----
i_pair = (QQ(0), QQ(1))
bar_i_chain = [
    cc_conj(i_pair),
    (QQ(0), QQ(-1)),
    cc_mul((QQ(-1), QQ(0)), (QQ(0), QQ(1))),
    cc_mul(iota(-1, QQ), (QQ(0), QQ(1))),
    cc_mul(iota(-1, QQ), i_pair),
    cc_neg(i_pair, QQ),
]
for k in range(len(bar_i_chain) - 1):
    rep.check(bar_i_chain[k] == bar_i_chain[k + 1], f"ī の鎖 第 {k+1} 行 = 第 {k+2} 行")

# ---- 準備の第二: conj(exp(iθ)) = exp(-iθ)（実数の対、cos θ = c, sin θ = s を QQ 上の不定元に） ----
Rcs.<c, s> = PolynomialRing(QQ)
ic = lambda u: iota(u, Rcs)
I_p = (Rcs(0), Rcs(1))
conj_exp_chain = [
    cc_conj(cc_add(ic(c), cc_mul(I_p, ic(s)))),
    cc_add(cc_conj(ic(c)), cc_conj(cc_mul(I_p, ic(s)))),
    cc_add(cc_conj(ic(c)), cc_mul(cc_conj(I_p), cc_conj(ic(s)))),
    cc_add(ic(c), cc_mul(cc_conj(I_p), ic(s))),
    cc_add(ic(c), cc_mul(cc_neg(I_p, Rcs), ic(s))),
    cc_add(ic(c), cc_neg(cc_mul(I_p, ic(s)), Rcs)),          # (-x)y = -(xy)
    cc_sub(ic(c), cc_mul(I_p, ic(s)), Rcs),                   # def_complex_difference
]
for k in range(len(conj_exp_chain) - 1):
    rep.check(conj_exp_chain[k] == conj_exp_chain[k + 1], f"conj(exp(iθ)) の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(conj_exp_chain[-1] == (c, -s), "conj(exp(iθ)) の鎖 最終行 cos θ - i sin θ = (c, -s)（exp_of_negative_i_real_as_cos_minus_i_sin の右辺）")

# ---- 準備の第三・第四: γ_2(-θ) の表示と conj(γ_2(θ)) の鎖（実数の対） ----
# 実数: c1, s1, c2, s2s, c = cos θ, s = sin θ, cm = cos(-θ), sm = sin(-θ)。exp(iθ) = (p, q)、exp(-iθ) = (u, v) は不透明な対。
Rg.<c1, s1, c2, s2s, cc, ss, cm, sm, p, q, u, v> = PolynomialRing(QQ)
ig = lambda a: iota(a, Rg)
Ig = (Rg(0), Rg(1))
eP, eM = (p, q), (u, v)
mul = cc_mul
def sub(a, b): return cc_sub(a, b, Rg)
def neg(a): return cc_neg(a, Rg)
conj = cc_conj

def w_minus(co_, si_):   # c_1 cos - i sin - s_1 c_2
    return sub(sub(mul(ig(c1), ig(co_)), mul(Ig, ig(si_))), mul(ig(s1), ig(c2)))
def gamma_form(e, inner):  # i·e·s_2^*·(inner)、積は ((i e) s) inner
    return mul(mul(mul(Ig, e), ig(s2s)), inner)

def in_ideal(a, b, gens):
    J = Rg.ideal(gens) if gens else Rg.ideal(0)
    return all((a[k] - b[k]) in J for k in range(2))

gm_chain = [
    gamma_form(eM, w_minus(cm, sm)),                                                   # 第 1・2 行（exp(i(-θ)) = exp(-iθ) は引数の等号）
    gamma_form(eM, w_minus(cc, sm)),                                                   # cos(-θ) = cos θ
    gamma_form(eM, sub(sub(mul(ig(c1), ig(cc)), mul(Ig, neg(ig(ss)))), mul(ig(s1), ig(c2)))),  # sin(-θ) = -sin θ
    gamma_form(eM, sub(sub(mul(ig(c1), ig(cc)), neg(mul(Ig, ig(ss)))), mul(ig(s1), ig(c2)))),  # x(-y) = -(xy)
    gamma_form(eM, sub(cc_add(mul(ig(c1), ig(cc)), mul(Ig, ig(ss))), mul(ig(s1), ig(c2)))),    # a - (-b) = a + b
]
rels = [[cm - cc], [sm + ss], [], []]
for k in range(len(gm_chain) - 1):
    rep.check(in_ideal(gm_chain[k], gm_chain[k + 1], rels[k]), f"γ_2(-θ) の鎖 第 {k+2} 行 = 第 {k+3} 行（法: {rels[k]}）")
    if rels[k]:
        rep.check(not in_ideal(gm_chain[k], gm_chain[k + 1], []), f"  対照: 同じ行は関係 {rels[k]} なしでは一致しない")
gamma_minus = gm_chain[-1]

w_plus = w_minus(cc, ss)
w_plus_pos = sub(cc_add(mul(ig(c1), ig(cc)), mul(Ig, ig(ss))), mul(ig(s1), ig(c2)))
bar_i = conj(Ig)
cg_chain = [
    conj(gamma_form(eP, w_plus)),                                                      # 第 1 行
    mul(conj(mul(mul(Ig, eP), ig(s2s))), conj(w_plus)),                                # 積の共役
    mul(mul(conj(mul(Ig, eP)), conj(ig(s2s))), conj(w_plus)),                          # 積の共役
    mul(mul(mul(bar_i, conj(eP)), conj(ig(s2s))), conj(w_plus)),                       # 積の共役
    mul(mul(mul(neg(Ig), conj(eP)), conj(ig(s2s))), conj(w_plus)),                     # ī = -i
    mul(mul(mul(neg(Ig), eM), conj(ig(s2s))), conj(w_plus)),                           # conj(exp(iθ)) = exp(-iθ)
    mul(mul(mul(neg(Ig), eM), ig(s2s)), conj(w_plus)),                                 # 実数の共役
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(conj(sub(mul(ig(c1), ig(cc)), mul(Ig, ig(ss)))), conj(mul(ig(s1), ig(c2))))),   # 差の共役
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(sub(conj(mul(ig(c1), ig(cc))), conj(mul(Ig, ig(ss)))), conj(mul(ig(s1), ig(c2))))),  # 差の共役
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(sub(conj(mul(ig(c1), ig(cc))), mul(bar_i, conj(ig(ss)))), conj(mul(ig(s1), ig(c2))))),  # 積の共役
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(sub(ig(c1 * cc), mul(bar_i, ig(ss))), ig(s1 * c2))),    # 実数の共役を 3 箇所（積は実数の像）
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(sub(ig(c1 * cc), mul(neg(Ig), ig(ss))), ig(s1 * c2))),  # ī = -i
    mul(mul(mul(neg(Ig), eM), ig(s2s)), sub(sub(ig(c1 * cc), neg(mul(Ig, ig(ss)))), ig(s1 * c2))),  # (-x)y = -(xy)
    mul(mul(mul(neg(Ig), eM), ig(s2s)), w_plus_pos),                                   # a - (-b) = a + b
    mul(mul(neg(mul(Ig, eM)), ig(s2s)), w_plus_pos),                                   # (-x)y = -(xy)（x → i）
    mul(neg(mul(mul(Ig, eM), ig(s2s))), w_plus_pos),                                   # (-x)y = -(xy)（x → i exp(-iθ)）
    neg(gamma_form(eM, w_plus_pos)),                                                   # (-x)y = -(xy)（x → i exp(-iθ) s_2^*）
    neg(gamma_minus),                                                                  # γ_2(-θ) の表示
]
cg_rels = {5: [u - p, v + q]}
for k in range(len(cg_chain) - 1):
    g = cg_rels.get(k + 1, [])
    rep.check(in_ideal(cg_chain[k], cg_chain[k + 1], g), f"conj(γ_2(θ)) の鎖 第 {k+1} 行 = 第 {k+2} 行（法: {g}）")
    if g:
        rep.check(not in_ideal(cg_chain[k], cg_chain[k + 1], []), "  対照: 同じ行は関係なしでは一致しない")
rep.check(mul(ig(c1), ig(cc)) == ig(c1 * cc) and mul(ig(s1), ig(c2)) == ig(s1 * c2), "real_inclusion_preserves_product: c_1 cos θ・s_1 c_2 は実数の像")

# ---- (1)(2) の鎖、γ_2(-θ) ≠ 0 の背理の鎖、(4)(5) の末尾（一般の点） ----
Rz.<x, y, g0, r0> = PolynomialRing(QQ)
iz = lambda a: iota(a, Rz)
Z_ = (x, y)
rep.check(cc_neg(cc_neg(Z_, Rz), Rz) == Z_, "(1) 第 1 行: -(-z) = z（ℂ で -(-z) = z を右辺から左辺へ）")
abs2 = x**2 + y**2                       # abs_basic_properties (2)
m1 = iz(-1)
two_chain = [
    cc_mul(Z_, cc_neg(cc_conj(Z_), Rz)),
    cc_mul(Z_, cc_mul(m1, cc_conj(Z_))),
    cc_mul(cc_mul(Z_, m1), cc_conj(Z_)),
    cc_mul(cc_mul(m1, Z_), cc_conj(Z_)),
    cc_mul(m1, cc_mul(Z_, cc_conj(Z_))),
    cc_mul(m1, cc_mul(cc_conj(Z_), Z_)),
    cc_mul(m1, iz(abs2)),
    iz((-1) * abs2),
    iz(-abs2),
]
for k in range(len(two_chain) - 1):
    rep.check(two_chain[k] == two_chain[k + 1], f"(2) の鎖 第 {k+1} 行 = 第 {k+2} 行")
rep.check(cc_mul(cc_conj(Z_), Z_) == iz(abs2), "complex_conjugate_times_self: conj(z) z = (|z|^2)_C")
dbl = [Z_, (x, -(-y)), cc_conj((x, -y)), cc_conj(cc_conj(Z_))]
for k in range(len(dbl) - 1):
    rep.check(dbl[k] == dbl[k + 1], f"背理の鎖 第 {k+1} 行 = 第 {k+2} 行（二重の共役）")
zero = iz(0)
rep.check(cc_neg(zero, Rz) == cc_mul(m1, zero), "背理の鎖: -0_C = (-1_C)0_C（multiply_by_minus_one）")
rep.check(cc_mul(m1, zero) == zero, "背理の鎖: (-1_C)0_C = 0_C（complex_times_zero_is_zero）")
rep.check(cc_conj(zero) == zero, "背理の鎖: conj(0_C) = 0_C")
Pz = (g0, x)   # γ_2(θ)γ_2(-θ) を一般の対で
rep.check(cc_neg(Pz, Rz) == cc_mul(m1, Pz), "(4) の準備 第 1 行: -z = (-1_C) z")
rep.check(cc_mul(iz(-1), iz(-r0)) == iz((-1) * (-r0)) and iz((-1) * (-r0)) == iz(r0), "(4) の準備 第 3・4 行: (-1_C)(-r)_C = ((-1)(-r))_C = r_C")
five_tail = [
    (g0 * 0, g0 * 1),
    (0 * g0, 1 * g0),                      # 積の可換律を 2 成分へ
    (0 * g0 - 0, 1 * g0),                  # a - 0 = a
    (0 * g0 - 1 * 0, 1 * g0),              # x·0 = 0（x → 1）
    (0 * g0 - 1 * 0, 0 + 1 * g0),          # 0 + a = a
    (0 * g0 - 1 * 0, 0 * 0 + 1 * g0),      # 0·x = 0（x → 0）
    cc_mul((Rz(0), Rz(1)), iz(g0)),        # definition_of_cc の積
]
for k in range(len(five_tail) - 1):
    rep.check(five_tail[k] == five_tail[k + 1], f"(5) の鎖 (|γ|·0, |γ|·1) から (0,1)(|γ|,0) までの第 {k+1} 段")
rep.check(cc_mul((Rz(1), Rz(0)), iz(g0)) != (Rz(0), g0), "(5) 否定の対照: (1,0)(|γ|,0) は (0,|γ|) にならない")
rep.check(iz(g0) == (g0, Rz(0)), "(5) の鎖 最後の行: (|γ|, 0) = |γ|_C")
rep.check(cc_mul(iz(g0), (Rz(1), Rz(0))) == (g0, Rz(0)) and (g0 * 1, g0 * 0) == (g0, g0 * 0) and (g0, g0 * 0) == (g0, 0), "(4) 第 9〜11 行: (|γ|·1, |γ|·0) = (|γ|, |γ|·0) = (|γ|, 0)")

rep.finish()
