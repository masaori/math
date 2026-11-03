# 対象ラベル: def_check_number_operator
# 証明の (2) の X̌ の鎖（1 個の等号）と主張 (2) の第一式を、γ(θ̃_μ) を互いに独立な不定元 g_μ に置いて厳密に確かめる。
#   第 0 行: def_check_Vprime の X̌ := Σ_μ (g_μ)_C (ψ̌_μ^† ψ̌_{σ(μ)} - (1/2)_C I)
#   第 1 行: Σ_μ (g_μ)_C (ň_μ - (1/2)_C I)、ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（def_check_number_operator）
# 両行とも g_1, …, g_M について斉一次なので、Σ_μ g_μ A_μ = Σ_μ g_μ B_μ（g は独立な不定元）は各 μ で A_μ = B_μ と同値である。
# A_μ・B_μ は E_μ := F(r_μ) の成分の行列で、等号は E_μ の中で厳密に判定する（μ ごとに体が違うので、和は係数の組として持つ）。
# 第 0 行は本文の成分の式（mat_mult・def_matrix_scalar_multiple・def_matrix_difference）で、ň_μ は Sage の行列の積（本文の成分の式とは別の積の実装。等号そのものは定義の代入なので独立な確認ではない）で作り、
#   両者の積が一致することもあわせて見る。ψ̌_{σ(μ)} は E_{σ(μ)} で作ったものを R ↦ R で E_μ へ移したもの（_prelude.sage）。
# 範囲: 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ ∈ M̌（M_col = 3 の μ = 2 は σ(μ) = μ の自己共役点）。
# 対照: ň_μ の対を μ 自身に取り違えた ψ̌_μ^† ψ̌_μ では、σ(μ) ≠ μ の項が一致しない。
load("_prelude.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4]
rep = Report("def_check_number_operator: 証明の (2) の X̌ の鎖（厳密）")


def main():
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            st = NumberOperatorSetting(f)
            tag0 = f"(x,y)=({x},{y}) M={M}"
            mism = 0
            for m in st.J:
                E = st.S[m].E
                I = st.I[m]
                half = body_scalar(E(1) / E(2), I)                                # (1/2)_C I
                row0 = body_difference(body_product(st.dag[m], st.psi_sig[m]), half)  # def_check_Vprime の項の係数
                n_mu = st.dag[m] * st.psi_sig[m]                                  # ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（Sage の積）
                rep.check(n_mu == body_product(st.dag[m], st.psi_sig[m]), f"{tag0} μ={m}: ň_μ の積（Sage の積と mat_mult の成分の式）", quiet=True)
                row1 = body_difference(n_mu, half)
                rep.check(row0 == row1, f"{tag0} μ={m}: 第 1 等号の g_μ の係数（σ(μ)={st.sigma[m]}）", quiet=True)
                rep.check(row0 != 0, f"{tag0} μ={m}: 係数は 0 でない（等号が自明でない）", quiet=True)
                wrong = body_difference(st.dag[m] * st.psi_self[m], half)
                if st.sigma[m] != m:
                    rep.check(wrong != row1, f"対照 {tag0} μ={m}: 対を μ 自身に取ると一致しない", quiet=True)
                else:
                    mism += 1
            print(f"  {tag0}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件。自己共役点 {mism} 個）")


main()
rep.finish()
