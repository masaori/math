# 対象ラベル: periodicity_of_check_fermi
# 準備の第一（exp(ix) の表示）、第三（cos(-x) = cos x）を使う行、(1) の γ_1・γ_2 の鎖、(3) の γ_1・γ・P̌ の鎖を、一般の点（不定元）で一行ずつ確かめる。
# 各行は本文に書かれた式から別々に組み、隣り合う行の差が「その行の根拠の関係だけ」で生成したイデアルに入ることを見る。
# 関係を使う行では、その関係を外すとイデアルに入らないこと（対照）も見る。浮動小数点なし。
load("_prelude.sage")

rep = Report("periodicity_of_check_fermi: 一般の点での鎖")

K0.<I0> = QuadraticField(-1)
# 不定元: c_1, c_2, s_1, c_2^*, s_2^*、
#  点 x の cos・sin・exp(ix)・exp(-ix)（C, S, E, Ei）、
#  点 x + 2πk_R の cos・sin・exp(i·)・exp(-i·)（Cs, Ss, Es, Esi）、
#  点 -x の cos（Cm）。
R.<c1, c2, s1, c2s, s2s, C, S, E, Ei, Cs, Ss, Es, Esi, Cm> = PolynomialRing(K0)

def euler(Cv, Sv, Ep, Emv):
    """euler_formula_cos_sin の二つの等式を、分母を払った多項式の関係として（2cos = E + E^{-1}、2i sin = E - E^{-1}）。"""
    return [2 * Cv - (Ep + Emv), 2 * I0 * Sv - (Ep - Emv)]

EUL_x = euler(C, S, E, Ei)
EUL_s = euler(Cs, Ss, Es, Esi)
PER_cos = [Cs - C]                         # cos の 2π 周期性
PER_sin = [Ss - S]                         # sin の 2π 周期性

def in_ideal(diff, rels):
    if diff == 0:
        return True
    if not rels:
        return False
    return R.ideal(rels).reduce(diff) == 0

def chain(name, lines, reasons):
    """lines[j] と lines[j+1] の差が reasons[j] のイデアルに入るか。reasons[j] が空でなければ、空のイデアルでは入らないことも見る。"""
    for j in range(len(lines) - 1):
        d = lines[j] - lines[j + 1]
        rep.check(in_ideal(d, reasons[j]), f"{name} 第 {j+1} 行 = 第 {j+2} 行")
        if reasons[j]:
            rep.check(d != 0, f"{name} 第 {j+1} 行 → 第 {j+2} 行の対照: 根拠の関係なしでは一致しない")

