# 対象ラベル: eigenvalues_of_inverse_of_check_Vprime（証明の鎖の 2〜4 行目の係数の値）
#   1_C = (exp 0)_C = (exp(−ǧ(ε) + ǧ(ε)))_C = (exp(−ǧ(ε)) exp(ǧ(ε)))_C
# の実数の値を、ǧ(ε) := Σ_μ γ(θ̃_μ)(ε_μ − 1/2) を def_gamma_theta の値で RealBallField(200) の球に置いて確かめる
# （行列の行は check_chain.sage が確かめる。そこでは exp が不定元の冪に置かれていて、この 3 行は値として試されない）。
# γ(θ̃_μ) := arccosh(γ_1(θ̃_μ))、γ_1(θ̃_μ) := cosh(2K_1)cosh(2K_2^*) − sinh(2K_1)sinh(2K_2^*)cos θ̃_μ、K_2^* := −(1/2)log tanh K_2、
# θ̃_μ := 2π(μ − 1/2)/M_col。
# 範囲: M_col = 2..6、(K_1, K_2) の 4 組、全ての ε。
# 帰属: γ(θ̃_μ)・ǧ(ε)・exp の値は ℝ の元（ℝ への脱出: arccosh・log・tanh・cos・exp の値。いずれも極限で定まるので球で囲む）。
# 球の等号は、重なりに加えて両方の半径が 10^{-40} 未満であることを確かめる。
# 否定コントロール: ǧ(ε) が 0 を含まない ε で、exp(ǧ(ε))exp(ǧ(ε)) が 1 と重ならないこと（4 行目の符号を落とすと外れる）。
RB = RealBallField(200)
pi_b = RB.pi()


def K_star_b(K):
    return -(RB(K).tanh().log()) / 2


def gamma_tilde_b(M, mu, K1, K2):
    K2s = K_star_b(K2)
    c1, s1 = (2 * RB(K1)).cosh(), (2 * RB(K1)).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * pi_b * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 >= 1
    return g1.arccosh()


def same(x, y):
    assert x.rad() < 1e-40 and y.rad() < 1e-40
    return x.overlaps(y)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]
ball = 0
negatives = 0
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        gam = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        for eps in cartesian_product([[0, 1]] * M):
            gv = sum((gam[mu] * (RB(eps[mu]) - RB(1) / 2) for mu in range(M)), RB(0))
            vals = [RB(1), RB(0).exp(), (-gv + gv).exp(), (-gv).exp() * gv.exp()]
            for x, y in zip(vals, vals[1:]):
                assert same(x, y), (M, K1, K2, eps)
                ball += 1
            if not gv.contains_zero():
                assert not (gv.exp() * gv.exp()).overlaps(RB(1)), (M, K1, K2, eps)
                negatives += 1
print(f"checked {ball} real lines with balls (M_col = 2..6, 4 coupling pairs), negative controls {negatives}")
print("RESULT: PASS")
