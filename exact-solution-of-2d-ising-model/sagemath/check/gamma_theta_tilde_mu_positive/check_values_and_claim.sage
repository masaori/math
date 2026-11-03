# 対象ラベル: gamma_theta_tilde_mu_positive
# 具体の結合定数と全ての μ で、γ(θ~_μ) = arccosh(g)（g = γ_1(θ~_μ)）について準備の三つと主張を確かめる。
# def_arccosh より arccosh(g) = log(w)、w := g + √(g^2 - 1) ∈ AA。
#  - 厳密（AA）: g > 1、w ≥ 1、w > 1、cosh(arccosh g) = (w + 1/w)/2 = g（exp(log w) = w を通す。arccosh_properties (2) の当てはめ）。
#  - ℝ への脱出: t = γ(θ~_μ) = log w の値そのものは実対数なので、RealBallField（精度 200 ビットの区間演算）で囲み、t ≥ 0・t > 0 を
#    ボールの下端で確かめる。丸めの誤差はボールの半径に含まれるので、下端が正なら t > 0 は確定する。
load("_prelude.sage")

rep = Report("gamma_theta_tilde_mu_positive: 具体の値と主張")
RB = RealBallField(200)
n_cases = 0
fail = {}
def tick(ok, key):
    fail[key] = fail.get(key, 0) + (0 if ok else 1)

for (Yq, Zq) in COUPLINGS:
    k = couplings(Yq, Zq)
    for M in M_RANGE:
        for mu in range(1, M + 1):
            n_cases += 1
            F, I_, Ep, Em, co, si = cyclotomic_angle(M, mu)
            g1, _ = gamma1_gamma2(k, I_, Ep, co, si)
            g = to_AA(g1)
            tick(g > 1 and g >= 1, "準備: g > 1、g ≥ 1（gamma1_gt_1_theta_tilde の当てはめ）")
            w = g + (g**2 - 1).sqrt()
            tick(w >= 1 and w > 1, "w = g + √(g^2 - 1) は w ≥ 1、w > 1（AA）")
            tick((w + 1 / w) / 2 == g, "準備: cosh t = (exp t + exp(-t))/2 = (w + 1/w)/2 = g（arccosh_properties (2) の当てはめ。AA）")
            gam = RB(w).log()
            tick(gam.lower() >= 0, "準備: t ≥ 0（arccosh_properties (1) の当てはめ。ボールの下端）")
            tick(gam.lower() > 0, "主張: t = γ(θ~_μ) > 0（ボールの下端が正）")
            tick(not gam.contains_zero(), "t = 0 はボールに含まれない（背理の仮定は成り立たない）")

for key, nf in fail.items():
    rep.check(nf == 0, f"{key}（{n_cases} 組のうち不一致 {nf}）")
rep.check(n_cases == len(COUPLINGS) * sum(M for M in M_RANGE), f"組の数 {n_cases}")

# 対照: g = 1（臨界点で θ = 0 の γ_1(0)。gamma1_gt_1_theta_tilde の検算の対照と同じ点）では w = 1、γ = log 1 = 0 で、
# 狭義の不等号は成り立たない。主張が g > 1 に依ることを示す。
k = couplings(2, 3)
K.<ii> = QuadraticField(-1)
g1_0, _ = gamma1_gamma2(k, ii, K(1), K(1), K(0))
g0 = to_AA(g1_0)
w0 = g0 + (g0**2 - 1).sqrt()
rep.check(g0 == 1 and w0 == 1 and RB(w0).log().is_zero(), "対照: g = 1 では w = 1、t = log 1 = 0（狭義の不等号は成り立たない）")
rep.finish()
