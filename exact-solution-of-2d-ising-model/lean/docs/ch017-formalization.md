# 章 017「定数 `c` の決定と `V^{(+)}` の固有値」の形式化

対象の人手証明: もと `structured-latex/content/017_even_sector_eigenvalues.ts` の 11 主張。章立ての組み直しで、`def_check_number_operator` は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` へ、`V_plus_inverse_is_positive_definite`・`V_plus_inverse_positive_and_trace_positivity` を除く残りは `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` へ移った

- 具体版: `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/`（`V̌'` の固有値と `Λ̌_max` の単純性は `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/`）
- 必要十分版: `Ising2D/NecSuf/PairedFermion.lean`, `Ising2D/NecSuf/ConstantC.lean`,
  `Ising2D/NecSuf/SimpleEigenvalue.lean`, `Ising2D/NecSuf/TraceOfNumberOperatorProductByLastFactor.lean`
  （加えて、章 009 の `Ising2D/NecSuf/NumberOperator.lean` と
  `Ising2D/NecSuf/JointEigenspace.lean` を**そのまま再利用している**）

---

## 0. 本章の結論（先に要点）

**章 017 の主張のうち 9 本は、章 009 の必要十分版をそのまま特殊化して得られる。**
章 009（整数運動量）と章 017（半整数運動量）の違いは、必要十分版の言葉では

> **対をなす添字を与える単射 `σ` の取り方だけ**（章 009 は `σ(μ) = -μ`、
> 章 017 は `σ(μ) = M+1-μ`）

であり、`Ising2D/NecSuf/PairedFermion.lean` の `acomm_cre_ann_comp` が
その 1 行の橋渡しである。消滅演算子を `a'_i := a_{σ i}` と付け替えれば
`δ_{ν,σ μ}` は Kronecker の `δ_{μν}` になり、章 009 の
`NecSuf.num_mul_num` / `commute_num_num` / `projOn_*` / `two_pow_smul_tau_projOn` /
`exp_mul_eq_of_mul_eq_smul` がすべてそのまま通る。

**そのうえで、本章に固有で数学的に新しいのは次の 2 点だけである。**