# ---- 準備の第一: cos x + i sin x = exp(ix) の鎖 22 行（exp(±ix) を有理関数体の元にして各行を別々に組む） ----
Ft = R.fraction_field()
Ep_, Em_ = Ft(E), Ft(Ei)
T2 = Ft(2)
T2i = T2^-1                                          # multiplicative_group_of_cc の 2_C の逆元
T2Ii = (T2 * I0)^-1                                  # 2_C i の逆元
euler_chain = [
    (Ep_ + Em_) / 2 + I0 * ((Ep_ - Em_) / (2 * I0)),               # euler_formula_cos_sin
    (Ep_ + Em_) * T2i + I0 * ((Ep_ - Em_) * T2Ii),                 # def_complex_quotient を 2 箇所へ
    (Ep_ + Em_) * T2i + (I0 * (Ep_ - Em_)) * T2Ii,                 # 積の結合律（右辺から左辺へ）
    (Ep_ + Em_) * T2i + ((Ep_ - Em_) * I0) * T2Ii,                 # 積の可換律
    (Ep_ + Em_) * T2i + (Ep_ - Em_) * (I0 * T2Ii),                 # 積の結合律
    (Ep_ + Em_) * T2i + (Ep_ - Em_) * T2i,                         # i_times_inverse_of_two_i_is_inverse_of_two_in_cc
    ((Ep_ + Em_) + (Ep_ - Em_)) * T2i,                             # 右からの分配律（右辺から左辺へ）
    ((Ep_ + Em_) + (Ep_ + (-Em_))) * T2i,                          # def_complex_difference
    (Ep_ + (Em_ + (Ep_ + (-Em_)))) * T2i,                          # 和の結合律
    (Ep_ + ((Em_ + Ep_) + (-Em_))) * T2i,                          # 和の結合律（右辺から左辺へ）
    (Ep_ + ((Ep_ + Em_) + (-Em_))) * T2i,                          # 和の可換律
    (Ep_ + (Ep_ + (Em_ + (-Em_)))) * T2i,                          # 和の結合律
    (Ep_ + (Ep_ + 0)) * T2i,                                       # 加法逆元
    (Ep_ + Ep_) * T2i,                                             # 零元
    (1 * Ep_ + 1 * Ep_) * T2i,                                     # 積の単位元を 2 箇所へ（右辺から左辺へ）
    ((1 + 1) * Ep_) * T2i,                                         # 右からの分配律（右辺から左辺へ）
    ((QQ(1) + QQ(1)) * Ep_) * T2i,                                 # real_inclusion_preserves_sum
    (T2 * Ep_) * T2i,                                              # ℝ で 1 + 1 = 2
    (Ep_ * T2) * T2i,                                              # 積の可換律
    Ep_ * (T2 * T2i),                                              # 積の結合律
    Ep_ * 1,                                                       # multiplicative_group_of_cc の逆元 2_C
    Ep_,                                                           # 積の単位元
]
rep.check(I0 * T2Ii == T2i and T2Ii != T2i * I0, "準備 cos x + i sin x の鎖 否定の対照: i(2_C i)^{-1} = 2_C^{-1} だが (2_C i)^{-1} は 2_C^{-1} i ではない（逆元の取り違えを見分ける）")
for k in range(len(euler_chain) - 1):
    rep.check(euler_chain[k] == euler_chain[k + 1], f"準備 cos x + i sin x の鎖 第 {k+1} 行 = 第 {k+2} 行")
# 第 1 行は euler_formula_cos_sin の代入: 2 倍して分母を払った差が EUL_x のイデアルに入る（関係なしでは入らない）
d_first = 2 * (C + I0 * S) - R(2 * euler_chain[0])
rep.check(in_ideal(d_first, EUL_x), "準備 cos x + i sin x の鎖 第 1 行は euler_formula_cos_sin の代入（2 倍した差が関係のイデアルに入る）")
rep.check(d_first != 0, "準備 cos x + i sin x の鎖 第 1 行の対照: 関係なしでは一致しない")
rep.check((Ep_ - Em_) / 2 != (Ep_ - Em_) / (2 * I0), "準備 cos x + i sin x の鎖 否定の対照: 分母の i だけを落とすと等号が崩れる")

# ---- (1) γ_1 の鎖 ----
g1 = lambda cosv: c1 * c2s - s1 * s2s * cosv
chain("(1) γ_1(θ+2πk) の鎖", [g1(Cs), g1(C), g1(C)], [PER_cos, []])

# ---- (1) γ_2 の鎖 ----
def g2_line(expo, cosA, sinA):
    return I0 * expo * s2s * (c1 * cosA - I0 * sinA - s1 * c2)
EXPF_s = [Es - (Cs + I0 * Ss)]   # 準備の exp(ix) の表示を x+2πk で（euler から導かれる）
EXPF_x = [E - (C + I0 * S)]
g2_lines = [
    g2_line(Es, Cs, Ss),
    g2_line(Cs + I0 * Ss, Cs, Ss),
    g2_line(C + I0 * Ss, C, Ss),
    g2_line(C + I0 * S, C, S),
    g2_line(E, C, S),
    g2_line(E, C, S),
]
chain("(1) γ_2(θ+2πk) の鎖", g2_lines, [EXPF_s, PER_cos, PER_sin, EXPF_x, []])
# 準備の表示 exp(ix) = cos x + i sin x が euler の二つの式から出ること（上の EXPF の根拠）
rep.check(in_ideal(2 * (Es - (Cs + I0 * Ss)), EUL_s) and in_ideal(2 * (E - (C + I0 * S)), EUL_x),
          "(1) の EXPF の関係は euler_formula_cos_sin の関係のイデアルに入る")

