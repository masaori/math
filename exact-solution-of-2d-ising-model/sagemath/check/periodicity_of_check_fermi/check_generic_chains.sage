# 対象ラベル: periodicity_of_check_fermi
# 準備の第一（cos(-x) と exp(ix) の表示）、(1) の γ_1・γ_2 の鎖、(3) の γ_1・γ・P̌ の鎖を、一般の点（不定元）で一行ずつ確かめる。
# 各行は本文に書かれた式から別々に組み、隣り合う行の差が「その行の根拠の関係だけ」で生成したイデアルに入ることを見る。
# 関係を使う行では、その関係を外すとイデアルに入らないこと（対照）も見る。浮動小数点なし。
load("_prelude.sage")

rep = Report("periodicity_of_check_fermi: 一般の点での鎖")

K0.<I0> = QuadraticField(-1)
# 不定元: c_1, c_2, s_1, c_2^*, s_2^*、
#  点 x の cos・sin・exp(ix)・exp(-ix)（C, S, E, Ei）、
#  点 x + 2πk_R の cos・sin・exp(i·)・exp(-i·)（Cs, Ss, Es, Esi）、
#  点 -x の cos・exp(i·)・exp(-i·)（Cm, Em, Emi）。
R.<c1, c2, s1, c2s, s2s, C, S, E, Ei, Cs, Ss, Es, Esi, Cm, Em, Emi> = PolynomialRing(K0)

def euler(Cv, Sv, Ep, Emv):
    """euler_formula_cos_sin の二つの等式を、分母を払った多項式の関係として（2cos = E + E^{-1}、2i sin = E - E^{-1}）。"""
    return [2 * Cv - (Ep + Emv), 2 * I0 * Sv - (Ep - Emv)]

EUL_x = euler(C, S, E, Ei)
EUL_s = euler(Cs, Ss, Es, Esi)
EUL_m = euler(Cm, S, Em, Emi)[:1]          # -x では cos の式だけを使う
ARG_m = [Em - Ei, Emi - E]                 # ℂ の四則 i(-x) = -ix、-i(-x) = ix（exp の引数が同じ）
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

# 分数を払う: 本文の (·)/2 は 2 倍して比べる。i/(2i) = 1/2 は K0 の中で確かめる。
rep.check(I0 / (2 * I0) == K0(1) / 2, "ℂ の四則 i/(2i) = 1/2")

# ---- 準備の第一: cos(-x) の鎖（2 倍した形） ----
chain("準備 cos(-x) の鎖（2 倍）",
      [2 * Cm, Em + Emi, Em + Emi, Ei + E, E + Ei, 2 * C],
      [EUL_m, [], ARG_m, [], EUL_x])
# 第 2 → 3 行（(-x)_C = -x_C）は exp の引数の書き方を変えるだけで、この多項式環では同じ元。中身は下の対の計算
rep.check((-QQ(5), QQ(0)) == tuple(-v for v in (QQ(5), QQ(0))), "(-x)_C = (-x,0) = -(x,0)（x = 5 の対で。成分ごとの符号）")

# ---- 準備の第一: cos x + i sin x = exp(ix)（2 倍した形） ----
chain("準備 cos x + i sin x の鎖（2 倍）",
      [2 * (C + I0 * S), (E + Ei) + I0 * (E - Ei) / I0, (E + Ei) + (E - Ei), 2 * E],
      [EUL_x, [], []])

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
      [[Cs - Cm], [], [2 * Cm - 2 * C], []])
# 第 1 → 2 行の根拠は (1)（cos の周期性）、第 3 → 4 行は準備の cos(-x) = cos x（2 倍した関係）

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
