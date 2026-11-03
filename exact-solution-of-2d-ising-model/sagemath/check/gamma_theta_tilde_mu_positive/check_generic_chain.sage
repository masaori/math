# 対象ラベル: gamma_theta_tilde_mu_positive
# 背理の鎖 g = cosh t = cosh 0 = (exp 0 + exp(-0))/2 = (exp 0 + exp 0)/2 = (1 + 1)/2 = 1 を、
# 各行の値を QQ 上の不定元（g, cosh t, cosh 0, exp 0, exp(-0)）で持つ有理関数として写し、
# 隣り合う行の差が「その行の根拠の関係」1 本だけで生成したイデアルに入ること（関係なしでは一致しない対照）を確かめる。浮動小数点なし。
load("_prelude.sage")

rep = Report("gamma_theta_tilde_mu_positive: 一般の点の背理の鎖")
P.<g, cg, c0, e0, em0> = PolynomialRing(QQ)   # t = γ(θ~_μ)、cg = cosh t、c0 = cosh 0、e0 = exp 0、em0 = exp(-0)

rows = [
    (g, None),
    (cg, cg - g),                          # arccosh_properties (2): cosh t = g
    (c0, c0 - cg),                         # 仮定 t = 0 の代入: cosh 0 = cosh t
    ((e0 + em0) / 2, c0 - (e0 + em0) / 2), # def_cosh_sinh
    ((e0 + e0) / 2, em0 - e0),             # -0 = 0 により exp(-0) = exp 0
    (P((1 + 1) / 2), e0 - 1),              # scalar_exp_zero（K = ℝ）
    (P(1), None),                          # ℝ の四則
]
names = ["準備の cosh t = g", "仮定 t = 0", "def_cosh_sinh", "-0 = 0", "scalar_exp_zero", "ℝ の四則"]
for j in range(1, len(rows)):
    prev, cur = rows[j - 1][0], rows[j][0]
    relation = rows[j][1]
    if relation is None:
        rep.check(prev == cur, f"第 {j} 行 = 第 {j+1} 行（{names[j-1]}。関係なしで一致）")
    else:
        I = P.ideal([relation])
        rep.check((prev - cur) in I and prev != cur, f"第 {j} 行 = 第 {j+1} 行（{names[j-1]} の関係のイデアルで成り立ち、関係なしでは異なる）")
rep.check(-QQ(0) == 0, "-0 = 0（QQ）")
rep.finish()
