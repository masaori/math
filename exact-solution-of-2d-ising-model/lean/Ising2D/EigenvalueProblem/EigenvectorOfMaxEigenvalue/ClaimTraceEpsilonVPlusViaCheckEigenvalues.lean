/-
# `tr(ε V^{(+)})` を `η_{(1,…,1)}` で表す（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_003_claim_trace_epsilon_V_plus_via_eigenvalues`、
ラベル **`trace_of_epsilon_V_plus_via_check_eigenvalues`**）

必要十分版は Step ごとに置く（下の対応表）。`Ising2D/NecSuf/ParityFermion.lean` の
`Ising2D.NecSuf.sum_powerset_signed_exp`（冪集合の上の和を一度に積へ変える）は人手の Step 2〜5 と手順が違い、
本ファイルの具体版はもう使っていない。

## 章 017 から受け取る入力

原文 `eigenvalues_of_V_plus` は

  `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`,
  `Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(∑_μ γ(θ̃_μ)(ε_μ - 1/2))`

を主張する（章 017、Lean 未形式化）。これを構造 `Ising2D.VPlusData` として受け取る。
`C = (2 sinh 2K_2)^{M/2} > 0` と `γ(θ̃_μ) > 0`（原文 `gamma_theta_tilde_mu_positive`、
章 015 の `gamma1_gt_1_theta_tilde` の帰結）も仮定に含める。
**`γ(θ̃_μ) > 0` が半整数運動量に固有の要点であり、これがあるので `sinh` の積が `0` にならない。**
## 原文の鎖との対応

| 原文の行 | Lean |
| --- | --- |
| Step 1 の 13 行の鎖 `tr(εV^{(+)}) = … = Σ_εη_ε(Λ̌_ε)_ℂ` | `VPlusData.trace_epsilon_mul_V_step1`（同じ行の calc。人手の `M_col` が `r + 1`） |
| Step 2 の `(Π_{μ≤k}ǔ^{(ε_μ)})_ℂ = (−1_ℂ)^{k−\|ε\|_k}` の `k` の帰納法（`k = 1` の 5 行・7 行、`k → k+1` の 6 行・6 行）と準備の `ǔ^{(e)}`・`\|ε\|_k` の数え上げ | `checkU_prod_eq_neg_one_pow`（同じ行の calc。人手の `k` が `n + 1`）・`checkU`・`ite_eq_one_eq_val`・`card_finsetOfWord_one`・`card_finsetOfWord_castSucc`・`card_finsetOfWord_le`（必要十分版の特殊化は `checkU_prod_eq_neg_one_pow_of_necSuf`。必要十分版は `NecSuf/PowerFromProductOfTwoValuedFactors.lean`） |
| Step 3 の `η_ε(Λ̌_ε)_ℂ = … = (ť_εȟ)_ℂ` の 7 行と準備の `ȟ`・`ť_ε` | `VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH`（同じ行の calc。人手の `M_col` が `r + 1`）・`CheckFermi.checkH`・`CheckFermi.checkH_mem`・`CheckFermi.checkH_ofReal`・`VPlusData.checkT`（必要十分版の特殊化は `eta_mul_checkLambda_eq_checkT_mul_checkH_of_necSuf`。必要十分版は `NecSuf/SignedTermAsImageOfReorderedProduct.lean`） |
| Step 4 の 1 本目の 7 行の鎖 `ť_ε = … = (Π_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2}` と `w̌_μ^{(e)}` の置き方 | `VPlusData.checkT_eq_prod_checkW_mul`（同じ行の calc。人手の `M_col` が `r + 1`）・`VPlusData.checkW`・`checkLambda_finsetOfWord`・`ite_eq_one_eq_val_real`（`Λ̌_ε` の定義を語の成分で読む運ぶ段）。必要十分版は置かない（効くのは、引いた `real_exp_of_finite_sum`・`finite_product_of_real_products`（それぞれ必要十分版あり）と ℝ の `a(bc) = b(ac)`・`ab = ba` だけで、この鎖に固有の取り払える構造が無い） |
| 主張の `ϰ` の置き方と Step 4 の 2 本目の和の鎖 `Σ_εť_ε = … = ϰ` | `VPlusData.traceFactor`・`VPlusData.sum_checkT_eq_traceFactor`（同じ行の calc。人手の `M_col` が `r + 1`、和は `binaryWordRealSum r`。`w̌_μ^{(e)}` の `e` を ℝ の `1`・`0` へ付け替える運ぶ段が 1 つある。必要十分版は置かない） |
| Step 5 の 8 行の鎖 `tr(εV^{(+)}) = Σ_εη_ε(Λ̌_ε)_ℂ = … = η_{(1,…,1)}ϰ_ℂ`（(1) の等式） | `VPlusData.trace_epsilon_mul_V_step5`（同じ行の calc。人手の `M_col` が `r + 1`。Step 1 の和 `NecSuf.binWordSum r` を具体版 `binaryWordComplexSum r` へ付け替える運ぶ段が 1 つある。必要十分版は置かない）。`M` を一般に取る形が `VPlusData.trace_epsilon_mul_V`（人手の範囲外の `M = 0` は mathlib の `simp`） |
| Step 6 の 4 本の鎖（(2) の不等号）`γ(θ̃_μ)/2 > 0`、`2sinh(γ(θ̃_μ)/2) > 0`、`Π_μ2sinh(γ(θ̃_μ)/2) > 0`、`ϰ > 0` | `VPlusData.gam_half_pos`・`VPlusData.two_sinh_gam_half_pos`・`VPlusData.prod_two_sinh_gam_half_pos`・`VPlusData.traceFactor_pos_step6`（1・2・4 本目は同じ行の calc、人手が 1 行の 3 本目は `finite_product_of_positive_reals_is_positive` の適用 1 つ。人手の `M_col` が `r + 1`。必要十分版は置かない）。`M` を一般に取る形が `VPlusData.traceFactor_pos`（人手の範囲外の `M = 0` は mathlib の `simp`） |
| Step 7 | `eta_univ_eq_one_of_trace_pos`（旧い Step の分け方のまま。Step 7 の同値と 1 対 1 にするのは状態台帳の次の一歩） |
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonEigenvalueOnCheckQ
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWords
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.NecSuf.PowerFromProductOfTwoValuedFactors
import Ising2D.NecSuf.SignedTermAsImageOfReorderedProduct
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealProducts
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimRealInclusionPreservesSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicProperties
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfPositiveRealsIsPositive

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 原文 `eigenvalues_of_V_plus` の `Λ̌_ε`。 -/
noncomputable def checkLambda (C : ℝ) (gam : Fin M → ℝ) (T : Finset (Fin M)) : ℝ :=
  C * Real.exp (∑ μ : Fin M, gam μ * ((if μ ∈ T then (1 : ℝ) else 0) - 1 / 2))

theorem checkLambda_pos {C : ℝ} (hC : 0 < C) (gam : Fin M → ℝ) (T : Finset (Fin M)) :
    0 < checkLambda C gam T := by
  unfold checkLambda
  positivity

/-- `Λ̌_ε ≤ Λ̌_{(1,…,1)}`（原文 `eigenvalues_of_V_plus` (2)）。 -/
theorem checkLambda_le_univ {C : ℝ} (hC : 0 < C) {gam : Fin M → ℝ} (hgam : ∀ μ, 0 < gam μ)
    (T : Finset (Fin M)) : checkLambda C gam T ≤ checkLambda C gam Finset.univ := by
  unfold checkLambda
  refine mul_le_mul_of_nonneg_left (Real.exp_le_exp.2 ?_) hC.le
  refine Finset.sum_le_sum fun μ _ => ?_
  by_cases h : μ ∈ T
  · simp [h]
  · rw [if_neg h, if_pos (Finset.mem_univ μ)]
    nlinarith [hgam μ]

