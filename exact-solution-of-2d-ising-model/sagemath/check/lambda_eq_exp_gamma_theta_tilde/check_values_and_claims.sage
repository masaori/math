# 対象ラベル: lambda_eq_exp_gamma_theta_tilde
# 具体の結合定数と全ての μ で、準備 (a)〜(e)・Step 1〜3 の各行・主張を確かめる。
# g = γ_1(θ~_μ)、N = γ_2 conj(γ_2) は円分体 F = Q(ζ_{4M}) の元。r = |γ_2| = √N を F に x^2 = N で添えた体 L（N が F で平方なら L = F）
# の元 rr として持ち、等号はすべて L の中で判定する。順序（>）は L の元 a + b·rr（a, b は F の実の元）を AA の a + b·√N へ移して判定する。
# t = γ(θ~_μ) = arccosh(g) は def_arccosh より log(w)、w := g + √(g^2 - 1)。g^2 - 1 = N を F で確かめたうえで √(g^2 - 1) = √N = rr と置くので
# w = g + rr ∈ L、exp(t) = w・exp(-t) = 1/w（exp ∘ log = id の当てはめ）。cosh t・sinh t は def_cosh_sinh の式 (w ± 1/w)/2 で作る。
#  - 厳密（L・AA）: g > 1、r > 0、g^2 = 1 + r^2、λ_± の定義式、cosh t = g、(sinh t)^2 = r^2、sinh t > 0、sinh t = r、
#    Step 2 の全行、Step 3 の exp(t) > 1 > exp(-t) > 0、主張。
#  - L の中の鎖の各行は w = g + r と置いたことと準備 (d) から代数的に従う。行ごとの根拠の裏付けは check_generic_chains.sage のイデアルの判定が持つ。
#  - ℝ への脱出: t = log w と、w を通らずに g だけから作る t = arccosh(g) を RealBallField(200) のボールで囲み、t > 0、-t < 0、
#    sinh t が +r の側にあること、exp(±t) が g ± r と重なることを確かめる。
load("_prelude.sage")

rep = Report("lambda_eq_exp_gamma_theta_tilde: 具体の値と主張")
RB = RealBallField(200)
n_cases = 0
fail = {}
def tick(ok, key):
    fail[key] = fail.get(key, 0) + (0 if ok else 1)


def adjoin_r(F, N):
    """L = F(√N) と L の中の rr（AA へ移すと非負の √N）、L の元を AA へ移す写像。"""
    rA = to_AA(N).sqrt()
    if N.is_square():
        s = N.sqrt()
        rr = s if to_AA(s) == rA else -s
        L = F
        return L, rr, (lambda e: to_AA(e))
    Px.<x> = PolynomialRing(F)
    L.<rr> = F.extension(x**2 - N)
    def toA(e):
        c = e.list()            # e = c[0] + c[1]·rr
        return to_AA(c[0]) + to_AA(c[1]) * rA
    return L, rr, toA


