# 対象ラベル: trace_of_check_Vprime
# 本文の ψ̌（def_check_fermi の式どおりの行列）の ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（def_check_number_operator、σ(μ) := M_col + 1 − μ）で、
# 行列の鎖の検算 check_step1_chain.sage・check_step3_chain.sage と主張の検算 check_claim_statement.sage を走らせる。
# 三つの検算は、ň_μ を ../eigenvalues_of_check_Vprime/_vprime_settings.sage（中身は check_joint_eigenspace_decomposition/_number_operators.sage）
# から取る。既定は Jordan–Wigner の模型で、ここでは USE_CHECK_PSI = True と置いてから同じ検算を読み込む。
#   鎖では exp(γ(θ̃_μ)/2) を数体 F 上のローラン多項式環の不定元に置き（不定元での等号は実際の値を代入しても成り立つ）、
#   −X̌ の行では γ_μ を F 上の多項式環の不定元に置く。主張の検算では γ(θ̃_μ) の実際の値の球を使う。
# check_step2_*.sage と check_step3_and_step4_real_lines.sage は ň_μ を使わないので、ここでは読み込まない。
# 範囲: 結合定数 3 組 × M_col = 2, 3（引数で M_col を絞れる）。
# 帰属: ň_μ・Q̌_ε は数体 F の元（厳密）。a_μ・γ_μ は F 上の不定元、主張の検算の γ_μ は ℝ の値の球（ℝ への脱出は各検算の冒頭に書いた）。
USE_CHECK_PSI = True
CHECK_PSI_MS = [int(a) for a in sys.argv[1:]] or [2, 3]
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")
settings = number_operator_settings()
print(f"  本物の ψ̌ の ň_μ: {len(settings)} 組（{', '.join(t for (t, _, _, _) in settings)}）", flush=True)

for script in ["check_step1_chain.sage", "check_step3_chain.sage", "check_claim_statement.sage"]:
    print(f"== {script}（本物の ψ̌）", flush=True)
    load(script)
print("RESULT: PASS")