/-- `T ≠ (1,…,1)` なら **狭義に** `Λ̌_ε < Λ̌_{(1,…,1)}`（最大固有値の単純性の根拠）。 -/
theorem checkLambda_lt_univ {C : ℝ} (hC : 0 < C) {gam : Fin M → ℝ} (hgam : ∀ μ, 0 < gam μ)
    {T : Finset (Fin M)} (hT : T ≠ Finset.univ) :
    checkLambda C gam T < checkLambda C gam Finset.univ := by
  obtain ⟨ν, hν⟩ : ∃ ν : Fin M, ν ∉ T := by
    by_contra hc
    push_neg at hc
    exact hT (Finset.eq_univ_of_forall hc)
  unfold checkLambda
  refine mul_lt_mul_of_pos_left (Real.exp_lt_exp.2 ?_) hC
  refine Finset.sum_lt_sum (fun μ _ => ?_) ⟨ν, Finset.mem_univ ν, ?_⟩
  · by_cases h : μ ∈ T
    · simp [h]
    · rw [if_neg h, if_pos (Finset.mem_univ μ)]
      nlinarith [hgam μ]
  · rw [if_neg hν, if_pos (Finset.mem_univ ν)]
    nlinarith [hgam ν]

/-- **章 017 `eigenvalues_of_V_plus` から受け取る入力**。 -/
structure VPlusData (M : ℕ) (F : CheckFermi M) where
  /-- `V^{(+)}` -/
  V : TensorPow M
  /-- `(2 sinh 2K_2)^{M/2}` -/
  C : ℝ
  hC : 0 < C
  /-- `γ(θ̃_μ)` -/
  gam : Fin M → ℝ
  hgam : ∀ μ, 0 < gam μ
  hV : ∀ T : Finset (Fin M),
    V * F.Qproj T = ((checkLambda C gam T : ℝ) : ℂ) • F.Qproj T

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- `Λ̌_{max} = Λ̌_{(1,…,1)}`。 -/
noncomputable def lamMax : ℝ := checkLambda D.C D.gam (Finset.univ : Finset (Fin M))

theorem lamMax_pos : 0 < D.lamMax := checkLambda_pos D.hC D.gam _

theorem checkLambda_le_lamMax (T : Finset (Fin M)) : checkLambda D.C D.gam T ≤ D.lamMax :=
  checkLambda_le_univ D.hC D.hgam T

/-! ## Step 1: トレースの分解 -/

/-- **原文 Step 1** の 13 行の鎖:
`tr(εV^{(+)}) = tr((εV^{(+)})I) = tr((εV^{(+)})Σ_εQ̌_ε) = tr(Σ_ε(εV^{(+)})Q̌_ε) = Σ_εtr((εV^{(+)})Q̌_ε)
= Σ_εtr(ε(V^{(+)}Q̌_ε)) = Σ_εtr(ε((Λ̌_ε)_ℂQ̌_ε)) = Σ_εtr((Λ̌_ε)_ℂ(εQ̌_ε)) = Σ_εtr((Λ̌_ε)_ℂ(η_εQ̌_ε))
= Σ_εtr(((Λ̌_ε)_ℂη_ε)Q̌_ε) = Σ_ε((Λ̌_ε)_ℂη_ε)tr(Q̌_ε) = Σ_ε((Λ̌_ε)_ℂη_ε)1_ℂ = Σ_ε(Λ̌_ε)_ℂη_ε = Σ_εη_ε(Λ̌_ε)_ℂ`
（人手の `M_col` が Lean の `r + 1`、`Q̌_ε` が `F.Qproj (CheckFermi.finsetOfWord ε)`。2〜3 行目の行列の和
（`def_sum_over_binary_words`）も 4〜13 行目の複素数の和（`def_sum_over_binary_words_of_complex_numbers`）も
`NecSuf.binWordSum r` である）。`mat_mult_associative`・`scalar_multiple_is_associative` の行は、Lean の具体版が無いので
mathlib の `Matrix.mul_assoc`・`smul_smul` で受ける（`ClaimTraceCheckVprime.lean` の `Vprime_inv_mul_Qproj` と同じ扱い）。 -/
theorem trace_epsilon_mul_V_step1 {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) :
    (epsilon (r + 1) * D.V).trace
      = NecSuf.binWordSum r (fun ε =>
          F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)) :=
  calc (epsilon (r + 1) * D.V).trace
      = (epsilon (r + 1) * D.V * 1).trace := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`（`A → εV^{(+)}`）を右辺から左辺へ
    _ = (epsilon (r + 1) * D.V * NecSuf.binWordSum r (fun ε => F.Qproj (CheckFermi.finsetOfWord ε))).trace := by
        rw [CheckFermi.binWordSum_Qproj F]              -- `check_joint_eigenspace_decomposition` (2) を右辺から左辺へ
    _ = (NecSuf.binWordSum r (fun ε => epsilon (r + 1) * D.V * F.Qproj (CheckFermi.finsetOfWord ε))).trace := by
        rw [mul_binWordSum_tensorPow]                   -- `sum_over_binary_words_distributes_in_right_factor`
                                                        -- （`C → εV^{(+)}`、`X_ε → Q̌_ε`）
    _ = NecSuf.binWordSum r (fun ε => (epsilon (r + 1) * D.V * F.Qproj (CheckFermi.finsetOfWord ε)).trace) :=
        trace_binWordSum_tensorPow r _                  -- `trace_of_sum_over_binary_words`（`B_ε → (εV^{(+)})Q̌_ε`）
    _ = NecSuf.binWordSum r (fun ε => (epsilon (r + 1) * (D.V * F.Qproj (CheckFermi.finsetOfWord ε))).trace) := by
        congr 1; funext ε; rw [Matrix.mul_assoc]        -- `mat_mult_associative` を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          (epsilon (r + 1) * (((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) • F.Qproj (CheckFermi.finsetOfWord ε))).trace) := by
        congr 1; funext ε; rw [D.hV]                    -- `eigenvalues_of_V_plus` (1) の `V^{(+)}Q̌_ε = Λ̌_εQ̌_ε` を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          (((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) • (epsilon (r + 1) * F.Qproj (CheckFermi.finsetOfWord ε))).trace) := by
        congr 1; funext ε; rw [mul_smul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_right_factor`
                                                        -- （`a → (Λ̌_ε)_ℂ`、`A → ε`、`B → Q̌_ε`）を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          (((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)
            • (F.eta (CheckFermi.finsetOfWord ε) • F.Qproj (CheckFermi.finsetOfWord ε))).trace) := by
        congr 1; funext ε; rw [F.epsilon_mul_Qproj]     -- `epsilon_eigenvalue_on_check_Q` (1) の `εQ̌_ε = η_εQ̌_ε` を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          ((((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) * F.eta (CheckFermi.finsetOfWord ε))
            • F.Qproj (CheckFermi.finsetOfWord ε)).trace) := by
        congr 1; funext ε; rw [smul_smul]               -- `scalar_multiple_is_associative`
                                                        -- （`a → (Λ̌_ε)_ℂ`、`b → η_ε`、`A → Q̌_ε`）を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          (((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) * F.eta (CheckFermi.finsetOfWord ε))
            * (F.Qproj (CheckFermi.finsetOfWord ε)).trace) := by
        congr 1; funext ε; exact trace_smul_tensorPow _ _
                                                        -- `trace_of_scalar_multiple`
                                                        -- （`α → (Λ̌_ε)_ℂη_ε`、`A → Q̌_ε`）を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          (((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) * F.eta (CheckFermi.finsetOfWord ε)) * 1) := by
        congr 1; funext ε; rw [F.trace_Qproj]           -- `check_joint_eigenspace_decomposition` (4) の `tr(Q̌_ε) = 1` を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) * F.eta (CheckFermi.finsetOfWord ε)) := by
        congr 1; funext ε; exact mul_one _              -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε =>
          F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)) := by
        congr 1; funext ε; exact mul_comm _ _           -- `complex_numbers_form_a_field` の乗法の交換則を各項へ同時に