for (Yq, Zq) in COUPLINGS:
    k = couplings(Yq, Zq)
    for M in M_RANGE:
        for mu in range(1, M + 1):
            n_cases += 1
            F, I_, Ep, Em, co, si = cyclotomic_angle(M, mu)
            g1, g2 = gamma1_gamma2(k, I_, Ep, co, si)
            # γ_2(-θ~_μ): 定義式に exp(-iθ)、cos(-θ) = cos θ、sin(-θ) = -sin θ を入れる
            _, g2m = gamma1_gamma2(k, I_, Em, co, -si)
            N = g2 * g2.conjugate()
            L, rr, toA = adjoin_r(F, N)
            g = L(g1); r = rr
            # 準備
            tick(g1 == g1.conjugate() and to_AA(g1) > 1, "準備 (a): g は実数で g > 1（g ≥ 1）")
            tick(g1**2 - 1 == N, "準備: g^2 - 1 = N（F の中。√(g^2 - 1) = √N = r と置ける）")
            w = g + r                          # exp(t)、t = arccosh(g) = log w（def_arccosh）
            ch = (w + 1 / w) / 2               # cosh t（def_cosh_sinh）
            sh = (w - 1 / w) / 2               # sinh t（def_cosh_sinh）
            tick(ch == g, "準備 (a): cosh t = g（arccosh_properties (2) の当てはめ）")
            wA = toA(w)
            tg = RB(wA).log()
            tick(tg.lower() > 0, "準備 (b): t > 0（ボールの下端）")
            tick(g2 != 0, "準備 (c) の鎖 第 1 行: γ_2(θ~_μ) ≠ 0")
            rA = toA(r)
            tick(rA >= 0 and rA**2 == to_AA(N) and rA != 0 and rA > 0, "準備 (c) の鎖: r ≥ 0、r ≠ 0、r > 0")
            tick(g**2 == 1 + r**2, "準備 (d): g^2 = 1 + r^2")
            disc = -g2 * g2m
            tick(disc == N, "準備 (e): -γ_2(θ~)γ_2(-θ~) = r^2（根号の非負の根は r）")
            lp = g + r; lm = g - r             # eigenvector_of_A_theta_tilde の λ_± = γ_1 ± √(-γ_2γ_2(-θ~))
            # Step 1
            rows = [sh**2, ch**2 - 1, g**2 - 1, (1 + r**2) - 1, r**2]
            tick(all(rows[j] == rows[j + 1] for j in range(4)), "Step 1 の平方の鎖の全行")
            chA = toA(ch); shA = toA(sh)
            tick(chA > shA and shA > 0, "Step 1: cosh t > sinh t かつ sinh t > 0（cosh_sinh_basic_properties (3)）")
            tick(sh == r, "Step 1: sinh t = r")
            # Step 2
            rows_p = [lp, g + r, ch + r, ch + sh, w]
            tick(all(rows_p[j] == rows_p[j + 1] for j in range(4)), "Step 2: λ_+ の鎖の全行（exp(t) = w）")
            rows_m = [lm, g - r, ch - r, ch - sh, 1 / w]
            tick(all(rows_m[j] == rows_m[j + 1] for j in range(4)), "Step 2: λ_- の鎖の全行（exp(-t) = 1/w）")
            lpA = toA(lp); lmA = toA(lm)
            # w = g + r と置くことを通らない独立な照合（ℝ への脱出側）: t = arccosh(g) を g だけから、r を γ_2 だけからボールで作り、
            # sinh t が +r の側にあること（符号の選び方）と exp(±t) が g ± r と重なることを確かめる。
            gB = RB(to_AA(g1)); rB = RB(to_AA(N)).sqrt()
            tB = gB.arccosh()
            tick(tB.lower() > 0, "独立な照合: t = arccosh(g) のボールの下端 > 0")
            tick(tB.sinh().overlaps(rB) and not tB.sinh().overlaps(-rB), "独立な照合: sinh(arccosh g) は +r と重なり -r とは重ならない（Step 1 の符号）")
            tick(tB.exp().overlaps(gB + rB) and (-tB).exp().overlaps(gB - rB), "独立な照合: exp(±arccosh g) は g ± r と重なる（Step 2）")
            # Step 3
            tick((-tg).upper() < 0, "Step 3: -t < 0（ボールの上端）")
            winvA = toA(1 / w)
            tick(wA > 1 and 1 > winvA and winvA > 0, "Step 3: exp(t) > exp(0) = 1 > exp(-t) > 0")
            # 主張
            tick(lpA > 1 and 1 > lmA and lmA > 0 and lpA > lmA, "主張: λ_+ > 1 > λ_- > 0、λ_+ > λ_-")

for key, nf in fail.items():
    rep.check(nf == 0, f"{key}（{n_cases} 組のうち不一致 {nf}）")
rep.check(n_cases == len(COUPLINGS) * sum(M for M in M_RANGE), f"組の数 {n_cases}")

# 対照 1: cosh_sinh_basic_properties (4) の正の条件を外すと a^2 = b^2 から a = b は従わない。a = -r も a^2 = r^2 を満たすが r と異なる。
k = couplings(2, 3)
F, I_, Ep, Em, co, si = cyclotomic_angle(4, 1)
g1, g2 = gamma1_gamma2(k, I_, Ep, co, si)
r = to_AA(g2 * g2.conjugate()).sqrt()
rep.check((-r)**2 == r**2 and -r != r and -r < 0, "対照: a = -r は a^2 = r^2 を満たすが負で r と異なる（正の条件が要る）")
# 対照 2: 臨界点で θ = 0（半整数運動量ではない）では g = 1、r = 0、w = 1 となり λ_+ = λ_- = 1 で分離しない。主張が t > 0 に依ることを示す。
K.<ii> = QuadraticField(-1)
g1_0, g2_0 = gamma1_gamma2(k, ii, K(1), K(1), K(0))
g0 = to_AA(g1_0)
w0 = g0 + (g0**2 - 1).sqrt()
rep.check(g2_0 == 0 and g0 == 1 and w0 == 1 and g0 + 0 == g0 - 0, "対照: θ = 0 では g = 1、r = 0、exp(t) = 1 で λ_+ = λ_- = 1（分離しない）")
rep.finish()
