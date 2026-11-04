# 対象ラベル: epsilon_anticommutes_with_check_Z_Y（主張 (3) と証明の (3) の鎖、係数を不定元にしたもの）
# (3) の鎖の 10 行（9 個の等号）を、Ψ := pŽ_μ + qY̌_μ の係数 p, q を L := QQ(ζ_{4M}) 上の多項式環 L[p, q] の不定元として、
# 行の括弧どおりに本文の定め方で組んで隣と比べる。Ž_μ・Y̌_μ は結合定数に依らないので（def_half_integer_checkZ・def_half_integer_checkY）、
# 不定元 p, q の等号は、def_check_fermi の二つの組（ψ̌_μ^† と ψ̌_μ）の係数を全ての K_1, K_2 について一度に確かめる。
# 範囲: M_col = 2, 3, 4、全ての μ ∈ M̌。
# 否定コントロール: ε の代わりに σ_1^z を入れると、(2) を引く行（4 行目 → 5 行目）だけが外れる。
load("../../_shared/half_integer_check_operators.sage")
load("_prelude.sage")

rep = Report("epsilon_anticommutes_with_check_Z_Y (3): εΨ = -(Ψε) の鎖（p, q は不定元）")
for M in range(2, 5):
    S0 = Setting(M)
    L = S0.L
    R2 = PolynomialRing(L, ['p', 'q'])
    p, q = R2.gens()
    toR = lambda A: A.apply_map(lambda e: R2(L(e.constant_coefficient())), R2)
    E = toR(to_ring(epsilon(M), L, S0.zeta, S0.P))
    G = toR(to_ring(site(M, 1, 'z'), L, S0.zeta, S0.P))
    for mu in range(1, M + 1):
        Zc, Yc = toR(S0.checkZ(mu)), toR(S0.checkY(mu))
        Psi = body_sum(body_scalar(p, Zc), body_scalar(q, Yc))
        rep.check(Psi == p * Zc + q * Yc, f"M={M} μ={mu}: Ψ = pŽ + qY̌（Sage の積と和）")
        rep.chain(chain_part3(E, Zc, Yc, p, q, Psi), f"M={M} μ={mu}")
        rep.check(E * Psi == -(Psi * E), f"M={M} μ={mu}: 主張 (3) εΨ = -(Ψε)（Sage の積）")
        bad = failing_steps(chain_part3(G, Zc, Yc, p, q, Psi))
        rep.negative(bad == [3], f"M={M} μ={mu}: σ_1^z では (2) を引く行だけが外れる（外れた行: {bad}）")
    print(f"  M_col={M}: 済（累計 {rep.n} 件）", flush=True)
rep.finish()