/-- `tr(εV^{(+)}) = Σ_T η_T Λ̌_T`（和は部分集合の上の `Finset.sum`）。人手の主張の行ではなく、`trace_epsilon_mul_V` の
人手の範囲外の `M = 0` の場合だけが使う形である（`M = r + 1` の場合は Step 5 の鎖 `trace_epsilon_mul_V_step5` を通る）。`M = r + 1` は Step 1 の鎖 `trace_epsilon_mul_V_step1` を通し、
人手の和 `NecSuf.binWordSum` を語から部分集合への全単射 `finsetOfWord` で `Finset.sum` へ付け替える（運ぶ段。人手の行は無い）。
人手の範囲外の `M = 0` は mathlib の `Matrix.trace_sum`・`Matrix.trace_smul` で閉じる。 -/
theorem trace_epsilon_mul_V_eq_sum :
    (epsilon M * D.V).trace
      = ∑ T : Finset (Fin M), F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ) := by
  match M, F, D with
  | 0, F, D =>
    have hdecomp : epsilon 0 * D.V = ∑ T : Finset (Fin 0), (epsilon 0 * D.V * F.Qproj T) := by
      rw [← Finset.mul_sum, F.sum_Qproj, mul_one]
    rw [hdecomp, Matrix.trace_sum]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [Matrix.mul_assoc, D.hV T, Matrix.mul_smul, F.epsilon_mul_Qproj T, smul_smul, Matrix.trace_smul,
      F.trace_Qproj T, smul_eq_mul, mul_one, mul_comm]
  | r + 1, F, D =>
    calc (epsilon (r + 1) * D.V).trace
        = NecSuf.binWordSum r (fun ε =>
            F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)) :=
          trace_epsilon_mul_V_step1 D                   -- Step 1 の鎖
      _ = ∑ ε : Fin (r + 1) → Fin 2,
            F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) :=
          NecSuf.binWordSum_eq_sum r _                  -- 必要十分版（加法についての可換モノイド）
      _ = ∑ T : Finset (Fin (r + 1)), F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ) :=
          Fintype.sum_bijective CheckFermi.finsetOfWord CheckFermi.finsetOfWord_bijective _ _ (fun _ => rfl)
                                                        -- 語から部分集合への全単射で添字を付け替える（運ぶ段）

end VPlusData

/-! ## Step 2: 符号の冪を実数の積の包含で表す

人手の語 `ε ∈ {0,1}^𝓜̌` は Lean の `ε : Fin (n + 1) → Fin 2`（`ε_{j+1} = ε j`）、人手の `k` は Lean の `n + 1` である。
人手は `ε` を固定して `k` の帰納法を回し、`|ε|_k` を先頭の `k` 成分の `1` の個数とする。Lean は長さ `n + 1` の語について
示し、帰納法の仮定を先頭の `k` 成分の語 `fun μ => ε (Fin.castSucc μ)` に当てる（`|ε|_k` はその語の `1` の個数で、
人手の `|ε|_k` と同じ数である）。`|ε|` は `(CheckFermi.finsetOfWord ε).card` で、
`epsilon_eigenvalue_on_check_Q` (3) の `eta_eq_eta_univ_mul` の指数 `M - T.card` と同じ形である。 -/

/-- 準備の `ǔ^{(1)} := 1`、`ǔ^{(0)} := −1 ∈ ℝ`。 -/
def checkU (e : Fin 2) : ℝ := if e = 1 then 1 else -1

theorem checkU_one : checkU 1 = 1 := rfl

theorem checkU_zero : checkU 0 = -1 := rfl

/-- 数え上げの項 `[e = 1]` は `e ∈ {0,1}` の値に等しい。 -/
theorem ite_eq_one_eq_val (e : Fin 2) : (if e = 1 then 1 else 0) = e.val := by
  rcases binaryWord_fin_two_eq_one_or_zero e with rfl | rfl <;> rfl

/-- `ite_eq_one_eq_val` の値を ℝ に取った形（`e ∈ {0,1}` を ℝ の元として読む。Step 4 の `Λ̌_ε` の定義の読み替えが使う）。 -/
theorem ite_eq_one_eq_val_real (e : Fin 2) : (if e = 1 then (1 : ℝ) else 0) = ((e : ℕ) : ℝ) := by
  rcases binaryWord_fin_two_eq_one_or_zero e with rfl | rfl <;> simp

/-- 準備の `|ε|_1 = ε_1`（数え上げの定義）。 -/
theorem card_finsetOfWord_one (ε : Fin 1 → Fin 2) : (CheckFermi.finsetOfWord ε).card = (ε 0).val := by
  unfold CheckFermi.finsetOfWord
  rw [Finset.card_filter, Fin.sum_univ_one, ite_eq_one_eq_val]

/-- 準備の `|ε|_{k+1} = |ε|_k + ε_{k+1}`（数え上げの定義）。 -/
theorem card_finsetOfWord_castSucc {n : ℕ} (ε : Fin (n + 1) → Fin 2) :
    (CheckFermi.finsetOfWord ε).card
      = (CheckFermi.finsetOfWord (fun μ : Fin n => ε (Fin.castSucc μ))).card + (ε (Fin.last n)).val := by
  unfold CheckFermi.finsetOfWord
  rw [Finset.card_filter, Finset.card_filter, Fin.sum_univ_castSucc, ite_eq_one_eq_val]

/-- 準備の `0 ≤ |ε|_k ≤ k`（数え上げの定義）。 -/
theorem card_finsetOfWord_le {n : ℕ} (ε : Fin n → Fin 2) : (CheckFermi.finsetOfWord ε).card ≤ n :=
  (Finset.card_filter_le _ _).trans (by rw [Finset.card_univ, Fintype.card_fin])

