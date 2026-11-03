# 対象ラベル: det_A_theta_tilde
# 具体の結合定数と全ての μ で、鎖の全ての行と主張の四つの等式を厳密に確かめる。
# 行の式は _chains.sage の一般の点の式に、本文の定義どおりに作った値を代入して得る（行どうしを同じ値から写さない）。
# γ_1, γ_2, γ_2(-θ), A(θ) は円分体 F = Q(ζ_{4M}) の元。r = |γ_2| を含む鎖の行は F に r を r^2 = γ_2 conj(γ_2) で添えた商環で、
# 主張の |γ_2|・λ_± の値は AA（実代数的数）で計算する。浮動小数点なし。
load("_prelude.sage")
load("_chains.sage")

rep = Report("det_A_theta_tilde: 具体の値と主張")

# ---- 準備の第三: 双曲線の三つの関係（Y = exp(2K_1)、Z = exp(2K_2)、X = exp(2K_2^*) を不定元に） ----
Qy.<Yv> = FunctionField(QQ)
Qz.<Zv> = FunctionField(QQ)
cosh_e = lambda E: (E + 1 / E) / 2      # def_cosh_sinh: cosh x = (exp(x) + exp(-x))/2、E = exp(x)
sinh_e = lambda E: (E - 1 / E) / 2
c1, s1 = cosh_e(Yv), sinh_e(Yv)
rep.check(c1**2 - s1**2 == 1, "c_1^2 - s_1^2 = (cosh 2K_1)^2 - (sinh 2K_1)^2 = 1（exp(2K_1) を不定元に）")
Xv = (Zv + 1) / (Zv - 1)               # def_second_dual_coupling_constant: exp(2K_2^*) = coth K_2
c2, s2, c2s, s2s = cosh_e(Zv), sinh_e(Zv), cosh_e(Xv), sinh_e(Xv)
rep.check(c2s**2 - s2s**2 == 1, "(c_2^*)^2 - (s_2^*)^2 = 1（exp(2K_2) を不定元に）")
rep.check(s2s == 1 / s2 and c2s == c2 / s2 and c2s == s2s * c2, "duality_c2_star_eq_s2_star_c2: s_2^* = 1/s_2、c_2^* = c_2/s_2 = s_2^* c_2")
rep.check(c2 * s2s == s2s * c2 and c2 * s2s == c2s, "c_2 s_2^* の鎖: c_2 s_2^* = s_2^* c_2 = c_2^*")

def defA(F, I_, Ep, Em, co, si, k):
    """def_A_theta の A(θ)（実数は QQ の元として F に入れる）。"""
    c1, s1, c2, c2s, s2s = k['c1'], k['s1'], k['c2'], k['c2s'], k['s2s']
    return matrix(F, [[c1 * c2s - s1 * s2s * co, I_ * Ep * s2s * (c1 * co - I_ * si - s1 * c2)],
                      [-(I_ * Em * s2s * (c1 * co + I_ * si - s1 * c2)), c1 * c2s - s1 * s2s * co]])

n_cases = 0
fail = {}
def tick(ok, key):
    if not ok:
        fail[key] = fail.get(key, 0) + 1
    else:
        fail.setdefault(key, 0)

