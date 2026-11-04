# 対象ラベル: eigenvalues_of_check_Vprime
# 本文の ψ̌（def_check_fermi の式どおりの行列）の ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（def_check_number_operator、σ(μ) := M_col + 1 - μ）で、
# 証明の鎖の検算 6 本と主張の検算を走らせる。
# このディレクトリの他の検算は、ň_μ を _vprime_settings.sage（中身は check_joint_eigenspace_decomposition/_number_operators.sage）から取る。
# 既定は鎖が ň_μ について使う性質（check_joint_eigenspace_decomposition の (1)・(3)、check_number_operator_idempotent・
# check_number_operators_commute）を満たす Jordan–Wigner の模型である。ここでは USE_CHECK_PSI = True と置いてから同じ検算を読み込む。
#   鎖の厳密計算では、γ_μ について一次の Step 1 の鎖は γ_μ を数体 F 上の多項式環の不定元に置き（不定元での等号は γ(θ̃_μ) の
#   実際の値を代入しても成り立つ）、冪を作る鎖は有理数 γ_μ を使う（_vprime_settings.sage の chain_settings）。
#   極限の鎖と主張の検算では γ(θ̃_μ) の実際の値の球を使う。
# check_last_paragraph_positivity.sage は ň_μ を使わない（γ(θ̃_μ) と ǧ(ε) の値だけを扱う）ので、ここでは読み込まない。
# 範囲: 結合定数 3 組 × M_col = 2, 3（引数で M_col を絞れる）。
# 帰属: ň_μ・Q̌_ε は数体 F の元（厳密）。γ_μ は F 上の不定元か有理数か ℝ の値の球（ℝ への脱出は各検算の冒頭に書いた）。
USE_CHECK_PSI = True
CHECK_PSI_MS = [int(a) for a in sys.argv[1:]] or [2, 3]
load("_vprime_settings.sage")
settings = number_operator_settings()
print(f"  本物の ψ̌ の ň_μ: {len(settings)} 組（{', '.join(t for (t, _, _, _) in settings)}）", flush=True)

for script in [
    "check_step1_left_chain.sage",
    "check_step1_right_chain.sage",
    "check_step2_step3prime_induction_and_step4_idempotent_chains.sage",
    "check_step3_partial_sum_chains.sage",
    "check_step3_limit_chains.sage",
    "check_step4_eigenvector_chain.sage",
    "check_claim_statements.sage",
]:
    print(f"== {script}（本物の ψ̌）", flush=True)
    load(script)
print("RESULT: PASS")
