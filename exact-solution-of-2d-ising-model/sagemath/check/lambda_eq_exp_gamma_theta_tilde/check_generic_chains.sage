# 対象ラベル: lambda_eq_exp_gamma_theta_tilde
# 証明の等号の鎖（Step 1 の平方の鎖、Step 2 の λ_+・λ_- の鎖）を、各行の値を QQ 上の不定元
#   g = γ_1(θ~_μ)、r = |γ_2(θ~_μ)|、ch = cosh t、sh = sinh t、ep = exp(t)、em = exp(-t)、lp = λ_{+,μ}、lm = λ_{-,μ}
# の多項式として本文の式どおりに別々に写し、隣り合う行の差が「その行の根拠の関係」だけで生成したイデアルに入ること、
# かつ関係なしでは一致しないこと（対照）を確かめる。浮動小数点なし。
# 根拠の当てはめの形も確かめる: cosh_sinh_basic_properties (1)(2) が def_cosh_sinh と exp(t)exp(-t) = 1 から従う形であること。
load("_prelude.sage")

rep = Report("lambda_eq_exp_gamma_theta_tilde: 一般の点の等号の鎖")
P.<g, r, ch, sh, ep, em, lp, lm> = PolynomialRing(QQ)

def run_chain(title, rows):
    """rows = [(行の式, 前の行からこの行への根拠の関係のリスト or None, 根拠の名前)]。"""
    for j in range(1, len(rows)):
        prev, cur = rows[j - 1][0], rows[j][0]
        rels, name = rows[j][1], rows[j][2]
        if rels is None:
            rep.check(prev == cur, f"{title} 第 {j} 行 = 第 {j+1} 行（{name}。関係なしで一致）")
        else:
            I = P.ideal(rels)
            rep.check((prev - cur) in I and prev != cur,
                      f"{title} 第 {j} 行 = 第 {j+1} 行（{name} の関係のイデアルで成り立ち、関係なしでは異なる）")

# Step 1: (sinh t)^2 = (cosh t)^2 - 1 = g^2 - 1 = (1 + r^2) - 1 = r^2
run_chain("Step 1", [
    (sh**2, None, ""),
    (ch**2 - 1, [ch**2 - sh**2 - 1], "cosh_sinh_basic_properties (2)"),
    (g**2 - 1, [ch - g], "準備 (a) cosh t = g"),
    ((1 + r**2) - 1, [g**2 - (1 + r**2)], "準備 (d) g^2 = 1 + r^2（det_A_theta_tilde）"),
    (r**2, None, "ℝ の四則"),
])

# Step 2: λ_+ = g + r = cosh t + r = cosh t + sinh t = exp(t) = exp(+t)
run_chain("Step 2 λ_+", [
    (lp, None, ""),
    (g + r, [lp - (g + r)], "準備 (e) λ_+ = g + r（eigenvector_of_A_theta_tilde）"),
    (ch + r, [ch - g], "準備 (a) cosh t = g"),
    (ch + sh, [sh - r], "Step 1 sinh t = r"),
    (ep, [ch + sh - ep], "cosh_sinh_basic_properties (1)"),
    (+ep, None, "+t = t"),
])
# Step 2: λ_- = g - r = cosh t - r = cosh t - sinh t = exp(-t)
run_chain("Step 2 λ_-", [
    (lm, None, ""),
    (g - r, [lm - (g - r)], "準備 (e) λ_- = g - r（eigenvector_of_A_theta_tilde）"),
    (ch - r, [ch - g], "準備 (a) cosh t = g"),
    (ch - sh, [sh - r], "Step 1 sinh t = r"),
    (em, [ch - sh - em], "cosh_sinh_basic_properties (1)"),
])

# 根拠の形: def_cosh_sinh の ch = (ep + em)/2、sh = (ep - em)/2 と ep·em = 1 から (1)(2) が出る
J = P.ideal([2 * ch - (ep + em), 2 * sh - (ep - em), ep * em - 1])
rep.check((ch + sh - ep) in J and (ch - sh - em) in J, "cosh_sinh_basic_properties (1) は def_cosh_sinh の式から従う")
rep.check((ch**2 - sh**2 - 1) in J, "cosh_sinh_basic_properties (2) は def_cosh_sinh の式と exp(t)exp(-t) = 1 から従う")
rep.check((ch**2 - sh**2 - 1) not in P.ideal([2 * ch - (ep + em), 2 * sh - (ep - em)]),
          "対照: exp(t)exp(-t) = 1 なしでは (2) は従わない")
# Step 2 全体: 準備と Step 1 の関係から λ_+ λ_- = 1、λ_+ + λ_- = 2g も従う（det_A_theta_tilde・トレースとの整合）
K = P.ideal([lp - (g + r), lm - (g - r), ch - g, sh - r, g**2 - 1 - r**2])
rep.check((lp * lm - 1) in K and (lp + lm - 2 * g) in K, "整合: 準備から λ_+ λ_- = 1、λ_+ + λ_- = 2g")
rep.finish()