/-- **原文 Step 2**: `(Π_{μ=1}^{k} ǔ^{(ε_μ)})_ℂ = (−1_ℂ)^{k−|ε|_k}` の `k` の帰納法（人手の `k` は Lean の `n + 1`）。
`k = 1` の `ε_1 = 1` の 5 行・`ε_1 = 0` の 7 行、`k → k+1` の `ε_{k+1} = 1`・`ε_{k+1} = 0` の 6 行ずつを同じ行の calc で置く。
人手の有限積（`def_finite_product_of_real_numbers`）は Lean の `∏ μ, …`（`Finset.prod`）で、定義の 2 つの式は
`Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む（`finite_product_of_positive_reals_is_positive` と同じ）。
`def_power_of_complex_number` の `z^0 := 1_ℂ`・`z^{m+1} := z^m z` は mathlib の `pow_zero`・`pow_succ` である。 -/
theorem checkU_prod_eq_neg_one_pow :
    ∀ (n : ℕ) (ε : Fin (n + 1) → Fin 2),
      ((∏ μ, checkU (ε μ) : ℝ) : ℂ) = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord ε).card)
  | 0, ε => by
    rcases binaryWord_fin_two_eq_one_or_zero (ε 0) with he | he
    · -- `ε_1 = 1` なら `|ε|_1 = 1`
      have hc : (CheckFermi.finsetOfWord ε).card = 1 := by rw [card_finsetOfWord_one, he]; rfl
      calc ((∏ μ, checkU (ε μ) : ℝ) : ℂ)
          = ((checkU (ε 0) : ℝ) : ℂ) := by rw [Fin.prod_univ_one]
                                                        -- `def_finite_product_of_real_numbers`
        _ = ((checkU 1 : ℝ) : ℂ) := by rw [he]          -- `ε_1 = 1`
        _ = 1 := by rw [checkU_one, Complex.ofReal_one] -- `ǔ^{(1)} := 1` と `inclusion_rr_to_cc` の略記
        _ = (-1 : ℂ) ^ 0 := (pow_zero _).symm           -- `def_power_of_complex_number` の `z^0 := 1_ℂ` を右辺から左辺へ
        _ = (-1 : ℂ) ^ ((0 + 1) - (CheckFermi.finsetOfWord ε).card) := by rw [hc]
                                                        -- `|ε|_1 = 1`
    · -- `ε_1 = 0` なら `|ε|_1 = 0`
      have hc : (CheckFermi.finsetOfWord ε).card = 0 := by rw [card_finsetOfWord_one, he]; rfl
      calc ((∏ μ, checkU (ε μ) : ℝ) : ℂ)
          = ((checkU (ε 0) : ℝ) : ℂ) := by rw [Fin.prod_univ_one]
                                                        -- `def_finite_product_of_real_numbers`
        _ = ((checkU 0 : ℝ) : ℂ) := by rw [he]          -- `ε_1 = 0`
        _ = -1 := by rw [checkU_zero, Complex.ofReal_neg, Complex.ofReal_one]
                                                        -- `ǔ^{(0)} := −1` と `inclusion_rr_to_cc` の略記
        _ = 1 * (-1 : ℂ) := (one_mul _).symm            -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）
        _ = (-1 : ℂ) ^ 0 * (-1 : ℂ) := by rw [pow_zero] -- `def_power_of_complex_number` の `z^0 := 1_ℂ` を右辺から左辺へ
        _ = (-1 : ℂ) ^ 1 := (pow_succ _ 0).symm         -- `def_power_of_complex_number` の `z^{m+1} := z^m z`（`m → 0`）を右辺から左辺へ
        _ = (-1 : ℂ) ^ ((0 + 1) - (CheckFermi.finsetOfWord ε).card) := by rw [hc]
                                                        -- `|ε|_1 = 0`
  | n + 1, ε => by
    have ih := checkU_prod_eq_neg_one_pow n (fun μ => ε (Fin.castSucc μ))
                                                        -- 帰納法の仮定（先頭の `k` 成分の語に当てる）
    have hcount := card_finsetOfWord_castSucc ε         -- `|ε|_{k+1} = |ε|_k + ε_{k+1}`
    have hle := card_finsetOfWord_le (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))
                                                        -- `|ε|_k ≤ k`
    rcases binaryWord_fin_two_eq_one_or_zero (ε (Fin.last (n + 1))) with he | he
    · -- `ε_{k+1} = 1` なら `(k+1) − |ε|_{k+1} = k − |ε|_k`
      have hk : (n + 1 + 1) - (CheckFermi.finsetOfWord ε).card
          = (n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card := by
        rw [hcount, he]; simp only [Fin.val_one]; omega
      calc ((∏ μ, checkU (ε μ) : ℝ) : ℂ)
          = (((∏ μ : Fin (n + 1), checkU (ε (Fin.castSucc μ))) * checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) := by
            rw [Fin.prod_univ_castSucc]                 -- `def_finite_product_of_real_numbers`
        _ = ((∏ μ : Fin (n + 1), checkU (ε (Fin.castSucc μ)) : ℝ) : ℂ) * ((checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) :=
            (real_inclusion_mul _ _).symm               -- `real_inclusion_preserves_product` を右辺から左辺へ
        _ = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card)
              * ((checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) := by rw [ih]
                                                        -- 帰納法の仮定
        _ = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card)
              * 1 := by rw [he, checkU_one, Complex.ofReal_one]
                                                        -- `ε_{k+1} = 1`、`ǔ^{(1)} := 1` と `inclusion_rr_to_cc` の略記
        _ = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card) :=
            mul_one _                                   -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）
        _ = (-1 : ℂ) ^ ((n + 1 + 1) - (CheckFermi.finsetOfWord ε).card) := by rw [hk]
                                                        -- `(k+1) − |ε|_{k+1} = k − |ε|_k`
    · -- `ε_{k+1} = 0` なら `(k+1) − |ε|_{k+1} = (k − |ε|_k) + 1`
      have hk : (n + 1 + 1) - (CheckFermi.finsetOfWord ε).card
          = ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card) + 1 := by
        rw [hcount, he]; simp only [Fin.val_zero, add_zero]; omega
      calc ((∏ μ, checkU (ε μ) : ℝ) : ℂ)
          = (((∏ μ : Fin (n + 1), checkU (ε (Fin.castSucc μ))) * checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) := by
            rw [Fin.prod_univ_castSucc]                 -- `def_finite_product_of_real_numbers`
        _ = ((∏ μ : Fin (n + 1), checkU (ε (Fin.castSucc μ)) : ℝ) : ℂ) * ((checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) :=
            (real_inclusion_mul _ _).symm               -- `real_inclusion_preserves_product` を右辺から左辺へ
        _ = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card)
              * ((checkU (ε (Fin.last (n + 1))) : ℝ) : ℂ) := by rw [ih]
                                                        -- 帰納法の仮定
        _ = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card)
              * (-1 : ℂ) := by rw [he, checkU_zero, Complex.ofReal_neg, Complex.ofReal_one]
                                                        -- `ε_{k+1} = 0`、`ǔ^{(0)} := −1` と `inclusion_rr_to_cc` の略記
        _ = (-1 : ℂ) ^ (((n + 1) - (CheckFermi.finsetOfWord (fun μ : Fin (n + 1) => ε (Fin.castSucc μ))).card) + 1) :=
            (pow_succ _ _).symm                         -- `def_power_of_complex_number` の `z^{m+1} := z^m z`
                                                        -- （`m → k − |ε|_k`）を右辺から左辺へ
        _ = (-1 : ℂ) ^ ((n + 1 + 1) - (CheckFermi.finsetOfWord ε).card) := by rw [hk]
                                                        -- `(k+1) − |ε|_{k+1} = (k − |ε|_k) + 1`

/-- `checkU_prod_eq_neg_one_pow` を必要十分版 `NecSuf.map_prod_two_valued_eq_pow'`（`f → (·)_ℂ`、`u → ǔ`、`s → −1_ℂ`）の
特殊化として。`Finset.prod` と左から掛ける有限積の一致は `real_finset_prod_eq_finProdLeft`、`|ε|` は `wordCount'` と同じ数である。 -/
theorem checkU_prod_eq_neg_one_pow_of_necSuf (n : ℕ) (ε : Fin (n + 1) → Fin 2) :
    ((∏ μ, checkU (ε μ) : ℝ) : ℂ) = (-1 : ℂ) ^ ((n + 1) - (CheckFermi.finsetOfWord ε).card) := by
  rw [real_finset_prod_eq_finProdLeft n (fun μ => checkU (ε μ))]
  exact NecSuf.map_prod_two_valued_eq_pow' (fun a : ℝ => (a : ℂ)) (fun a b => (real_inclusion_mul a b).symm)
    checkU (-1 : ℂ) (by rw [checkU_one, Complex.ofReal_one])
    (by rw [checkU_zero, Complex.ofReal_neg, Complex.ofReal_one]) n ε

/-! ## Step 3: 各項を実数の包含で表す -/

namespace CheckFermi