# ---- (3) γ_1(θ~_ν) の鎖（θ = -θ~_μ を x = -θ~_μ と読むと、-θ~_μ + 2π の値は Cs、-θ~_μ の値は Cm、θ~_μ の値は C） ----
chain("(3) γ_1(θ~_ν) の鎖", [g1(Cs), g1(Cm), g1(Cm), g1(C), g1(C)],
      [[Cs - Cm], [], [Cm - C], []])
# 第 1 → 2 行の根拠は (1)（cos の周期性）、第 3 → 4 行は準備の第三の ℝ の等式 cos(-x) = cos x
# （本文は cos_of_negated_real と inclusion_rr_to_cc_is_injective から作る。cos_of_negated_real の鎖は sagemath/check/cos_of_negated_real/ が確かめる）

# ---- (3) γ(θ~_ν): arccosh は値 γ_1 だけの関数。arccosh を未解釈の関数記号として不定元の上で ----
Ac = function('arccosh_sym')
G1 = SR.var('G1nu'); G1m = SR.var('G1mu')
gam_chain = [Ac(G1), Ac(G1m), Ac(G1m)]
rep.check(bool(gam_chain[0].subs({G1: G1m}) == gam_chain[1]), "(3) γ(θ~_ν) の鎖 第 1 → 2 行: γ_1(θ~_ν) = γ_1(θ~_μ) を代入")
rep.check(bool(gam_chain[0] != gam_chain[1]), "(3) γ(θ~_ν) の鎖の対照: 代入なしでは別の式")

# ---- (3) P̌_ν の鎖: 成分を不定元 A = γ_2(θ~_ν), B = γ_2(-θ~_ν), a = γ_2(θ~_μ), b = γ_2(-θ~_μ)、絶対値は |·| の記号のまま ----
S2.<A, B, a, b, absA, absb, rM> = PolynomialRing(QQ)
F2 = S2.fraction_field()
def P_of(absTop, bottom):
    return matrix(F2, [[-absTop / (2 * rM * bottom), absTop / (2 * rM * bottom)], [1 / (2 * rM), 1 / (2 * rM)]])
P_lines = [P_of(absA, B), P_of(absb, B), P_of(absb, a)]
rep.check(P_lines[0].subs({absA: absb}) == P_lines[1], "(3) P̌_ν の鎖 第 1 → 2 行: |γ_2(θ~_ν)| = |γ_2(-θ~_μ)| を 2 箇所へ代入")
rep.check(P_lines[1].subs({B: a}) == P_lines[2], "(3) P̌_ν の鎖 第 2 → 3 行: γ_2(-θ~_ν) = γ_2(θ~_μ) を 2 箇所へ代入")
rep.check(P_lines[0] != P_lines[1] and P_lines[1] != P_lines[2], "(3) P̌_ν の鎖の対照: 代入なしでは別の行列")
S3.<aa, bb, abs_a, abs_b, sM3> = PolynomialRing(QQ)
F3 = S3.fraction_field()
P_mu_formula = matrix(F3, [[-abs_a / (2 * sM3 * bb), abs_a / (2 * sM3 * bb)], [1 / (2 * sM3), 1 / (2 * sM3)]])
swapped = P_mu_formula.subs({aa: bb, bb: aa, abs_a: abs_b, abs_b: abs_a})
to_F2 = {aa: a, bb: b, abs_a: absA, abs_b: absb, sM3: rM}
claim_matrix = matrix(F2, 2, 2, [F2(e.numerator().subs(to_F2)) / F2(e.denominator().subs(to_F2)) for e in swapped.list()])
rep.check(claim_matrix == P_lines[2], "(3) P̌_ν の最終行は、P̌_μ の式で γ_2(θ~_μ) ↔ γ_2(-θ~_μ)（|·| も）を入れ替えた行列に等しい")

rep.finish()
