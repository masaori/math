# 対象ラベル: def_check_Vprime
# 証明 (1) の 11 行と、有限和の行（X̌ ∈ R）を確かめる。
# 厳密: 添字は整数、係数と行列は L = QQ(ζ_{4M}) と、r_λ・γ(θ~_λ) を不定元 ρ_λ・g_λ に置いた L 上の多項式環 P の成分。
#   各行の行列は本文の成分の式（mat_mult・def_identity_matrix・def_matrix_scalar_multiple・def_matrix_difference・
#   def_finite_sum_of_matrices）で組み、Sage の行列演算で組んだもの（独立な経路）と比べる。
# ℝ への脱出: γ(θ~_μ) ∈ ℝ_{≥0} の行だけ。γ_1(θ~_μ) は L の実の元として厳密に作って AA で γ_1 ≥ 1 を見る。
#   arccosh(γ_1) = log(γ_1 + √(γ_1^2 - 1))（def_arccosh）を RealBallField(512) で囲み、0 以上であることを見る。
# 対照: 共役添字を M_col - μ（1 ずれ）や -μ（整数運動量の共役）にすると 𝓜̌ の外へ出る。
#   γ_2(-θ~_μ) の代わりに分母へ 0 を入れると def_check_fermi の係数が作れない（ZeroDivisionError）。
# 範囲: 1 行目は M_col = 2..40 の全 μ。行列の行は結合定数 4 組 × M_col = 2..5 の全 μ。
load("_prelude.sage")

rep = Report("def_check_Vprime (1): X̌ の各項と X̌ が R の元であること")

# ---- 1 行目: ν := M+1-μ ∈ 𝓜̌（def_check_index_set (2)） ----
for M in range(2, 41):
    Mh = set(range(1, M + 1))
    rep.check(all((M + 1 - mu) in Mh for mu in Mh), f"1 行目 M={M}: μ ∈ 𝓜̌ ⇒ M+1-μ ∈ 𝓜̌", quiet=True)
    rep.check(sorted(M + 1 - mu for mu in Mh) == sorted(Mh), f"1 行目 M={M}: μ ↦ M+1-μ は 𝓜̌ の全単射", quiet=True)
    rep.check(not all((M - mu) in Mh for mu in Mh), f"対照 M={M}: μ ↦ M-μ は 𝓜̌ の外へ出る", quiet=True)
    rep.check(not all((-mu) in Mh for mu in Mh), f"対照 M={M}: μ ↦ -μ は 𝓜̌ の外へ出る", quiet=True)
print("1 行目と対照: M_col = 2..40 で済み")

for M in range(2, 6):
    S = Setting(M)
    L = S.L
    n = S.n
    J = S.J
    P = PolynomialRing(L, [f"rho{l}" for l in J] + [f"g{l}" for l in J])
    rho = {l: P.gen(l - 1) for l in J}
    g = {l: P.gen(M + l - 1) for l in J}
    IP = body_identity(P, n)
    half_C = P(QQ(1) / 2)                     # (1/2)_C = ι(1/2) = (1/2, 0)
    for kk in COUPLINGS:
        k = couplings(*kk)
        a = {l: S.gamma2(+1, l, k) for l in J}
        b = {l: S.gamma2(-1, l, k) for l in J}
        # def_check_fermi の分母 2√M b_λ ≠ 0（relation_of_gamma_2_theta_tilde: b = -conj(a)、a ≠ 0）
        for l in J:
            rep.check(b[l] == -a[l].conjugate() and a[l] != 0 and L(2) * S.s * b[l] != 0,
                      f"ψ̌ の分母 M={M} {kk} λ={l}: b = -conj(a) ≠ 0", quiet=True)
        try:
            fermi_coeffs(L, S, 1, L(1), L(0))
            rep.check(False, f"対照 M={M} {kk}: 分母 0 では係数が作れない")
        except ZeroDivisionError:
            rep.check(True, f"対照 M={M} {kk}: 分母 0 では係数が作れない", quiet=True)
        dag = {}; psi = {}
        for l in J:
            dag[l], psi[l] = fermi_pair(P, S, l, rho[l], b[l])
        terms = []
        for mu in J:
            nv = M + 1 - mu
            # 2・3 行目: ψ̌^†_μ, ψ̌_ν ∈ R
            rep.check(dag[mu].dimensions() == (n, n) and psi[nv].dimensions() == (n, n),
                      f"2・3 行目 M={M} {kk} μ={mu}", quiet=True)
            # 4 行目: 積
            prod_body = body_product(dag[mu], psi[nv])
            rep.check(prod_body.dimensions() == (n, n) and prod_body == dag[mu] * psi[nv],
                      f"4 行目 M={M} {kk} μ={mu}", quiet=True)
            # 5・6・7 行目: I、(1/2)_C、(1/2)_C I
            halfI = body_scalar(half_C, IP)
            rep.check(IP == identity_matrix(P, n) and halfI == (QQ(1) / 2) * identity_matrix(P, n),
                      f"5・6・7 行目 M={M} {kk} μ={mu}", quiet=True)
            # 8 行目: 差
            diff = body_difference(prod_body, halfI)
            rep.check(diff.dimensions() == (n, n) and diff == dag[mu] * psi[nv] - (QQ(1) / 2) * identity_matrix(P, n),
                      f"8 行目 M={M} {kk} μ={mu}", quiet=True)
            # 9 行目: γ(θ~_μ) ∈ ℝ_{≥0}（ℝ への脱出。γ_1 ≥ 1 は厳密、arccosh の値はボール）
            g1 = S.gamma1(mu, k)
            rep.check(g1 == g1.conjugate() and AA(S.emb(g1)) >= 1, f"9 行目 M={M} {kk} μ={mu}: γ_1(θ~_μ) ∈ ℝ, ≥ 1", quiet=True)
            g1b = RB(AA(S.emb(g1)))
            gam = (g1b + (g1b**2 - 1).sqrt()).log()
            rep.check(gam >= 0 and gam.cosh().overlaps(g1b), f"9 行目 M={M} {kk} μ={mu}: arccosh(γ_1) ≥ 0, cosh γ = γ_1", quiet=True)
            # 10・11 行目: (γ)_C (…) ∈ R（γ を不定元 g_μ に置く）
            term = body_scalar(g[mu], diff)
            rep.check(term.dimensions() == (n, n) and term == g[mu] * diff, f"10・11 行目 M={M} {kk} μ={mu}", quiet=True)
            terms.append(term)
        # 最後の行: X̌ ∈ R（有限和）
        Xc = body_finite_sum(terms)
        rep.check(Xc.dimensions() == (n, n) and Xc == sum(terms[1:], terms[0]),
                  f"X̌ ∈ R M={M} {kk}", quiet=True)
        rep.check(Xc != 0, f"X̌ ≠ O（中身のある和） M={M} {kk}", quiet=True)
    print(f"M={M}: 結合定数 4 組の全 μ で済み")

rep.finish()
