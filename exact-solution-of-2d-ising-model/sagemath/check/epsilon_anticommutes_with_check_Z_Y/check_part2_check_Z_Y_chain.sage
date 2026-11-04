# 対象ラベル: epsilon_anticommutes_with_check_Z_Y（主張 (2) と証明の (2) の鎖）
# (W̌_μ, W) ∈ {(Ž_μ, Z), (Y̌_μ, Y)} について、(2) の鎖の 10 行（9 個の等号）を、行の括弧どおりに本文の定め方で組んで隣と比べる。
# W̌_μ は def_half_integer_checkZ・def_half_integer_checkY の Σ_j c_j W_{j_Z}（c_j := exp(-i(j_R θ̃_μ)_C)。スカラー倍と有限和は本文の成分の式）。
# 位相 c_j は 1 の冪根 ζ_{4M}^{-2(2μ-1)j} として円分体 L := QQ(ζ_{4M}) に持つ（_shared/half_integer_check_operators.sage の Setting。
# 本文の exp との照合は nesting_of_commutator_of_H_and_check_Z の検算）。ℝ への脱出はこの位相の表し方だけで、等号はすべて L の中で厳密に判定する。
# W̌_μ は Sage の `*`・`+` で組んだ Σ_j c_jW_j とも一致を確かめる（鎖の先頭・末尾の行は W̌_μ の定義の代入なので、作り方で自明な比較になる）。
# 範囲: M_col = 2..5、全ての μ ∈ M̌。
# 否定コントロール: ε の代わりに単位行列 I（どの W_j とも可換で、反可換でない）を入れると、(1) を引く行（4 行目 → 5 行目）だけが外れ、
#   ほかの 8 個の等号（積の分配・スカラーの出し入れ・符号の出し入れ・定義の代入）は I でも成り立つ。
#   （σ_1^z は Y_j の全部と反可換なので、Y̌ の対照にならない。）
load("../../_shared/half_integer_check_operators.sage")
load("_prelude.sage")

rep = Report("epsilon_anticommutes_with_check_Z_Y (2): εW̌_μ = -(W̌_με) の鎖")
for M in range(2, 6):
    S0 = Setting(M)
    L = S0.L
    toL = lambda A: A.apply_map(lambda e: L(e.constant_coefficient()), L)
    E = toL(to_ring(epsilon(M), L, S0.zeta, S0.P))
    G = identity_matrix(L, 2**M)
    O = matrix(L, 2**M, 2**M, 0)
    for mu in range(1, M + 1):
        cs = [L(S0.ph(mu, -j).constant_coefficient()) for j in range(1, M + 1)]
        for nm, Wd, Wcheck in (("Z", S0.Z, S0.checkZ(mu)), ("Y", S0.Y, S0.checkY(mu))):
            Ws = [toL(Wd[j]) for j in range(1, M + 1)]
            Wc = toL(Wcheck)
            rep.check(Wc == sum((cs[j] * Ws[j] for j in range(M)), O), f"M={M} μ={mu}: W̌ = Σ c_jW_j（Sage の積と和）")
            rep.negative(Wc != O, f"M={M} μ={mu} {nm}: W̌_μ ≠ O")
            rep.chain(chain_part2(E, Ws, cs, Wc), f"M={M} μ={mu} W={nm}")
            rep.check(E * Wc == -(Wc * E), f"M={M} μ={mu}: 主張 (2) ε{nm}̌_μ = -({nm}̌_με)（Sage の積）")
            bad = failing_steps(chain_part2(G, Ws, cs, Wc))
            rep.negative(bad == [3], f"M={M} μ={mu} W={nm}: I では (1) を引く行だけが外れる（外れた行: {bad}）")
    print(f"  M_col={M}: 済（累計 {rep.n} 件）", flush=True)
rep.finish()
