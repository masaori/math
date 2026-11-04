# 対象ラベル: check_joint_eigenspace_decomposition
# 本文の ψ̌（def_check_fermi の式どおりの行列）で、主張 (1)〜(5) と証明の全ての鎖を厳密に確かめる。
#   ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（def_check_number_operator、σ(μ) := M_col + 1 - μ）。
# このディレクトリの他の検算（証明の鎖の検算 10 本と主張の検算）は、ň_μ を _number_operators.sage の number_operator_settings()
# から取る。既定はそれらの鎖が ň_μ について使う二つの性質（冪等性と可換性）を満たす Jordan–Wigner の模型である。
# ここでは USE_CHECK_PSI = True と置いてから同じ検算を読み込み、全ての鎖と主張を本文の ψ̌ の ň_μ で走らせる。
# ψ̌ は def_check_number_operator の検算の準備（../def_check_number_operator/_prelude.sage の NumberOperatorSetting）が作り、
# 全ての μ を一つの数体 F := E_1 に移す（移し方と、それが本物の値を保つ理由は _number_operators.sage と
# trace_of_check_number_operator_product/overview.md の「計算の帰属と範囲」）。
# 範囲: 結合定数 3 組 × M_col = 2, 3（引数で M_col を絞れる）。
# 帰属: 成分はすべて数体 F の元（厳密計算。浮動小数点は使わない）。否定コントロールは、6 本は QQ 上、check_step2_expansion・check_step4_step5・check_step5_direct_sum・check_claim_statements の 4 本は ň_μ と F で作る。
USE_CHECK_PSI = True
CHECK_PSI_MS = [int(a) for a in sys.argv[1:]] or [2, 3]
load("_number_operators.sage")
settings = number_operator_settings()
print(f"  本物の ψ̌ の ň_μ: {len(settings)} 組（{', '.join(t for (t, _, _, _) in settings)}）", flush=True)

for script in [
    "check_factor_as_R_chains.sage",
    "check_step0_square_zero_difference_and_sum_chains.sage",
    "check_step0_step3_distributivity_chains.sage",
    "check_step0_commutation_step1_square_step3_chains.sage",
    "check_step1_orthogonality_step3_moving_one_factor_chains.sage",
    "check_step2_identity_product_chain.sage",
    "check_step2_expansion_over_binary_words.sage",
    "check_step3_scalar_case_chains.sage",
    "check_step4_step5_power_and_vector_chains.sage",
    "check_step5_direct_sum_first_line.sage",
    "check_claim_statements.sage",
]:
    print(f"== {script}（本物の ψ̌）", flush=True)
    load(script)
print("RESULT: PASS")