/-- 準備の `ȟ ∈ {1,−1} ⊂ ℝ`。`η_{(1,…,1)} ∈ {1_ℂ, −1_ℂ}` なので、`ȟ_ℂ = η_{(1,…,1)}` となるように取る
（`η_{(1,…,1)} = 1_ℂ` なら `1`、そうでなければ `−1`。取り方を満たすことは `checkH_ofReal`）。 -/
noncomputable def checkH (F : CheckFermi M) : ℝ := if F.eta Finset.univ = 1 then 1 else -1

/-- 準備の `ȟ ∈ {1,−1}`。 -/
theorem checkH_mem (F : CheckFermi M) : F.checkH = 1 ∨ F.checkH = -1 := by
  unfold checkH
  by_cases h : F.eta Finset.univ = 1
  · exact Or.inl (if_pos h)
  · exact Or.inr (if_neg h)

/-- 準備の `ȟ` の取り方 `ȟ_ℂ = η_{(1,…,1)}`（`η_{(1,…,1)} ∈ {1_ℂ, −1_ℂ}` は `epsilon_eigenvalue_on_check_Q` (1)、
`±1_ℂ` は `inclusion_rr_to_cc` の略記）。 -/
theorem checkH_ofReal (F : CheckFermi M) : ((F.checkH : ℝ) : ℂ) = F.eta Finset.univ := by
  unfold checkH
  rcases F.eta_mem Finset.univ with h | h
  · rw [if_pos h, Complex.ofReal_one, h]
  · have hne : F.eta Finset.univ ≠ 1 := by rw [h]; norm_num
    rw [if_neg hne, Complex.ofReal_neg, Complex.ofReal_one, h]

end CheckFermi

namespace VPlusData

/-- Step 3 の `ť_ε := (Π_{μ=1}^{M_col} ǔ^{(ε_μ)}) Λ̌_ε ∈ ℝ`（人手の `M_col` が Lean の `r + 1`）。 -/
noncomputable def checkT {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) (ε : Fin (r + 1) → Fin 2) : ℝ :=
  (∏ μ, checkU (ε μ)) * checkLambda D.C D.gam (CheckFermi.finsetOfWord ε)

/-- **原文 Step 3** の 7 行の鎖:
`η_ε(Λ̌_ε)_ℂ = (η_{(1,…,1)}(−1_ℂ)^{M_col−|ε|})(Λ̌_ε)_ℂ = (η_{(1,…,1)}(Π_μǔ^{(ε_μ)})_ℂ)(Λ̌_ε)_ℂ
= (ȟ_ℂ(Π_μǔ^{(ε_μ)})_ℂ)(Λ̌_ε)_ℂ = (ȟΠ_μǔ^{(ε_μ)})_ℂ(Λ̌_ε)_ℂ = ((ȟΠ_μǔ^{(ε_μ)})Λ̌_ε)_ℂ
= (((Π_μǔ^{(ε_μ)})Λ̌_ε)ȟ)_ℂ = (ť_εȟ)_ℂ`
（人手の `M_col` が Lean の `r + 1`、`η_ε` が `F.eta (CheckFermi.finsetOfWord ε)`、`|ε|` が `(CheckFermi.finsetOfWord ε).card`）。 -/
theorem eta_mul_checkLambda_eq_checkT_mul_checkH {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F)
    (ε : Fin (r + 1) → Fin 2) :
    F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)
      = ((D.checkT ε * F.checkH : ℝ) : ℂ) :=
  calc F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)
      = (F.eta Finset.univ * (-1 : ℂ) ^ ((r + 1) - (CheckFermi.finsetOfWord ε).card))
          * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) := by
        rw [F.eta_eq_eta_univ_mul]                      -- `epsilon_eigenvalue_on_check_Q` (3)
    _ = (F.eta Finset.univ * ((∏ μ, checkU (ε μ) : ℝ) : ℂ))
          * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) := by
        rw [checkU_prod_eq_neg_one_pow r ε]             -- Step 2 の `k = M_col` の式を右辺から左辺へ
    _ = (((F.checkH : ℝ) : ℂ) * ((∏ μ, checkU (ε μ) : ℝ) : ℂ))
          * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) := by
        rw [F.checkH_ofReal]                            -- `ȟ` の取り方 `ȟ_ℂ = η_{(1,…,1)}` を右辺から左辺へ
    _ = ((F.checkH * ∏ μ, checkU (ε μ) : ℝ) : ℂ)
          * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) := by
        rw [real_inclusion_mul]                         -- `real_inclusion_preserves_product`（`a → ȟ`、`b → Π_μǔ^{(ε_μ)}`）
    _ = (((F.checkH * ∏ μ, checkU (ε μ)) * checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ) :=
        real_inclusion_mul _ _                          -- `real_inclusion_preserves_product`（`a → ȟΠ_μǔ^{(ε_μ)}`、`b → Λ̌_ε`）
    _ = ((((∏ μ, checkU (ε μ)) * checkLambda D.C D.gam (CheckFermi.finsetOfWord ε)) * F.checkH : ℝ) : ℂ) := by
        rw [mul_assoc, mul_comm]                        -- ℝ で `(ab)c = (bc)a`（乗法の交換則と結合則）
    _ = ((D.checkT ε * F.checkH : ℝ) : ℂ) := rfl        -- `ť_ε` の置き方

/-- `eta_mul_checkLambda_eq_checkT_mul_checkH` を必要十分版 `NecSuf.signed_term_eq_map_mul'`
（`f → (·)_ℂ`、`h → ȟ`、`u → Π_μǔ^{(ε_μ)}`、`l → Λ̌_ε`）の特殊化として。 -/
theorem eta_mul_checkLambda_eq_checkT_mul_checkH_of_necSuf {r : ℕ} {F : CheckFermi (r + 1)}
    (D : VPlusData (r + 1) F) (ε : Fin (r + 1) → Fin 2) :
    F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)
      = ((D.checkT ε * F.checkH : ℝ) : ℂ) :=
  NecSuf.signed_term_eq_map_mul' (fun a : ℝ => (a : ℂ)) real_inclusion_mul
    (F.eta_eq_eta_univ_mul _) (checkU_prod_eq_neg_one_pow r ε) F.checkH_ofReal

end VPlusData

/-! ## Step 4: 実数の和を積へ分解する -/

namespace VPlusData

/-- Step 4 の `w̌_μ^{(e)} := ǔ^{(e)} exp(γ(θ̃_μ)(e − 1/2)) ∈ ℝ`（`μ ∈ 𝓜̌`、`e ∈ {0,1}`。人手の `e` を ℝ の元として使う箇所が
Lean の `((e : ℕ) : ℝ)`）。 -/
noncomputable def checkW {F : CheckFermi M} (D : VPlusData M F) (μ : Fin M) (e : Fin 2) : ℝ :=
  checkU e * Real.exp (D.gam μ * (((e : ℕ) : ℝ) - 1 / 2))

/-- `eigenvalues_of_V_plus` の `Λ̌_ε` の定義 `Λ̌_ε = (2 sinh 2K_2)^{M_col/2} exp(Σ_μ γ(θ̃_μ)(ε_μ − 1/2))` を、語 `ε` の成分
`ε_μ ∈ {0,1}` を ℝ の元として読む形で書く（Lean の `checkLambda` は部分集合 `finsetOfWord ε` の所属で `ε_μ` を読むので、
その読み替え。運ぶ段で、人手の行は無い）。 -/
theorem checkLambda_finsetOfWord (C : ℝ) (gam : Fin M → ℝ) (ε : Fin M → Fin 2) :
    checkLambda C gam (CheckFermi.finsetOfWord ε)
      = C * Real.exp (∑ μ, gam μ * (((ε μ : ℕ) : ℝ) - 1 / 2)) := by
  unfold checkLambda
  congr 2
  refine Finset.sum_congr rfl fun μ _ => ?_
  congr 2
  simp only [CheckFermi.finsetOfWord, Finset.mem_filter, Finset.mem_univ, true_and]
  exact ite_eq_one_eq_val_real (ε μ)