for (Yq, Zq) in COUPLINGS:
    k = couplings(Yq, Zq)
    for M in M_RANGE:
        for mu in range(1, M + 1):
            n_cases += 1
            F, I_, Ep, Em, co, si = cyclotomic_angle(M, mu)
            # γ_1, γ_2 は def_gamma1_gamma2_of_theta の定義式。γ_2(-θ) は -θ での定義式（cos(-θ)・sin(-θ) は Euler の式を -θ で）
            g1 = k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * co
            g2 = I_ * Ep * k['s2s'] * (k['c1'] * co - I_ * si - k['s1'] * k['c2'])
            co_m = (Em + Ep) / 2; si_m = (Em - Ep) / (2 * I_)
            g2m = I_ * Em * k['s2s'] * (k['c1'] * co_m - I_ * si_m - k['s1'] * k['c2'])
            A = defA(F, I_, Ep, Em, co, si, k)
            # def_gamma1_gamma2_of_theta の主張（A(θ) の γ の形）
            tick(A == matrix(F, [[g1, g2], [-g2m, g1]]), "def_gamma1_gamma2_of_theta: A(θ) = [[γ_1, γ_2], [-γ_2(-θ), γ_1]]")
            # 準備の第一の値
            tick(I_ * I_ == -1, "ii = -1")
            tick(Ep * Em == 1, "e_+e_- = 1")
            tick(co**2 + si**2 == 1, "u^2 + v^2 = 1")
            if M <= 4:   # Sage 組み込みの cos・sin の QQbar への変換が重いので M_col ≤ 4 だけ
                tick(QQbar(co) == QQbar(cos(pi * (2 * mu - 1) / M)) and QQbar(si) == QQbar(sin(pi * (2 * mu - 1) / M)),
                     "Euler の式の cos・sin が Sage 組み込みの cos・sin と一致（M_col ≤ 4）")
            # 鎖の全ての行に値を代入する。r = |γ_2| を含む鎖は、F に r を r^2 = N := γ_2 conj(γ_2)（∈ F の実部分体）で添えた
            # 商環 F[x]/(x^2 - N) で評価する（その鎖に割り算は無い）。主張の不等号・AA の値は最後に AA で確かめる。
            N = g2 * g2.conjugate()
            Px.<x> = PolynomialRing(F)
            Q = Px.quotient(x**2 - N)
            rq = Q(x)
            a0 = k['c1'] * co - k['s1'] * k['c2']
            # 一般の (x, y) の鎖（(x - iy)(x + iy)、(x - y)^2）には x = a_0, y = v を入れる
            vals_F = [I_, Ep, Em, k['c1'], k['s1'], k['c2'], k['c2s'], k['s2s'], co, si, a0, g1, g2, g2m, A[1, 0], F(0), F(0), F(0), a0, si]
            vals_Q = [Q(w) for w in vals_F[:15]] + [rq, Q(g1) + rq, Q(g1) - rq, Q(a0), Q(si)]
            for (name, ch) in CHAINS:
                use_r = name.startswith("第 3") or name.startswith("最後")
                vals = vals_Q if use_r else vals_F
                ev = []
                for (e, _) in ch:
                    d = e.denominator()(*vals)
                    ev.append(e.numerator()(*vals) * (d**(-1) if not use_r else 1))
                    if use_r:
                        assert d == 1
                for j in range(1, len(ev)):
                    tick(ev[j - 1] == ev[j], f"{name} 第 {j} 行 = 第 {j+1} 行")
            # 主張
            tick(A[0, 0] * A[1, 1] - A[0, 1] * A[1, 0] == 1 and A.det() == 1, "主張: det A(θ~_μ) = 1（def_det_two_by_two と Sage の det）")
            tick(g1**2 + g2 * g2m == 1, "主張: γ_1^2 + γ_2(θ~)γ_2(-θ~) = 1")
            tick(g2 * g2m == -N, "relation_of_gamma_2_theta_tilde (2): γ_2γ_2(-θ) = -|γ_2|^2（|γ_2|^2 = γ_2 conj(γ_2)）")
            r = AA(QQbar(N)).sqrt()
            assert r > 0 and r**2 == AA(QQbar(N))
            G1 = AA(QQbar(g1))
            lp, lm = G1 + r, G1 - r
            tick(lp * lm == 1, "主張: λ_+λ_- = 1（AA）")
            tick(G1**2 == 1 + r**2, "主張: γ_1^2 = 1 + |γ_2|^2（AA）")
            # λ_± は A(θ) の固有値: 特性多項式 t^2 - tr(A) t + det(A) が (t - λ_+)(t - λ_-) = t^2 - 2γ_1 t + (γ_1^2 - r^2) と一致
            cp = A.charpoly()
            tick(cp[1] == -2 * g1 and cp[0] == g1**2 - N, "λ_± = γ_1 ± |γ_2| は A(θ) の特性多項式の根")

for key, nf in fail.items():
    rep.check(nf == 0, f"{key}（{n_cases} 組のうち不一致 {nf}）")
rep.check(n_cases == len(COUPLINGS) * sum(M for M in M_RANGE), f"組の数 {n_cases}")
rep.finish()