1. **添字集合が無条件に確定する。** 章 009 の `FermiSetup` は
   「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` となる有限集合 `I`」を
   **仮定として受け取る**形になっていた（臨界点では `|I| = M-1` になりうる）。
   半整数運動量では `γ_2(θ~_μ) ≠ 0` が例外なく成り立つので、
   **`𝓜̌ = {1,…,M}` に確定し、仮定として受け取る余地が無い**
   （`Ising2D.CheckIdx`、`Ising2D.CheckIdx.card : Fintype.card (CheckIdx M) = M`）。
   その帰結として `m = M`、すなわち
   - `tr(Q̌_ε) = 2^{M-M} = 1`（同時固有空間はすべて 1 次元）
   - `tr(V̌')` の前因子 `2^{M-m}` が消える

   が出る。**Lean 側でも `CheckFermiSetup` は添字集合を場として持っていない**
   （章 009 の `FermiSetup` は `I`, `hIlow`, `hIhigh`, `hgam` の 4 つを持っていた）。
2. **`γ(θ~_μ) > 0` が狭義である**（`Ising2D.gammaFn_thetaTilde_pos`）。
   章 009 は `γ(θ_μ) ≥ 0` しか持てないので最大固有値の単純性を言えないが、
   半整数運動量では `0 < θ~_μ < 2π` から `cos θ~_μ < 1` が出て
   `γ_1(θ~_μ) > cosh(2K_1-2K_2^*) ≥ 1`、したがって `γ(θ~_μ) > 0` が
   **すべての `μ ∈ 𝓜̌`、すべての `K_1, K_2 > 0`（臨界点を含む）で**成り立つ。
   この 1 点だけで `Λ̌_max` の単純性が従う。

なお、平方根の分枝の選択（章 009 の `FermiSetup.hbr`、原文の穴）は、
本章では `ψ̌` の CAR を仮定として受け取るため `CheckFermiSetup` に現れない。
分枝の整合が必要なのは CAR を導くところ（章 015）である。

---

## 1. 形式化した定理の一覧

### 必要十分版（`Ising2D.NecSuf`）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `NecSuf.annPaired` / `numPaired`（`PairedFermion.lean`） | `a'_i := a_{σ i}`、`n_i := c_i a_{σ i}` | `def_check_number_operator` |
| `NecSuf.acomm_cre_ann_comp` | `δ_{ν,σ μ}` 型の CAR は付け替えで Kronecker の `δ_{μν}` になる（`σ` の単射性だけ） | `check_number_operator_idempotent` (2)、`check_number_operators_commute` Step 1 |
| `NecSuf.two_pow_smul_tau_noncommProd` | `2^{|s|} τ(∏_{i∈s} n_i) = τ(1)` | `trace_of_check_number_operator_product` |
| `NecSuf.tau_finProdLeft_projFactor`（`TraceOfNumberOperatorProductByLastFactor.lean`） | 具体版 `trace_projFactor_finProdLeft` と同じ手順（最後の因子を分ける帰納法）の必要十分版。`A` は `K` 加群の環、`τ` は線型（`hlin`）・巡回的（`hcyc`）で `τ(1) = 2^{|ι|}`、`a_ic_i = 1 - n_i`、`i ≠ j` で `a_in_j = n_ja_i`、`K` は `half · 2 = 1` の元を持つ環（体・可換性は不要。`half` は標数 2 の反例で削れない）。手順の各段は `mul_one_eq_one_mul`・`ann_mul_projFactor`・`tau_mul_one_sub_num`・`tau_mul_num_chain`・`tau_mul_num_eq_half`・`tau_mul_projFactor_eq_half`。特殊化は `trace_projFactor_finProdLeft_of_necSuf`（`ClaimTraceCheckNumberOperatorProductFromNecSuf.lean`） | `trace_of_check_number_operator_product` |
| `NecSuf.const_eq_of_trace_ratio`（`ConstantC.lean`） | `T = cp = aτ`, `T' = c⁻¹p = a⁻¹τ`, `a,p>0`, `T>0` ⇒ `c = a` | `constant_c_value_even_sector` |
| `NecSuf.sum_weight_lt_of_ne_univ` | 重みが狭義正なら `∑ w_i(χ_T(i)-h)` は `T = univ` でのみ最大（係数は順序環、`h` は任意。具体版は `ℝ`・`h = 1/2`） | `max_eigenvalue_of_V_plus_simple` (2) |
| `NecSuf.sum_weight_le_univ` / `sum_weight_empty_le`（`SimpleEigenvalue.lean`） | 重みが非負のときの最大・最小（非狭義） | `eigenvalues_of_V_plus` (2) |
| `NecSuf.eq_proj_of_eigen` | 単位の分解 `∑ Q_ε = 1` と `Q_ε V = Λ_ε Q_ε` と `Λ_ε ≠ Λ_{ε_0}` だけから固有空間を同定 | `max_eigenvalue_of_V_plus_simple` (3) |
| `NecSuf.mul_pow_eq_of_mul_eq_smul` / `mul_exp_eq_of_mul_eq_smul` | `Q X = gQ ⇒ Q exp(X) = e^g Q`（章 009 の左右反転版） | `eigenvalues_of_check_Vprime` Step 2/3 |
| `NecSuf.isInternal_range_proj` / `isInternal_range_matrix_proj` / `exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` | 内部直和分解と対角化可能性（**章 009 と共通の必要十分版**。`NecSuf/JointEigenspaceDecomposition.lean`） | `check_joint_eigenspace_decomposition` (5)、`eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus`（対角化可能） |

### 具体版（`Ising2D`, `Ising2D.CheckFermiSetup`）

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `claims_unused_by_chapter_goals_not_adopted.ts` へ退避したどの章のゴールの主張からも使われない主張のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `checkIdxFinset` / `CheckIdx` / `CheckIdx.card` | `𝓜̌ = {1,…,M}` と `|𝓜̌| = M` | `def_check_index_set` |
| `conjIdx` / `conjIdx_involutive` | 共役添字 `μ ↦ M+1-μ` が対合であること | `def_check_number_operator` (1) |
| `tensorPow_two_torsion_free` | `x+x=0 → x=0`（`Mat(2^M,ℂ)`。`x = ½·2x = ½·0 = 0`） | `check_number_operator_idempotent` (1) の「`2≠0` なので両辺を 2 で割る」 |
| `CheckFermiSetup` | `ψ̌^†, ψ̌` と CAR（章 015 の内容を仮定として受け取る） | `def_check_fermi`, `anticommutator_of_check_psi` |
| `CheckFermiSetup.nOp` | `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` | `def_check_number_operator` |
| `CheckFermiSetup.nOp_eq_numPaired` | `ň_μ` が必要十分版 `numPaired` の特殊化であることの確認 | 同上 |
| `CheckFermiSetup.acomm_cre_ann` | `[ψ̌_μ^†, ψ̌_{M+1-ν}]_+ = δ_{μν} I`（**合同式の書き換え不要**） | `anticommutator_of_check_psi` の制限 |
| `CheckFermiSetup.cre_add_self_eq_zero` / `cre_sq` / `ann_add_self_eq_zero` / `ann_sq` / `cre_ann_add_ann_cre_eq_one` / `ann_mul_cre` / `nOp_sq` / `nOp_mul_self` | (1)(2)(3)。(1) は反交換子の 2 行の鎖と `matrix_sum_with_itself_zero_implies_zero`、(2) は反交換子の鎖と `matrix_summand_from_sum_equation`、(3) は `nOp_sq`（冪を積へ運ぶ 4 行）と `nOp_mul_self`（続く 19 行）で、人手の鎖と 1 対 1（`*_of_necSuf` は必要十分版の特殊化） | `check_number_operator_idempotent` |
| `CheckFermiSetup.ite_one_zero_eq_delta_smul` / `anticomm_cre_cre_eq_zero` / `anticomm_cre_ann_eq_zero` / `anticomm_ann_cre_eq_zero` / `anticomm_ann_ann_eq_zero` / `mul_eq_neg_of_anticomm_eq_zero` | 場の `if c then I else O` を人手の `δI` へ読み替える段、Step 1 の 4 式（第 2 式は 3 行、第 3 式は 7 行の鎖と 1 対 1 の calc）と、`XW + WX = [X, W]_+ = O` の 2 行の鎖と `matrix_equals_negation_if_sum_is_zero` による `XW = -(WX)` | `check_number_operators_commute` Step 1 |
| `CheckFermiSetup.mul_nOp_of_anticommute` / `commute_cre_nOp` / `commute_ann_nOp` / `nOp_mul_nOp_of_ne` / `commute_nOp_nOp` | Step 2 の 10 行の鎖、(1)、Step 3 の 7 行の鎖、(2)（`*_of_necSuf` は必要十分版の特殊化） | `check_number_operators_commute` |
| `CheckFermiSetup.nOpProd` / `trace_nOpProd`（`ClaimTraceCheckNumberOperatorProduct.lean`） | `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}` | `trace_of_check_number_operator_product` |
| `CheckFermiSetup.trace_nOp` / `trace_nOpProd_univ` | `tr(ň_μ) = 2^{M-1}`, `tr(ň_1⋯ň_M) = 1` | 同上「とくに」 |
| `CheckFermiSetup.trace_projFactorProd`（同ファイル） | 因子の混在を許す主張そのもの `tr(R_{μ_1}^{(e_1)}⋯R_{μ_k}^{(e_k)}) = 2^{M-k}`（右辺は `ℂ` の冪。積は `Finset.noncommProd`。必要十分版 `NecSuf.two_pow_smul_tau_projOn` の特殊化。`trace_Qproj_step4` は人手の範囲外の `M = 0` でだけ使う） | `trace_of_check_number_operator_product` |
| `CheckFermiSetup.trace_projFactor_finProdLeft`（同ファイル） | 同じ主張の、人手の帰納法と 1 対 1 の具体版（`k ≥ 1`。積は `def_finite_product_of_matrices` の左から掛ける `NecSuf.finProdLeft`、相異なる添字の列は単射 `μ : Fin k → 𝓜̌`）。基底段階 `trace_identity_base_case`、準備 2 `ann_mul_identity_prep2`・`ann_mul_projFactor_prep2`、準備 3 `trace_mul_one_sub_nOp_prep3`、`tr(Pň_{μ_k})` の 8 行 `trace_mul_nOp_chain`、移項 `trace_mul_nOp_eq_half`、二場合 `trace_mul_projFactor_eq_half` | `trace_of_check_number_operator_product` |
| `CheckFermiSetup.Qproj` / `Qproj'`（`ClaimCheckJointEigenspace.lean`） | `Q̌_ε`（`Finset` 版 / `ε : 𝓜̌ → Bool` 版） | `check_joint_eigenspace_decomposition` |
| `CheckFermiSetup.checkIdxOfFin` / `Qproj_eq_finProdLeft` | 人手の添字 `μ = j + 1`（`j : Fin M_col`）と、証明の冒頭の `Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}`（`def_finite_product_of_matrices` の左から掛ける積 `NecSuf.finProdLeft`）。`Qproj`（`Finset.noncommProd`）との一致を、必要十分版 `NecSuf.finProdLeft_eq_noncommProd_image`（`Ising2D/NecSuf/FiniteProductLeftAsNoncommProd.lean`。モノイド（因子 1 つの段の単位元と、末尾に 1 因子を足す段の結合則）、因子の可換性（`noncommProd` を定めるのと、末尾に 1 因子を足す段に要る）、単射な添字の写像が効く）の特殊化で述べる | `check_joint_eigenspace_decomposition` |
| `CheckFermiSetup.nOp_mul_nOp_of_sq` / `nOp_mul_one_sub_nOp` / `one_sub_nOp_mul_nOp` / `one_sub_nOp_mul_self` / `nOp_add_one_sub_nOp` | 証明の Step 0 の冒頭の `ň_μň_μ = ň_μ`（(3) の `ň_μ^2 = ň_μ` を `def_exp` (1) の冪から積へ運ぶ 5 行）・`R_μ^{(1)}R_μ^{(0)} = 0`（Step 3 の `ε_ν = 0` の場合と同じ 7 行）・`R_μ^{(0)}R_μ^{(1)} = 0`（7 行）・`R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`（8 行。Lean の calc は最後の定義の行を除いた 7 段）・`R_μ^{(1)} + R_μ^{(0)} = I`（2 行。Lean の calc は定義の行を除いた 1 段）の鎖と 1 対 1 の calc | `check_joint_eigenspace_decomposition` Step 0 |
| `CheckFermiSetup.mul_identity_eq_identity_mul_step0` / `nOp_mul_nOp_comm_step0` / `nOp_mul_one_sub_nOp_comm_step0` / `one_sub_nOp_mul_nOp_comm_step0` / `one_sub_nOp_mul_one_sub_nOp_comm_step0` / `projFactor_mul_comm_step0` | 証明の Step 0 の異なる添字の因子の可換性: `YI = IY`（2 行）と、`μ ≠ ν` の 4 通りの上付き添字の組 `R_ν^{(e')}R_μ^{(e)} = R_μ^{(e)}R_ν^{(e')}` の鎖（`(1,1)` は `check_number_operators_commute` (2)、`(1,0)`・`(0,0)` は `commuting_with_difference`、`(0,1)` は `(1,0)` の鎖を `μ` と `ν` を入れ替えて右辺から左辺へ。定義の行を除いた 1 段の calc）と、それをまとめた「Step 0 の可換性」（`e'` は `ν ∈ T'`、`e` は `μ ∈ T`） | `check_joint_eigenspace_decomposition` Step 0 |
| `CheckFermiSetup.nOp_mul_projFactor_of_mem` / `nOp_mul_projFactor_of_not_mem` | 証明の Step 3 の二つの場合の鎖 `ň_ν R_ν^{(ε_ν)} = ε_ν R_ν^{(ε_ν)}`（`ε_ν = 1`: `ň_νň_ν = ň_ν = 1_ℂR_ν^{(1)}`（`scalar_multiple_by_one`）・場合の仮定。`ε_ν = 0`: `nOp_mul_one_sub_nOp` の 7 行・`0_ℂR_ν^{(0)}`（`zero_scalar_multiple_is_zero_matrix`）・場合の仮定）と 1 対 1 の calc。`R_ν^{(ε_ν)}` は `NecSuf.projFactor F.nOp T ν` | `check_joint_eigenspace_decomposition` Step 3 |
| `CheckFermiSetup.projFactor_mul_projFactor_eq_zero_step1` / `projFactor_comm_factor_step1` / `Qproj_mul_Qproj_of_ne_step1` | 証明の Step 1 の `ε ≠ ε'` の場合: `ε_ν ≠ ε'_ν` なら `R_ν^{(ε_ν)}R_ν^{(ε'_ν)} = 0`（`(1,0)`・`(0,1)` の場合分けで Step 0 の積）、`R_ν^{(ε_ν)}` が `Q̌_{ε'}` の各因子と可換であること（`μ ≠ ν` は Step 0 の可換性、`μ = ν` は 2 行の鎖）、`Q̌_εQ̌_{ε'} = 0` の 10 行の鎖と 1 対 1 の calc（`M_col = r + 2`。`mat_mult_associative` の 2 行は具体版が無いので mathlib の `Matrix.mul_assoc`） | `check_joint_eigenspace_decomposition` Step 1 |
| `CheckFermiSetup.projFactor_mul_self_step0` / `Qproj_sq_eq_mul_self_step1` / `Qproj_mul_self_step1` / `Qproj_sq_step1` | 証明の Step 1 の `ε = ε'` の場合: 各因子の冪等性 `R_μ^{(ε_μ)}R_μ^{(ε_μ)} = R_μ^{(ε_μ)}`（calc ではなく場合分け。`ε_μ = 1` は Step 0 冒頭の `ň_μň_μ = ň_μ`、`ε_μ = 0` は Step 0 の `R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`）、8 行の鎖のうち `Q̌_ε^2 = Q̌_εQ̌_ε` の 4 行（`def_exp` (1) の冪・`identity_matrix_is_left_unit_of_mat_mult`）と `Q̌_εQ̌_ε = Q̌_ε` の 4 行（定義・`product_of_two_finite_products_of_matrices`・各因子の冪等性・定義）と 1 対 1 の calc、2 つをつないだ `Q̌_ε^2 = Q̌_ε`（`M_col = r + 1`） | `check_joint_eigenspace_decomposition` Step 1 |
| `CheckFermiSetup.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` | (1)。`Qproj_mul_Qproj_of_ne` は人手の範囲 `M_col ≥ 2` で Step 1 の鎖 `Qproj_mul_Qproj_of_ne_step1` を使い、範囲外の `M = 0, 1` は必要十分版の特殊化 `Qproj_mul_Qproj_of_ne_of_necSuf` で閉じる。`Qproj_mul_self` は `M ≥ 1`（人手の範囲 `M_col ≥ 2` を含む）で Step 1 の鎖の 5〜8 行 `Qproj_mul_self_step1` を使い、`M = 0` は `Qproj_mul_self_of_necSuf` で閉じる。人手の (1) は冪の形 `Q̌_ε^2 = Q̌_ε`（Lean は `Qproj_sq_step1`）で、使う側は `Q̌_εQ̌_ε` を `Q̌_ε^2` へ戻してから引くが、Lean の使う側は積の形の `Qproj_mul_self` を直接引くのでその往復が無い | 同 (1) |
| `CheckFermiSetup.rFactor` / `finsetOfBinWord` / `projFactor_finsetOfBinWord` / `rFactor_one_add_rFactor_zero` / `sum_Qproj_step2` | 証明の Step 2: 人手の `R_μ^{(e)}`（`rFactor`）、語 `ε ∈ {0,1}^𝓜̌` から `ε_μ = 1` の `μ` の集合への写像（`Qproj` の添字へ送る）、`Q̌_ε` の因子が `R_μ^{(ε_μ)}` であること、Step 0 の `R_μ^{(1)} + R_μ^{(0)} = I` を `rFactor` で書いたもの、`Σ_ε Q̌_ε = Σ_ε ∏R_μ^{(ε_μ)} = ∏(R_μ^{(1)} + R_μ^{(0)}) = ∏I = I` の 4 行の鎖と 1 対 1 の calc（`M_col = r + 1`。和は `def_sum_over_binary_words` の `NecSuf.binWordSum`、展開は `expansion_of_finite_product_of_two_term_sums`、最後の行は `finite_product_of_identity_matrices`） | `check_joint_eigenspace_decomposition` Step 2 |
| `CheckFermiSetup.sum_Qproj_eq_binWordSum` / `finsetOfBinWord_bijective` | Lean の `sum_Qproj` の和（`𝓜̌` の部分集合の上の `Finset.sum`）が人手の和 `Σ_{ε∈{0,1}^𝓜̌}` に等しいこと。語から部分集合への全単射で添字を付け替え、必要十分版 `NecSuf.binWordSum_eq_sum`（`Ising2D/NecSuf/BinaryWordSumAsFinsetSum.lean`。加法についての可換モノイド（`{0,1}` の上の和を `B_{(1)} + B_{(0)}` へ並べ替える可換則と、二重の和をまとめる結合則・可換則）が効く）の特殊化で二つの和をつなぐ。人手の証明の行ではない | `check_joint_eigenspace_decomposition` (2) |
| `CheckFermiSetup.sum_Qproj` | `∑_ε Q̌_ε = I`。人手の範囲 `M_col ≥ 2`（`M = r + 1` に含まれる）では、和を人手の和へ付け替えて Step 2 の鎖 `sum_Qproj_step2` で示し、`M = 0` は必要十分版の特殊化 `sum_Qproj_of_necSuf` で閉じる | 同 (2) |
| `CheckFermiSetup.nOp_mul_projFactor_comm_step3` / `nOp_mul_projFactor_step3` / `nOp_mul_Qproj_step3` / `Qproj_mul_nOp_step3` | 証明の Step 3: 最初の三つの場合 `ň_ν R_μ^{(ε_μ)} = R_μ^{(ε_μ)} ň_ν`（`μ ≠ ν` は定義・Step 0 の可換性（`e' → 1` を `T' → 𝓜̌` 全体で表す）・定義の 3 行、`μ = ν` で `ε_ν = 1` は定義の 2 行、`ε_ν = 0` は定義・Step 0 の二つの積が零・定義の 4 行）、直前の二つの場合（`nOp_mul_projFactor_of_mem`・`nOp_mul_projFactor_of_not_mem` の場合分け）、`ň_νQ̌_ε = ε_νQ̌_ε` の 9 行の鎖（定義・`matrix_commuting_with_each_factor_commutes_with_finite_product`・`moving_one_factor_of_finite_product_to_the_end`・`mat_mult_associative`（mathlib の `Matrix.mul_assoc`）・`μ = ν` の場合を右辺から左辺へ・直前の二つの場合・`scalar_multiple_factors_out_of_right_factor`・`moving_one_factor_…` を右辺から左辺へ・定義）、`Q̌_εň_ν = ε_νQ̌_ε` の 4 行の鎖と 1 対 1 の calc（`M_col = r + 2`） | `check_joint_eigenspace_decomposition` Step 3 |
| `CheckFermiSetup.nOp_mul_Qproj` / `commute_nOp_Qproj` | (3) の `ň_ν Q̌_ε = ε_ν Q̌_ε` と `ň_ν Q̌_ε = Q̌_ε ň_ν`。人手の範囲 `M_col ≥ 2`（`M = r + 2`）では Step 3 の鎖 `nOp_mul_Qproj_step3`・`Qproj_mul_nOp_step3` を使い、範囲外の `M = 0, 1` は必要十分版の特殊化 `nOp_mul_Qproj_of_necSuf`・`commute_nOp_Qproj_of_necSuf` で閉じる | 同 (3) |
| `CheckFermiSetup.trace_Qproj_step4` / `trace_Qproj` | 証明の Step 4 の 3 行 `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1`（`trace_projFactor_finProdLeft` の `μ → checkIdxOfFin`（`M = r + 1`。人手の範囲外の `M = 0` は `trace_projFactorProd` の `S → 𝓜̌`）・`M − M = 0`・`def_power_of_complex_number` の `z^0 := 1_ℂ`（`pow_zero`））と 1 対 1 の calc と、それから示す **`tr(Q̌_ε) = 1`** | 同 (4) |
| `CheckFermiSetup.finrank_range_Qproj` | **`dim im Q̌_ε = 1`** | 同 (4) 後半 |
| `CheckFermiSetup.colVec_eq_sum_Qproj_mul_step5` / `Qproj_mul_colVec_of_ne_step5` / `Qproj_mul_colVec_self_step5` / `eq_zero_of_binWordSum_eq_zero_step5` | 証明の Step 5 の鎖を、人手が数ベクトルを扱う 1 列の行列 `Matrix (Conf M) (Fin 1) ℂ` で書いた calc（`M_col = r + 1`）: `x = Ix = (Σ_ε Q̌_ε)x = Σ_ε Q̌_εx` の 3 行（`identity_matrix_is_left_unit_of_mat_mult`・Step 2 の (2)・`sum_over_binary_words_distributes_in_left_factor`）、`ε ≠ ε'` の `Q̌_{ε'}y_ε = O` の 4 行（`x_ε` の取り方・`mat_mult_associative`（mathlib の `Matrix.mul_assoc`）・(1)・`zero_matrix_is_left_zero_of_mat_mult`）、`Q̌_{ε'}y_{ε'} = y_{ε'}` の 4 行（Step 1 の `Qproj_mul_self_step1`）、直和の 5 行（`sum_over_binary_words_with_one_nonzero_term`・`sum_over_binary_words_distributes_in_right_factor`・`zero_matrix_is_right_zero_of_mat_mult`）。引く主張は `*_colVec` の系 | 同 Step 5 |
| `CheckFermiSetup.sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` / `replicateCol_finset_sum` | 直和分解（張ること・直和性）。人手の範囲 `M_col ≥ 2`（`M = r + 1` に含まれる）では、数ベクトルを mathlib の単射 `Matrix.replicateCol (Fin 1)` で 1 列の行列へ送り、和を `finsetOfBinWord`・`NecSuf.binWordSum_eq_sum` で人手の和へ付け替えて Step 5 の鎖から示す（運ぶ段は人手の行ではない）。`M = 0` は mathlib の `Matrix.sum_mulVec` ほかで閉じる | 同 (5) |
| `CheckFermiSetup.Xop` / `Vprime` / `gval` | `X̌`, `V̌' = exp(X̌)`, `ǧ(ε)` | `def_check_number_operator` (2), `def_check_Vprime` |
| `CheckFermiSetup.Xop_mul_Qproj` / `Qproj_mul_Xop`（`ClaimEigenvaluesCheckVprime.lean`） | `X̌ Q̌_ε = ǧ(ε) Q̌_ε`（左右両方）。左から掛ける形は、`M = r + 1` で人手の 14 行の鎖と 1 対 1 の calc `Xop_mul_Qproj_step1`（和の添字の付け替えは `Xop_eq_sum_fin`・`gval_eq_sum_fin`）から示し、人手の範囲外の `M = 0` は `Xop_mul_Qproj_of_finset_sum`。右から掛ける形 `Qproj_mul_Xop` も、`M = r + 1` で人手の 14 行の鎖と 1 対 1 の calc `Qproj_mul_Xop_step1`（(3) の右から掛ける形は `Qproj_mul_nOp`）から示し、人手の範囲外の `M = 0` は可換性による `Qproj_mul_Xop_of_commute` | `eigenvalues_of_check_Vprime` Step 1 |
| `CheckFermiSetup.Xop_pow_mul_Qproj` / `Qproj_mul_Xop_pow` | `X̌^k Q̌_ε = ǧ(ε)^k Q̌_ε`・`Q̌_ε X̌^k = ǧ(ε)^k Q̌_ε` の帰納法（`k = 0` の 4 行と、`k + 1` の 8 行・7 行）の鎖と 1 対 1 の calc | `eigenvalues_of_check_Vprime` Step 2・Step 3' |
| `CheckFermiSetup.partialExpSum` / `partialExpSum_mul_Qproj` / `Qproj_mul_partialExpSum` | 部分和 `E_K := Σ_{k=0}^{K}(1/k!)X̌^k`（`Finset.range (K + 1)` の上の和）と、`E_KQ̌_ε`・`Q̌_εE_K` から `(Σ_{k=0}^{K}(1/k!)ǧ(ε)^k)Q̌_ε` までの人手の 8 行の鎖と 1 対 1 の calc。添字 `0` からの和をずらす行（`def_finite_sum_of_matrices_from_index_zero`・`def_finite_sum_of_complex_numbers_from_index_zero`）は mathlib の `Finset.sum_range`。極限の段（`Vprime_mul_Qproj`・`Qproj_mul_Vprime`）がこの鎖を各 `K` へ使う | `eigenvalues_of_check_Vprime` Step 3・Step 3' の部分和の鎖 |
| `CheckFermiSetup.Qproj_mulVec_Qproj_mulVec` | `Q̌_ε(Q̌_ε x) = Q̌_ε x`（`Q̌_ε^2` を `def_exp` (1) の冪から運ぶ 8 行）の鎖と 1 対 1 の calc。`M_col = r + 1`（人手の範囲 `M_col ≥ 2` を含む）で、最後の行は `Q̌_ε^2 = Q̌_ε` の具体版 `Qproj_sq_step1` を引く | `eigenvalues_of_check_Vprime` Step 4 の最初の鎖 |
| `CheckFermiSetup.partialExpSum_tendsto` / `complex_exp_partial_sum_tendsto` | `E_K → V̌'`（`def_exp` の `matExp_hasSum` の添字を `K ↦ K + 1` で送る。`matrix_exp_series_converges` の具体版は無い）と、数の `Σ_{k=0}^{K} z^k/k! → exp(z)`（人手 `scalar_exp_is_limit_of_partial_sums` の具体版は無く、mathlib の `NormedSpace.expSeries_div_hasSum_exp`） | 同 Step 3 の極限の鎖の 1 行目と 6 行目の根拠 |
| `CheckFermiSetup.Vprime_mul_Qproj` / `Qproj_mul_Vprime` | `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`（左右両方）。人手の極限の鎖の 7 行と 1 対 1 の calc（`lim` は `limUnder atTop`、乗法の連続性は `mul_right_tendsto_tensorPow`・`mul_left_tendsto_tensorPow`、スカラー倍の収束は `smul_tendsto_tensorPow`、極限の一意性は `Filter.Tendsto.limUnder_eq`（`matrix_norm_triangle_inequality` (4) の具体版は無い）、`complex_exp_of_real_argument` は mathlib の `Complex.ofReal_exp`） | 同 Step 3・Step 3' の極限の鎖 |
| `CheckFermiSetup.Vprime_mulVec_of_mem_range` | `im Q̌_ε` の元は固有ベクトル。人手の 5 行 `V̌'y = V̌'(Q̌_εy) = (V̌'Q̌_ε)y = ((exp ǧ)_ℂQ̌_ε)y = (exp ǧ)_ℂ(Q̌_εy) = (exp ǧ)_ℂy` と 1 対 1 の calc（結合則は mathlib の `Matrix.mulVec_mulVec`、スカラー倍は `smul_mulVec_tensorPow`）。`M_col = r + 1`（人手の範囲 `M_col ≥ 2` を含む） | 同 Step 4 の後半の鎖 |
| `CheckFermiSetup.VprimeUnits` / `Vprime_mul_Vprime_neg`（`ClaimTraceCheckVprime.lean`） | `(V̌')^{-1} = exp(-X̌)` | `def_check_Vprime` (2) |
| `CheckFermiSetup.sum_exp_gval` | `∑_ε e^{ǧ(ε)} = ∏_μ 2cosh(γ(θ~_μ)/2)` | `trace_of_check_Vprime` Step 2 |
| `CheckFermiSetup.trace_Vprime_step1` | `tr(V̌') = Σ_ε (exp ǧ(ε))_ℂ`。人手の 8 行の鎖と 1 対 1 の calc（`M_col = r + 1`。和は `NecSuf.binWordSum`、`Σ_εQ̌_ε = I` は `sum_Qproj_step2`、トレースと和・スカラー倍は `trace_binWordSum_tensorPow`・`trace_smul_tensorPow`） | `trace_of_check_Vprime` Step 1 |
| `CheckFermiSetup.trace_Vprime` | **`tr(V̌') = ∏_μ 2cosh(γ/2)`（前因子なし）**。`M = r + 1` では `trace_Vprime_step1` の和を `Finset.sum` へ付け替えて `sum_exp_gval` へつなぐ。人手の範囲外の `M = 0` は `trace_Vprime_eq_finset_sum_of_mathlib` | 同 Step 1〜2 |
| `CheckFermiSetup.trace_Vprime_inv` / `trace_Vprime_pos` | `tr((V̌')^{-1}) = tr(V̌') > 0` | 同 Step 3〜4 |
| `negI_mul_I_eq_one` / `negI_mul_negI_eq_neg_one` / `pauliX_mul_pauliZ_eq`（`ClaimH1PlusInSigmaZForm.lean`）、`pauliZ_mul_pauliY`（`DefinitionTransferMatrixSymbols.lean`）/ `pauliY_mul_pauliX_eq`（`ClaimV1InZYEpsilon.lean`） | `(-i)·i = 1`、`(-i)·(-i) = -1`、`σ^xσ^z = (-i)σ^y`、`σ^zσ^y = (-i)σ^x`、`σ^yσ^x = (-i)σ^z`（人手の鎖と 1 対 1） | `iH_is_real_symmetric` Step 0 |
| `H2_eq_neg_I_smul_sum_sigmaX` / `S2_eq_K2star_smul_sum_sigmaX` / `sigmaZ_castSucc_mul_sigmaZ_succ_kronecker` / `Y_castSucc_mul_Z_succ` / `Y_last_mul_Z_zero` / `S1plus_eq_K1_smul_sub`（`ClaimIHPauliForm.lean`） | `H_2 = -iΣσ^x_m`、`S_2 = K_2^*Σσ^x_m`、`S_1^{(+)} = K_1Σσ^z_mσ^z_{m+1} - K_1G`（人手の鎖と 1 対 1。Step 3 は下の行） | `iH_is_real_symmetric` Step 1〜2 |
| `sigmaX_transpose` / `sigmaZ_castSucc_mul_sigmaZ_succ_transpose` / `boundaryYXYFamily_eq_ite` / `boundaryYXY_transpose`（`ClaimIHPauliForm.lean`） | `(σ^x_m)^⊤ = σ^x_m`、`(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}`、準備の `G` の因子の並び、`G^⊤ = G`（人手の 5・5・11 行の鎖と 1 対 1） | `iH_is_real_symmetric` Step 3 の転置の鎖 |
| `sigmaX_hasRealEntries` / `sigmaZ_castSucc_mul_sigmaZ_succ_hasRealEntries`（`ClaimIHPauliForm.lean`） | `σ^x_m`・`σ^z_mσ^z_{m+1}` の成分はすべて実数（因子の並びと `siteProd_hasRealEntries`） | `iH_is_real_symmetric` Step 3 の成分の実性（`G` を除く） |
| `boundaryYXY_eq_neg_one_smul_real` / `boundaryYXY_hasRealEntries`（`ClaimIHPauliForm.lean`） | `G = (-1)_ℂ(R^y⊠σ^x⊠⋯⊠σ^x⊠R^y)`（人手の 7 行の鎖と 1 対 1）と、`G` の成分はすべて実数（`siteProd_hasRealEntries`・`real_smul_hasRealEntries`） | `iH_is_real_symmetric` Step 3 の `G` の成分の実性 |
| `S2_transpose_by_pauli_form` / `S1plus_transpose_by_pauli_form`（`ClaimIHPauliForm.lean`） | `(S_2)^⊤ = S_2`（人手の 5 行の鎖と 1 対 1）と `(S_1^{(+)})^⊤ = S_1^{(+)}`（人手の 7 行の鎖と 1 対 1） | `iH_is_real_symmetric` Step 3 の S_2・S_1^{(+)} の転置の鎖 |
| `S2_hasRealEntries` / `S1plus_hasRealEntries`（`ClaimIHPauliForm.lean`） | `S_2`・`S_1^{(+)}` の成分はすべて実数（係数 `K_2^*, K_1 ∈ ℝ` の包含。人手の 2 段落と 1 対 1） | `iH_is_real_symmetric` Step 3 の S_2・S_1^{(+)} の成分の実性 |
| `S2_isHermitian_of_real_symmetric` / `S1plus_isHermitian_of_real_symmetric` と、使う側が引く `S2_isHermitian` / `S2_transpose` / `S1plus_isHermitian` / `S1plus_transpose`（`ClaimIHPauliForm.lean`） | 実対称なのでエルミート（`real_symmetric_isHermitian`）。4 定理は `M_col ≥ 2` では Step 3 の鎖そのもので、係数の `star K = K` は `real_coefficient_of_star_eq`（人手の対応ブロックは無い。仮定の形の読み替え）で `(K.re)_ℂ` に読む | `iH_is_real_symmetric` Step 3 の最後の文と主張 |
| `VPlus`（章 014 の定義を再利用）/ `VPlus_eq_smul` | `V^{(+)}` は章 014 `EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean` のものを使う。`V^{(+)} = (2s_2)^{M/2}exp(S_1^{(+)}/2)exp(S_2)exp(S_1^{(+)}/2)` | `def_V_plus`、`V_plus_is_positive_definite` Step 1 |
| `VPlus_posDef` | `V^{(+)}` は正定値 | `V_plus_is_positive_definite` Step 2〜3 |
| `matExp_mul_matExp_neg_eq_one` / `matExp_neg_mul_matExp_eq_one` / `expHalfS1plus_mul_expNegHalfS1plus` / `expNegHalfS1plus_mul_expHalfS1plus` / `expS2_mul_expNegS2` / `expNegS2_mul_expS2`（`ClaimVPlusPositiveDefinite.lean`） | 指数行列どうしの左右逆 `E_±E_∓ = I`, `A_±A_∓ = I` | `V_plus_is_invertible` Step 1 |
| `VPlusInv` / `rpow_neg_half_M_eq_inv` / `VPlus_mul_VPlusInv` / `VPlusInv_mul_VPlus` | `R^{(+)}`、`a^{-1} = (2s_2)^{-M/2}`、`R^{(+)}` が `V^{(+)}` の右逆かつ左逆である | `V_plus_is_invertible` Step 2〜3 |
| `VPlusInv_posDef` | `(V^{(+)})^{-1}` の正定値性 | `V_plus_inverse_is_positive_definite` |
| `trace_VPlus_pos` | `tr(V^{(+)})` の正値性 | `trace_V_plus_is_positive` |
| `trace_VPlusInv_pos` | `tr((V^{(+)})^{-1})` の正値性 | `V_plus_inverse_positive_and_trace_positivity` |
| `tauPlus` / `matExp_half_mul_matExp_half` / `trace_VPlus`（`ClaimConstantCEvenSector.lean`） | `τ := tr(exp(S_1^{(+)})exp(S_2))`、`exp(X/2)^2 = exp(X)`、`tr(V^{(+)}) = (2s_2)^{M/2}τ` | `constant_c_value_even_sector` Step 1 |
| `trace_expNegS1plus_expNegS2_eq_tauPlus` / `trace_VPlusInv` | `tr(exp(-S_1^{(+)})exp(-S_2)) = τ`、`tr((V^{(+)})^{-1}) = (2s_2)^{-M/2}τ` | `constant_c_value_even_sector` Step 1〜2 |
| `VPlusInv_eq` | `V^{(+)} = cV̌' ⇒ (V^{(+)})^{-1} = c⁻¹(V̌')^{-1}` | 同 Step 3（逆元の一意性） |
| `constant_c_value_even_sector` | **`c = (2 sinh 2K_2)^{M/2}`** | `constant_c_value_even_sector` |
| `checkBigLambda` / `VPlus_mul_Qproj` / `Qproj_mul_VPlus`（`TheoremEigenvaluesVPlus.lean`） | `Λ̌_ε` と `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` | `eigenvalues_of_V_plus` (1) |
| `VPlus_mulVec_of_mem_range` | `im Q̌_ε` の元は `V^{(+)}` の固有ベクトル | 同 (1) |
| `checkBigLambda_pos` / `checkBigLambda_le_max` / `checkBigLambda_min_le` | 正値性・最大・最小 | 同 (2) |
| `checkBigLambda_max_mul_min` | `Λ̌_max Λ̌_min = (2 sinh 2K_2)^M = c^2` | 同 |
| `cos_thetaTilde_lt_one` / `one_lt_gamma1R_thetaTilde_checkIndex` | `cos θ~_μ < 1`, `γ_1(θ~_μ) > 1` | 章 015 `gamma1_gt_1_theta_tilde` |
| `gammaFn_thetaTilde_pos` | **`γ(θ~_μ) > 0`** | 章 015 `gamma_theta_tilde_mu_positive` |
| `checkIdxFinset_injOn` / `sum_checkIdx` | `𝓜̌` 上の和を `{0,…,M-1}` 上の和へ付け替える（`μ = k+1`） | （人手の鎖の行ではない添字の付け替え） |
| `tagPoint_half_eq_thetaTilde` | `t^{(M)}_μ|_{δ=1/2} = θ~_μ` | `def_Theta_delta_M`（`θ~_μ = θ^{(1/2)}_{M,μ}`） |
| `sum_Icc_one_gammaFn_tagPoint_eq_sum_fin` | `Λ^{(δ)}_M` の `Finset.Icc 1 M` の和を `Fin M` の和へ付け替える | （人手の鎖の行ではない添字の付け替え） |
| `checkBigLambda_univ_eq_LambdaM` | **`Λ̌_max = Λ^{(1/2)}_M`**（人手の 4 行の鎖と 1 対 1 の calc） | `max_eigenvalue_of_V_plus_simple` (1) |
| `gval_lt_gval_univ` / `checkBigLambda_lt_checkBigLambda_univ` / `checkBigLambda_lt_max_of_gammaFn` | **`ε ≠ (1,…,1) ⇒ Λ̌_ε < Λ̌_max`（狭義）**。前の 2 つは人手の (2) の `ǧ(1,…,1) − ǧ(ε)` の鎖・`Λ̌_ε` の鎖と 1 対 1 の calc（添字の付け替えは `gval_eq_sum_fin_real`）。`checkBigLambda_lt_max` は必要十分版 `NecSuf.sum_weight_lt_of_ne_univ`（同じ並びの calc。添字は任意の有限型）の特殊化 | 同 (2) |
| `checkBigLambda_smul_Qproj_mulVec_of_eigen` | `V^{(+)}x = Λ̌_max x` なら `Λ̌_{ε'}(Q̌_{ε'}x) = Λ̌_max(Q̌_{ε'}x)`（人手の 5 行の鎖と 1 対 1） | 同 (3) の左から `Q̌_{ε'}` を掛ける鎖 |
| `Qproj_mulVec_eq_zero_of_eigen` | `ε' ≠ (1,…,1)` なら `Q̌_{ε'}x = 0`（人手の `d(Q̌_{ε'}x) = O` の 4 行と `Q̌_{ε'}x = O` の 5 行と 1 対 1 の calc） | 同 (3) の割り算の鎖 |
| `colVec_eq_Qproj_mul_of_zero`（1 列の行列と 2 進語の上の和で人手の 4 行と 1 対 1 の calc） / `eq_Qproj_univ_mulVec_of_eigen`（数ベクトルへ運んだ形。必要十分版の特殊化は `eq_Qproj_univ_mulVec_of_eigen_of_necSuf`） | **固有値 `Λ̌_max` の固有ベクトルは `im Q̌_{(1,…,1)}` に入る** | 同 (3) の `x = Q̌_{(1,…,1)}x` の鎖 |
| `VPlus_mulVec_of_mem_range_Qproj_univ`（人手の 6 行と 1 対 1 の calc。必要十分版の特殊化は `VPlus_mulVec_of_mem_range_Qproj_univ_of_necSuf`） | **逆に `im Q̌_{(1,…,1)}` の各元は固有値 `Λ̌_max` の固有ベクトル** | 同 (3) の逆向きの鎖 |
| `finrank_range_Qproj_univ` | **その空間の次元は `1`（単純固有値）** | 同 (3) の最後（`check_joint_eigenspace_decomposition` (4)） |
| `CheckFermiSetup.isInternal_range_Qproj` | **`ℂ^{2^M} = ⊕_ε im Q̌_ε`（内部直和。各成分は 1 次元）** | `check_joint_eigenspace_decomposition` (5) |
| `CheckFermiSetup.iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | 同 (5) を `Submodule` の言葉で分けて述べた版 | 同 (5) |
| `CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime` | **`V̌'` は対角化可能** | `eigenvalues_of_check_Vprime` |
| `exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus` | **`V^{(+)}` は対角化可能（固有値は `Λ̌_ε`）** | `eigenvalues_of_V_plus` |
| `Ising2D.V_plus_eigenvalues_with_c_value_and_strict_maximum`（`ClaimVPlusEigenvaluesWithCValueAndStrictMaximum.lean`） | 章末の主張: `V^{(+)} = (2 sinh 2K_2)^{M/2} exp(Σ_μ γ(θ~_μ)(ň_μ - ½I))`、`V^{(+)}Q̌_ε = Λ̌_εQ̌_ε`、`Λ^{(1/2)}_M = Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M/2} exp(½Σ_μ γ(θ~_μ))`、`ε ≠ (1,…,1) ⇒ Λ̌_ε < Λ̌_{(1,…,1)}`（既存の主張を並べたもの） | `V_plus_eigenvalues_with_c_value_and_strict_maximum` |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_check_number_operator` | `CheckFermiSetup.nOp` | `NecSuf.numPaired`（= `NecSuf.num` に付け替えを噛ませたもの） |
| `check_number_operator_idempotent` | `CheckFermiSetup.cre_sq` / `ann_sq` / `ann_mul_cre` / `nOp_sq` / `nOp_mul_self` | `NecSuf.sq_eq_zero_of_acomm_self` / `ann_mul_cre` / `num_mul_num`（**章 009 と同一**） |
| `check_number_operators_commute` | `CheckFermiSetup.mul_eq_neg_of_anticomm_eq_zero` / `mul_nOp_of_anticommute` / `commute_*` / `nOp_mul_nOp_of_ne` | `NecSuf.commute_mul_of_anticommute` / `NecSuf.commute_cre_num` / `commute_ann_num` / `commute_num_num`（**章 009 と同一**） |
| `trace_of_check_number_operator_product` | `CheckFermiSetup.trace_projFactorProd` / `trace_nOpProd` | `NecSuf.two_pow_smul_tau_projOn`（混在の因子）/ `NecSuf.two_pow_smul_tau_noncommProd`（`ň` だけの積） |
| `check_joint_eigenspace_decomposition` (1)(2)(3)(4) | `CheckFermiSetup.Qproj_*` / `sum_Qproj` / `nOp_mul_Qproj` / `trace_Qproj` | `NecSuf.projOn_*` / `sum_projOn` / `num_mul_projOn` / `two_pow_smul_tau_projOn`（**章 009 と同一**） |
| `eigenvalues_of_check_Vprime` | `CheckFermiSetup.Vprime_mul_Qproj` / `Qproj_mul_Vprime`（Step 3・Step 3' の極限の鎖と 1 対 1 の calc。特殊化は `ClaimEigenvaluesCheckVprimeFromNecSuf.lean` の `Vprime_mul_Qproj_of_necSuf` / `Qproj_mul_Vprime_of_necSuf`） | `NecSuf.exp_mul_eq_of_mul_eq_smul`（章 009 と同一）／その左右反転 `NecSuf.mul_exp_eq_of_mul_eq_smul` |
| `constant_c_value_even_sector` | `Ising2D.constant_c_value_even_sector` | `NecSuf.const_eq_of_trace_ratio` |
| `eigenvalues_of_V_plus` (2) | `checkBigLambda_le_max` / `checkBigLambda_min_le` | `NecSuf.sum_weight_le_univ` / `sum_weight_empty_le` |
| `max_eigenvalue_of_V_plus_simple` (2)(3) | `checkBigLambda_lt_checkBigLambda_univ`（必要十分版の特殊化は `checkBigLambda_lt_max`） / `eq_Qproj_univ_mulVec_of_eigen`（特殊化は `eq_Qproj_univ_mulVec_of_eigen_of_necSuf`） / `VPlus_mulVec_of_mem_range_Qproj_univ`（特殊化は `VPlus_mulVec_of_mem_range_Qproj_univ_of_necSuf`） | `NecSuf.sum_weight_lt_of_ne_univ` / `NecSuf.eq_proj_of_eigen` / `NecSuf.act_eq_smul_of_proj_fixed` |
| `check_joint_eigenspace_decomposition` (5) | `CheckFermiSetup.isInternal_range_Qproj` / `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | `NecSuf.isInternal_range_proj`（**章 009 と同一**） |
| `eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus`（対角化可能） | `CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime`、`exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus` | `NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj`（**章 009 と同一**） |

具体版はいずれも**必要十分版を特殊化しても得ている**。ただし `check_number_operator_idempotent` の `cre_sq`・`ann_sq`・`ann_mul_cre`・`nOp_sq`・`nOp_mul_self` と `check_number_operators_commute` の `mul_eq_neg_of_anticomm_eq_zero`・`mul_nOp_of_anticommute`・`commute_cre_nOp`・`commute_ann_nOp`・`nOp_mul_nOp_of_ne` は人手の鎖と 1 対 1 の calc で、特殊化として得たものは `*_of_necSuf` の名前で並べて置く。`check_joint_eigenspace_decomposition` の証明の Step 0 の冒頭と 4 本の鎖は `nOp_mul_nOp_of_sq`・`nOp_mul_one_sub_nOp`・`one_sub_nOp_mul_nOp`・`one_sub_nOp_mul_self`・`nOp_add_one_sub_nOp`、Step 3 の二つの場合の鎖は `nOp_mul_projFactor_of_mem`・`nOp_mul_projFactor_of_not_mem` が人手と 1 対 1 の calc である。Step 1 の `ε ≠ ε'` の鎖は `projFactor_mul_projFactor_eq_zero_step1`・`projFactor_comm_factor_step1`・`Qproj_mul_Qproj_of_ne_step1` が人手と 1 対 1 の calc で、(1) 前半の `Qproj_mul_Qproj_of_ne` は人手の範囲 `M_col ≥ 2` でそれを使う（範囲外の `M = 0, 1` は `Qproj_mul_Qproj_of_ne_of_necSuf`）。Step 1 の `ε = ε'` の鎖は `Qproj_sq_eq_mul_self_step1`・`Qproj_mul_self_step1`・`Qproj_sq_step1` が人手と 1 対 1 の calc で（7 行目の「各因子の冪等性」は場合分けで Step 0 の定理を引く `projFactor_mul_self_step0`）、(1) 後半の `Qproj_mul_self` は `M ≥ 1` でそれを使う（`M = 0` は `Qproj_mul_self_of_necSuf`）。Step 2 の鎖は `sum_Qproj_step2` が人手と 1 対 1 の calc で、(2) の `sum_Qproj` は `M ≥ 1` でそれを使う（`M = 0` は `sum_Qproj_of_necSuf`）。Step 3 の鎖は `nOp_mul_projFactor_comm_step3`・`nOp_mul_projFactor_step3`・`nOp_mul_Qproj_step3`・`Qproj_mul_nOp_step3` が人手と 1 対 1 の calc で、(3) の `nOp_mul_Qproj`・`commute_nOp_Qproj` は人手の範囲 `M_col ≥ 2` でそれを使う（範囲外の `M = 0, 1` は `*_of_necSuf`）。Step 4 の鎖は `trace_Qproj_step4` が人手と 1 対 1 の calc で、(4) 前半の `trace_Qproj` はそれから示す。Step 5 の鎖は、人手が数ベクトルを扱う 1 列の行列で書いた `colVec_eq_sum_Qproj_mul_step5`・`Qproj_mul_colVec_of_ne_step5`・`Qproj_mul_colVec_self_step5`・`eq_zero_of_binWordSum_eq_zero_step5` が人手と 1 対 1 の calc で、(5) の `sum_Qproj_mulVec`・`eq_zero_of_sum_eq_zero` は人手の範囲 `M_col ≥ 2` で `Matrix.replicateCol (Fin 1)` を通してそれを使う（範囲外の `M = 0` は mathlib の `Matrix.sum_mulVec` ほかで閉じる）。 `trace_of_check_number_operator_product` は、人手の帰納法と 1 対 1 の calc が `trace_projFactor_finProdLeft`（と基底段階・準備・二場合の定理）で、必要十分版の特殊化が `trace_projFactorProd`・`trace_nOpProd` である。

### 必要十分版で判明した本質

- **直和分解と対角化可能性は、章 009 と文字どおり同じ必要十分版 1 本で足りる。**
  章 009 と章 017 の違い（同時固有空間の次元が `2^{M-m}` か `1` か、和の範囲が `𝓘` か `𝓜̌` か）は
  必要十分版の仮定にまったく現れない。効いているのは「有限個の直交射影の和が恒等」と
  「固有関係 `f Q̌_ε = Λ̌_ε Q̌_ε`」だけである。

- **整数運動量版と半整数運動量版は、同じ必要十分版の別の特殊化である。**
  違いは「対をなす添字を与える写像 `σ`」だけで、章 009 は `σ(μ) = -μ`、
  章 017 は `σ(μ) = M+1-μ`。しかも必要十分版に効いているのは
  **`σ` が単射であることだけ**で、対合であることすら要らない
  （対合性は人手証明が `ň_μ` の個数を数えるのに使うだけである）。
  人手証明が「009 章の `-μ` をそのまま写してはならない」と警告している箇所は、
  必要十分版では `σ` を差し替える 1 箇所に集約される。

- **人手証明が「`𝓜̌` へ絞ったので合同式の計算が要らない」と書いている点**は、
  必要十分版では `Function.Injective σ` から `σ j = σ i ↔ j = i` が出る、というだけである
  （`NecSuf.acomm_cre_ann_comp`）。`M+1-μ` という具体形も、
  `{1,…,M}` に閉じていることも効いていない。

- **`c` の決定（`constant_c_value_even_sector`）に、行列もトレースも指数関数も効いていない。**
  効いているのは体 ℂ の中の 4 つの等式 `T = cp`, `T' = c⁻¹p`, `T = aτ`, `T' = a⁻¹τ` と
  `a > 0`, `p > 0`, `T > 0` だけである（`NecSuf.const_eq_of_trace_ratio`）。
  正定値性も「`tr(V^{(+)})` が正の実数である」という**数**としてしか使われていない。
  **章 009 の `constant_c_value` も同じ補題の特殊化である。**

- **最大固有値の単純性 (3) に、直和分解 (5) は要らない。**
  人手証明は「`x = ∑_ε Q̌_ε x` と (5) の直和性から各項が `0`」と書いているが、
  効いているのは `∑_ε Q̌_ε = 1` と `Q̌_ε V^{(+)} = Λ̌_ε Q̌_ε`（**左からの**固有関係）と
  `Λ̌_ε ≠ Λ̌_max` の 3 つだけで、`Q̌_ε^2 = Q̌_ε` も `Q̌_ε Q̌_{ε'} = 0` も
  有限次元性も使っていない（`NecSuf.eq_proj_of_eigen`）。
  人手証明が `V Q = ΛQ` と `Q V = ΛQ` を区別していないのは `V` と `Q` が可換だからで、
  Lean では `Qproj_mul_Vprime` として明示的に用意した。

- **最大性の狭義性 (2) に効いているのは「重みがすべて狭義に正」だけ**である
  （`NecSuf.sum_weight_lt_of_ne_univ`）。指数関数も転送行列も固有値も効いていない。
  章 009 が単純性を言えなかった理由も、この 1 点（`γ(θ_μ) ≥ 0` しか無い）に還元される。

---

## 3. 形式化できなかった主張とその理由

| 原文の主張 | 状況 | 理由 |
| --- | --- | --- |
| `anticommutator_of_check_psi`（章 015）と `V_plus_eq_c_check_Vprime`（章 016） | **仮定として受け取った** | 章 014・015・016 は並行して形式化中。前者は `CheckFermiSetup` の場 `hcc` / `haa` / `hca` として、後者は `constant_c_value_even_sector` などの仮定 `hVeq : VPlus … = c • F.Vprime g` として明示した |
| `γ(θ~_μ)` と `g : CheckIdx M → ℝ` の同定 | **仮定として受け取った（ただし本章内で埋められる）** | 章 009 と同じく `g` を実数の族として受け取っている。`g i = gammaFn P (thetaTilde M i.1)` を仮定すると `Λ̌_max = Λ^{(1/2)}_M` と狭義最大性が出る（`checkBigLambda_univ_eq_LambdaM`, `checkBigLambda_lt_max_of_gammaFn`）。`γ(θ~_μ) > 0` そのものは**無条件に証明済み**（`gammaFn_thetaTilde_pos`） |
| `eigenvalues_of_check_Vprime` / `eigenvalues_of_V_plus` の「対角化可能」 | **形式化した（2026-07-30）** | `Ising2D.CheckFermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime`、`Ising2D.exists_eigenBasis_VPlus` / `exists_conj_diagonal_VPlus`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimDirectSumAndDiagonalization.lean`）。章 009 とまったく同じ必要十分版 `Ising2D.NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` の特殊化である |
| `check_joint_eigenspace_decomposition` (5) の `DirectSum.IsInternal` 形 | **形式化した（2026-07-30）** | `Ising2D.CheckFermiSetup.isInternal_range_Qproj`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimDirectSumAndDiagonalization.lean`）。`Submodule` の言葉での前半・後半は `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj`。必要十分版は章 009 と共通（`NecSuf/JointEigenspaceDecomposition.lean`） |

---

## 4. 人手証明に見つかった問題

**結論を覆す誤りは見つからなかった。** 冗長・不要と分かった箇所が 3 つある
（`exact-solution-of-2d-ising-model/docs/tasks/2026-07_lean-ch009-013/004_ch017_冗長な手順と暗黙の前提.md`
に一次情報つきで記録した）。要約:

1. `check_joint_eigenspace_decomposition` (4) の二項展開と二項定理は**不要**
   （章 009 で既に判明していたのと同じ理由）。
2. `max_eigenvalue_of_V_plus_simple` (3) の証明が引用している
   `check_joint_eigenspace_decomposition` (5)（直和分解）は**不要**。
   `∑_ε Q̌_ε = I` と固有関係だけで固有空間が同定できる。
3. `V_plus_inverse_is_positive_definite` の statement は `(V^{(+)})^{-1}` も正定値だと述べるが、
   章 009 の `V_is_positive_definite` には対応する主張が無い
   （章 009 は `V^{-1}` の明示形までしか出していない）。本章で `VPlusInv_posDef` として補った。