/-- **原文 Step 4** の 1 本目の 7 行の鎖:
`ť_ε = (Π_μǔ^{(ε_μ)})Λ̌_ε = (Π_μǔ^{(ε_μ)})((2sinh 2K_2)^{M_col/2}exp(Σ_μγ(θ̃_μ)(ε_μ−1/2)))
= (Π_μǔ^{(ε_μ)})((2sinh 2K_2)^{M_col/2}Π_μexp(γ(θ̃_μ)(ε_μ−1/2)))
= (2sinh 2K_2)^{M_col/2}((Π_μǔ^{(ε_μ)})Π_μexp(γ(θ̃_μ)(ε_μ−1/2)))
= (2sinh 2K_2)^{M_col/2}Π_μ(ǔ^{(ε_μ)}exp(γ(θ̃_μ)(ε_μ−1/2))) = (2sinh 2K_2)^{M_col/2}Π_μw̌_μ^{(ε_μ)}
= (Π_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2}`
（人手の `M_col` が Lean の `r + 1`、`(2 sinh 2K_2)^{M_col/2}` が `D.C`、`γ(θ̃_μ)` が `D.gam μ`）。 -/
theorem checkT_eq_prod_checkW_mul {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F)
    (ε : Fin (r + 1) → Fin 2) :
    D.checkT ε = (∏ μ, D.checkW μ (ε μ)) * D.C :=
  calc D.checkT ε
      = (∏ μ, checkU (ε μ)) * checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) := rfl
                                                        -- `ť_ε` の置き方
    _ = (∏ μ, checkU (ε μ)) * (D.C * Real.exp (∑ μ, D.gam μ * (((ε μ : ℕ) : ℝ) - 1 / 2))) := by
        rw [checkLambda_finsetOfWord]                   -- `eigenvalues_of_V_plus` の `Λ̌_ε` の定義
    _ = (∏ μ, checkU (ε μ)) * (D.C * ∏ μ, Real.exp (D.gam μ * (((ε μ : ℕ) : ℝ) - 1 / 2))) := by
        rw [real_exp_of_finite_sum r]                   -- `real_exp_of_finite_sum`（`m → M_col`、`j → μ`、`x_j → γ(θ̃_μ)(ε_μ − 1/2)`）
    _ = D.C * ((∏ μ, checkU (ε μ)) * ∏ μ, Real.exp (D.gam μ * (((ε μ : ℕ) : ℝ) - 1 / 2))) :=
        mul_left_comm _ _ _                             -- ℝ で `a(bc) = b(ac)`（乗法の交換則と結合則）
    _ = D.C * ∏ μ, (checkU (ε μ) * Real.exp (D.gam μ * (((ε μ : ℕ) : ℝ) - 1 / 2))) := by
        rw [finite_product_of_real_products r]          -- `finite_product_of_real_products`（`m → M_col`、`j → μ`、`x_j → ǔ^{(ε_μ)}`、
                                                        -- `y_j → exp(γ(θ̃_μ)(ε_μ − 1/2))`）を右辺から左辺へ
    _ = D.C * ∏ μ, D.checkW μ (ε μ) := rfl              -- `w̌_μ^{(e)}` の置き方（`e → ε_μ`）を各因子へ同時に
    _ = (∏ μ, D.checkW μ (ε μ)) * D.C := mul_comm _ _   -- ℝ の乗法の交換則

/-- 主張の `ϰ := (2 sinh 2K_2)^{M_col/2} Π_{μ=1}^{M_col} 2 sinh(γ(θ̃_μ)/2) ∈ ℝ`（`(2 sinh 2K_2)^{M_col/2}` が `D.C`、
`γ(θ̃_μ)` が `D.gam μ`）。 -/
noncomputable def traceFactor {F : CheckFermi M} (D : VPlusData M F) : ℝ := D.C * ∏ μ : Fin M, (2 * Real.sinh (D.gam μ / 2))

