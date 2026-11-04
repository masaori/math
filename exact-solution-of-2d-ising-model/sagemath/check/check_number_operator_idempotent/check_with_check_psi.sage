# 対象ラベル: check_number_operator_idempotent
# 本文の ψ̌（def_check_fermi の式どおりの行列）で、主張 (1)(2)(3) と証明の全ての鎖を厳密に確かめる。
#   D := ψ̌_μ^†、P := ψ̌_{σ(μ)}（σ(μ) := M_col + 1 - μ）、n := DP（def_check_number_operator の ň_μ）。
# ψ̌ は def_check_number_operator の検算の準備（../def_check_number_operator/_prelude.sage の NumberOperatorSetting）が作る:
#   Ž_μ・Y̌_μ・位相は数体 F に、ψ̌_μ^†・ψ̌_μ は E_μ := F(r_μ)（r_μ := |γ_2(θ̃_μ)|）に置き、ψ̌_{σ(μ)} は E_{σ(μ)} から E_μ へ移す。
# 鎖の組み立ては _chains.sage（Jordan–Wigner の模型の検算と同じ関数）で、ここでは仮定の行も含めて全ての等号を本物の ψ̌ で確かめる。
# 加えて、(1)(2) の matrix_sum_with_itself_zero_implies_zero・matrix_summand_from_sum_equation の仮定と結論、主張 (1)(2)(3) を直接比べる。
# 対照: 対を μ 自身に取り違えた ψ̌_μ^†ψ̌_μ（σ(μ) ≠ μ のとき）は (2) と (3) を満たさない。ψ̌_μ^†ψ̌_μ^† = O は対の取り方に依らない。
# 範囲: 結合定数 3 組 × M_col = 2, 3 × 全 μ ∈ M̌。
# 帰属: 成分はすべて数体 E_μ の元（厳密計算。浮動小数点は使わない）。
load("../def_check_number_operator/_prelude.sage")
load("_chains.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("check_number_operator_idempotent: 本物の ψ̌ での主張と鎖（厳密）")


def all_steps_hold(lines):
    return all(A == B for (_, A, _), (_, B, _) in zip(lines, lines[1:]))


for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        for m in st.J:
            tag = f"(x,y)=({x},{y}) M={M} μ={m}"
            D, P, Id = st.dag[m], st.psi_sig[m], st.I[m]
            O = 0 * Id
            n = D * P
            rep.check(n != O and n != Id, f"{tag}: ň_μ は O でも I でもない（等号が自明でない）", quiet=True)
            # (1) の鎖と matrix_sum_with_itself_zero_implies_zero
            for X, nm in ((D, "ψ̌_μ^†"), (P, "ψ̌_{σ(μ)}")):
                rep.check(all_steps_hold(chain_1(X, Id)), f"{tag}: (1) の鎖 {nm}{nm} + {nm}{nm} = [·,·]_+ = O", quiet=True)
                rep.check(X * X == O, f"{tag}: 主張 (1) {nm}{nm} = O", quiet=True)
                rep.check(X != O, f"{tag}: {nm} は O でない", quiet=True)
            # (2) の鎖。δ_{σ(μ),σ(μ)} は添字から計算する
            rep.check(all_steps_hold(chain_2(D, P, Id, st.sigma[m])), f"{tag}: (2) の第一の鎖 DP + PD = [D,P]_+ = δI = 1_C I = I", quiet=True)
            rep.check(D * P + P * D == Id, f"{tag}: matrix_summand_from_sum_equation の仮定 A + B = C", quiet=True)
            rep.check(all_steps_hold(chain_2b(D, P, Id)), f"{tag}: (2) の第二の鎖 PD = I - DP = I - ň_μ", quiet=True)
            rep.check(P * D == sub(Id, n), f"{tag}: 主張 (2)", quiet=True)
            # (3) の 23 個の等号
            lines = idempotent_chain(D, P, Id)
            for (a, A, _), (b, B, _) in zip(lines, lines[1:]):
                rep.check(A == B, f"{tag}: (3) の鎖 {a} = {b}", quiet=True)
            rep.check(n**2 == n, f"{tag}: 主張 (3) ň_μ^2 = ň_μ", quiet=True)
            # 対照: 対を μ 自身に取り違える
            if st.sigma[m] != m:
                Pw = st.psi_self[m]
                nw = D * Pw
                rep.check(Pw * D != sub(Id, nw), f"対照 {tag}: 対を μ 自身に取ると (2) が成り立たない", quiet=True)
                rep.check(nw**2 != nw, f"対照 {tag}: 対を μ 自身に取ると (3) が成り立たない", quiet=True)
        print(f"  (x,y)=({x},{y}) M={M}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()