/-- **原文 Step 4** の 2 本目の和の鎖:
`Σ_εť_ε = Σ_ε(Π_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2} = (Σ_εΠ_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2}
= (Π_μ(w̌_μ^{(1)} + w̌_μ^{(0)}))(2sinh 2K_2)^{M_col/2}
= (Π_μ(ǔ^{(1)}exp(γ(θ̃_μ)(1−1/2)) + ǔ^{(0)}exp(γ(θ̃_μ)(0−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(1·exp(γ(θ̃_μ)(1−1/2)) + (−1)exp(γ(θ̃_μ)(0−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)(1−1/2)) + (−1)exp(γ(θ̃_μ)(0−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)(1−1/2)) − exp(γ(θ̃_μ)(0−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)·1/2) − exp(γ(θ̃_μ)(0−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)·1/2) − exp(γ(θ̃_μ)(−1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)·1/2) − exp(−(γ(θ̃_μ)·1/2))))(2sinh 2K_2)^{M_col/2}
= (Π_μ(exp(γ(θ̃_μ)/2) − exp(−γ(θ̃_μ)/2)))(2sinh 2K_2)^{M_col/2}
= (Π_μ2·((exp(γ(θ̃_μ)/2) − exp(−γ(θ̃_μ)/2))/2))(2sinh 2K_2)^{M_col/2}
= (Π_μ2sinh(γ(θ̃_μ)/2))(2sinh 2K_2)^{M_col/2} = (2sinh 2K_2)^{M_col/2}Π_μ2sinh(γ(θ̃_μ)/2) = ϰ`
（人手の `M_col` が Lean の `r + 1`、人手の和 `Σ_{ε∈{0,1}^𝓜̌}`（`def_sum_over_binary_words_of_real_numbers`）が `binaryWordRealSum r`、
`(2 sinh 2K_2)^{M_col/2}` が `D.C`、`γ(θ̃_μ)` が `D.gam μ`、`ϰ` が `D.traceFactor`）。
4 行目の後の 1 段は、`w̌_μ^{(e)}` の `e ∈ {0,1}` を ℝ の元として使う書き方 `(((e : Fin 2) : ℕ) : ℝ)` を ℝ の `1`・`0` へ付け替える
運ぶ段で、人手の行は無い（`prod_step2_cosh` の 1 段目と同じ）。必要十分版は置かない（効くのは、引いた
`real_sum_over_binary_words_distributes_in_left_factor`・`expansion_of_finite_product_of_two_term_sums_of_real_numbers`
（それぞれ必要十分版あり）と、ℝ の計算規則と `def_cosh_sinh` の `sinh` の式だけで、`ClaimTraceCheckVprime.lean` の
`prod_step2_cosh` と同じく取り払える構造が無い）。 -/
theorem sum_checkT_eq_traceFactor {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) :
    binaryWordRealSum r (fun ε => D.checkT ε) = D.traceFactor :=
  calc binaryWordRealSum r (fun ε => D.checkT ε)
      = binaryWordRealSum r (fun ε => (∏ μ, D.checkW μ (ε μ)) * D.C) := by
        congr 1; funext ε; exact D.checkT_eq_prod_checkW_mul ε
                                                        -- 直前の鎖（`checkT_eq_prod_checkW_mul`）を各項へ同時に
    _ = binaryWordRealSum r (fun ε => ∏ μ, D.checkW μ (ε μ)) * D.C :=
        (binaryWordRealSum_mul r _ _).symm              -- `real_sum_over_binary_words_distributes_in_left_factor`
                                                        -- （`r → M_col`、`x_ε → Π_μw̌_μ^{(ε_μ)}`、`c → (2sinh 2K_2)^{M_col/2}`）を右辺から左辺へ
    _ = (∏ μ, (D.checkW μ 1 + D.checkW μ 0)) * D.C := by
        rw [expansion_of_finite_product_of_two_term_sums_of_real r (fun μ e => D.checkW μ e)]
                                                        -- `expansion_of_finite_product_of_two_term_sums_of_real_numbers`
                                                        -- （`r → M_col`、`j → μ`、`a_j^{(e)} → w̌_μ^{(e)}`）を右辺から左辺へ
    _ = (∏ μ, (checkU 1 * Real.exp (D.gam μ * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
          + checkU 0 * Real.exp (D.gam μ * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2)))) * D.C := rfl
                                                        -- `w̌_μ^{(e)}` の置き方（`e → 1`、`e → 0`）を各因子へ同時に
    _ = (∏ μ, (checkU 1 * Real.exp (D.gam μ * ((1 : ℝ) - 1 / 2))
          + checkU 0 * Real.exp (D.gam μ * ((0 : ℝ) - 1 / 2)))) * D.C := by
        rw [Fin.val_one, Fin.val_zero, Nat.cast_one, Nat.cast_zero]
                                                        -- `e ∈ {0,1}` を ℝ の `1`・`0` へ付け替える（運ぶ段。人手の行は無い）
    _ = (∏ μ, (1 * Real.exp (D.gam μ * ((1 : ℝ) - 1 / 2))
          + (-1) * Real.exp (D.gam μ * ((0 : ℝ) - 1 / 2)))) * D.C := by
        rw [checkU_one, checkU_zero]                    -- `ǔ^{(1)} := 1`、`ǔ^{(0)} := −1` を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ * ((1 : ℝ) - 1 / 2))
          + (-1) * Real.exp (D.gam μ * ((0 : ℝ) - 1 / 2)))) * D.C := by
        simp only [one_mul]                             -- ℝ で `1·b = b` を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ * ((1 : ℝ) - 1 / 2))
          - Real.exp (D.gam μ * ((0 : ℝ) - 1 / 2)))) * D.C := by
        simp only [neg_one_mul, ← sub_eq_add_neg]       -- ℝ で `a + (−1)b = a − b` を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ * (1 / 2))
          - Real.exp (D.gam μ * ((0 : ℝ) - 1 / 2)))) * D.C := by
        rw [sub_half (1 : ℝ)]                           -- ℝ で `1 − 1/2 = 1/2` を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ * (1 / 2))
          - Real.exp (D.gam μ * (-(1 / 2))))) * D.C := by
        rw [zero_sub (1 / 2 : ℝ)]                       -- ℝ で `0 − a = −a`（`a → 1/2`）を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ * (1 / 2))
          - Real.exp (-(D.gam μ * (1 / 2))))) * D.C := by
        congr 1; refine Finset.prod_congr rfl fun μ _ => ?_
        rw [mul_neg (D.gam μ) (1 / 2)]                  -- ℝ で `a(−b) = −(ab)`（`a → γ(θ̃_μ)`、`b → 1/2`）を各因子へ同時に
    _ = (∏ μ, (Real.exp (D.gam μ / 2) - Real.exp (-(D.gam μ / 2)))) * D.C := by
        congr 1; refine Finset.prod_congr rfl fun μ _ => ?_
        rw [mul_one_div (D.gam μ) 2]                    -- ℝ で `a·(1/2) = a/2`（`a → γ(θ̃_μ)`）を各因子の 2 箇所へ同時に
    _ = (∏ μ, 2 * ((Real.exp (D.gam μ / 2) - Real.exp (-(D.gam μ / 2))) / 2)) * D.C := by
        congr 1; refine Finset.prod_congr rfl fun μ _ => ?_
        rw [mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- ℝ で `2 ≠ 0` なので `b = 2·(b/2)` を各因子へ同時に
    _ = (∏ μ, 2 * Real.sinh (D.gam μ / 2)) * D.C := by
        congr 1; refine Finset.prod_congr rfl fun μ _ => ?_
        rw [← Real.sinh_eq]                             -- `def_cosh_sinh` の `sinh`（`x → γ(θ̃_μ)/2`）を各因子へ同時に、右辺から左辺へ
                                                        -- （`def_cosh_sinh` は Lean で定義し直していない。mathlib の `Real.sinh` の
                                                        -- 等式 `Real.sinh_eq` が、人手の定義の式そのものとしてその役を担う）
    _ = D.C * ∏ μ, (2 * Real.sinh (D.gam μ / 2)) := mul_comm _ _
                                                        -- ℝ の乗法の交換則
    _ = D.traceFactor := rfl                            -- `ϰ` の置き方

/-! ## Step 5: (1) の等式 -/

/-- **原文 Step 5** の 8 行の鎖（(1) の等式）:
`tr(εV^{(+)}) = Σ_εη_ε(Λ̌_ε)_ℂ = Σ_ε(ť_εȟ)_ℂ = (Σ_εť_εȟ)_ℂ = ((Σ_εť_ε)ȟ)_ℂ = (ϰȟ)_ℂ = (ȟϰ)_ℂ = ȟ_ℂϰ_ℂ = η_{(1,…,1)}ϰ_ℂ`
（人手の `M_col` が Lean の `r + 1`、`ϰ` が `D.traceFactor`、`ȟ` が `F.checkH`。人手の複素数の和
`Σ_{ε∈{0,1}^𝓜̌}`（`def_sum_over_binary_words_of_complex_numbers`）は、Step 1 の鎖の右辺では `NecSuf.binWordSum r`、
付け替えの段の右辺では具体版 `binaryWordComplexSum r` で、2 行目の後の 1 段はその付け替え（`binaryWordComplexSum_eq_binWordSum`。
運ぶ段で、人手の行は無い）。実数の和は `binaryWordRealSum r`）。必要十分版は置かない（効くのは、引いた
Step 1・Step 3・Step 4 の鎖、`real_inclusion_preserves_sum_over_binary_words`・
`real_sum_over_binary_words_distributes_in_left_factor`・`real_inclusion_preserves_product` と ℝ の乗法の交換則だけで、
この鎖はそれらをつなぐだけなので、この鎖に固有の取り払える構造が無い）。 -/
theorem trace_epsilon_mul_V_step5 {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) :
    (epsilon (r + 1) * D.V).trace = F.eta Finset.univ * ((D.traceFactor : ℝ) : ℂ) :=
  calc (epsilon (r + 1) * D.V).trace
      = NecSuf.binWordSum r (fun ε =>
          F.eta (CheckFermi.finsetOfWord ε) * ((checkLambda D.C D.gam (CheckFermi.finsetOfWord ε) : ℝ) : ℂ)) :=
        trace_epsilon_mul_V_step1 D                     -- Step 1 の鎖
    _ = NecSuf.binWordSum r (fun ε => ((D.checkT ε * F.checkH : ℝ) : ℂ)) := by
        congr 1; funext ε; exact D.eta_mul_checkLambda_eq_checkT_mul_checkH ε
                                                        -- Step 3 の鎖を各項へ同時に
    _ = binaryWordComplexSum r (fun ε => ((D.checkT ε * F.checkH : ℝ) : ℂ)) :=
        (binaryWordComplexSum_eq_binWordSum r _).symm   -- 複素数の和を具体版 `binaryWordComplexSum` へ付け替える（運ぶ段。人手の行は無い）
    _ = ((binaryWordRealSum r (fun ε => D.checkT ε * F.checkH) : ℝ) : ℂ) :=
        binaryWordComplexSum_ofReal r _                 -- `real_inclusion_preserves_sum_over_binary_words`（`r → M_col`、`x_ε → ť_εȟ`）
    _ = ((binaryWordRealSum r (fun ε => D.checkT ε) * F.checkH : ℝ) : ℂ) := by
        rw [binaryWordRealSum_mul r]                    -- `real_sum_over_binary_words_distributes_in_left_factor`
                                                        -- （`r → M_col`、`x_ε → ť_ε`、`c → ȟ`）を右辺から左辺へ
    _ = ((D.traceFactor * F.checkH : ℝ) : ℂ) := by
        rw [D.sum_checkT_eq_traceFactor]                -- Step 4 の鎖
    _ = ((F.checkH * D.traceFactor : ℝ) : ℂ) := by
        rw [mul_comm]                                   -- ℝ の乗法の交換則
    _ = ((F.checkH : ℝ) : ℂ) * ((D.traceFactor : ℝ) : ℂ) :=
        (real_inclusion_mul _ _).symm                   -- `real_inclusion_preserves_product`（`a → ȟ`、`b → ϰ`）を右辺から左辺へ
    _ = F.eta Finset.univ * ((D.traceFactor : ℝ) : ℂ) := by
        rw [F.checkH_ofReal]                            -- `ȟ` の取り方 `ȟ_ℂ = η_{(1,…,1)}`

end VPlusData

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- **人手 `trace_of_epsilon_V_plus_via_check_eigenvalues` (1)**:
`tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ`（`M` を一般に取る形）。`M = r + 1` は Step 5 の鎖 `trace_epsilon_mul_V_step5` である。
人手の範囲外の `M = 0`（和が `T = ∅` の 1 項だけ）は `trace_epsilon_mul_V_eq_sum` を mathlib の `simp` で閉じる。 -/
theorem trace_epsilon_mul_V :
    (epsilon M * D.V).trace = F.eta Finset.univ * ((D.traceFactor : ℝ) : ℂ) := by
  match M, F, D with
  | 0, F, D =>
    rw [D.trace_epsilon_mul_V_eq_sum]
    simp [traceFactor, checkLambda, Finset.univ_eq_empty]
    exact Or.inl (congrArg F.eta (Subsingleton.elim _ _))
  | r + 1, F, D => exact trace_epsilon_mul_V_step5 D

/-! ## Step 6: (2) の不等号 -/

/-- **原文 Step 6** の 1 本目の鎖: `γ(θ̃_μ)/2 = γ(θ̃_μ)·½ > 0·½ = 0`（`γ(θ̃_μ)` が `D.gam μ`。
`gamma_theta_tilde_mu_positive` の `γ(θ̃_μ) > 0` は `VPlusData` の入力 `D.hgam μ`）。 -/
theorem gam_half_pos (μ : Fin M) : D.gam μ / 2 > 0 :=
  calc D.gam μ / 2
      = D.gam μ * (1 / 2) := div_eq_mul_one_div _ _   -- ℝ で `a/2 = a·½`
    _ > 0 * (1 / 2) := mul_lt_mul_of_pos_right (D.hgam μ) one_half_pos
                                                        -- `γ(θ̃_μ) > 0` の両辺に `½ > 0` を掛ける
    _ = 0 := zero_mul _                                 -- `0·½ = 0`

/-- **原文 Step 6** の 2 本目の鎖: `2sinh(γ(θ̃_μ)/2) > 2·0 = 0`。 -/
theorem two_sinh_gam_half_pos (μ : Fin M) : 2 * Real.sinh (D.gam μ / 2) > 0 :=
  calc 2 * Real.sinh (D.gam μ / 2)
      > 2 * 0 := mul_lt_mul_of_pos_left (cosh_sinh_basic_properties_3 (D.gam_half_pos μ)).2 two_pos
                                                        -- `cosh_sinh_basic_properties` (3) の `sinh x > 0`（`x → γ(θ̃_μ)/2`）に
                                                        -- 上の鎖を当て、両辺に `2 > 0` を掛ける
    _ = 0 := mul_zero _                                 -- `2·0 = 0`

end VPlusData

namespace VPlusData

/-- **原文 Step 6** の 3 本目の鎖: `Π_{μ=1}^{M_col}2sinh(γ(θ̃_μ)/2) > 0`（人手の `M_col` が Lean の `r + 1`）。 -/
theorem prod_two_sinh_gam_half_pos {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) :
    ∏ μ, 2 * Real.sinh (D.gam μ / 2) > 0 :=
  finite_product_of_positive_reals_is_positive r (fun μ => 2 * Real.sinh (D.gam μ / 2))
    (fun μ => D.two_sinh_gam_half_pos μ)
                                                        -- `finite_product_of_positive_reals_is_positive`
                                                        -- （`m → M_col`、`j → μ`、`r_μ → 2sinh(γ(θ̃_μ)/2)`）に、上の各 `μ` の鎖を当てる

/-- **原文 Step 6** の 4 本目の鎖（(2) の不等号）:
`ϰ = (2sinh 2K_2)^{M_col/2}Π_{μ=1}^{M_col}2sinh(γ(θ̃_μ)/2) > 0`（人手の `M_col` が Lean の `r + 1`、
`(2sinh 2K_2)^{M_col/2}` が `D.C`。`def_second_transfer_matrix_prefactor` の `(2sinh 2K_2)^{M_col/2} ∈ ℝ_{>0}` は
`VPlusData` の入力 `D.hC`）。必要十分版は置かない（Step 6 の 4 本の鎖が効かせるのは、引いた
`cosh_sinh_basic_properties` (3)・`finite_product_of_positive_reals_is_positive`（それぞれ必要十分版あり）と、
ℝ の順序と乗法の計算規則（`a/2 = a·½`、正の数を不等号の両辺に掛ける、`0·a = 0`、`a·0 = 0`、正の数どうしの積は正）だけで、
鎖に固有の取り払える構造が無い）。 -/
theorem traceFactor_pos_step6 {r : ℕ} {F : CheckFermi (r + 1)} (D : VPlusData (r + 1) F) :
    D.traceFactor > 0 :=
  calc D.traceFactor
      = D.C * ∏ μ, 2 * Real.sinh (D.gam μ / 2) := rfl  -- `ϰ` の置き方
    _ > 0 := mul_pos D.hC D.prod_two_sinh_gam_half_pos
                                                        -- ℝ で `a > 0`、`b > 0` なら `ab > 0`（`a → (2sinh 2K_2)^{M_col/2}`、
                                                        -- `b → Π_μ2sinh(γ(θ̃_μ)/2)`）に、`D.hC` と直前の鎖を当てる

end VPlusData

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- **人手 `trace_of_epsilon_V_plus_via_check_eigenvalues` (2)**: `ϰ > 0`（`M` を一般に取る形）。
`M = r + 1` は Step 6 の鎖 `traceFactor_pos_step6` である。人手の範囲外の `M = 0`（積が空で `ϰ = C`）は
mathlib の `simp` で閉じる。 -/
theorem traceFactor_pos : 0 < D.traceFactor := by
  match M, F, D with
  | 0, F, D => simpa [traceFactor] using D.hC
  | r + 1, F, D => exact traceFactor_pos_step6 D

/-! ## Step 7（旧い Step の分け方のまま） -/

/-- **人手証明の最後の同値**: `η_{(1,…,1)} = +1 ⟺ tr(εV^{(+)}) > 0`（の一方向）。 -/
theorem eta_univ_eq_one_of_trace_pos (h : 0 < ((epsilon M * D.V).trace).re) :
    F.eta (Finset.univ : Finset (Fin M)) = 1 := by
  rcases F.eta_mem (Finset.univ : Finset (Fin M)) with hη | hη
  · exact hη
  · exfalso
    rw [D.trace_epsilon_mul_V, hη] at h
    simp only [neg_mul, one_mul, Complex.neg_re, Complex.ofReal_re] at h
    have := D.traceFactor_pos
    linarith

end VPlusData

end Ising2D
