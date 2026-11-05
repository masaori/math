/-
# `tr(ε V^{(+)})` を `η_{(1,…,1)}` で表す（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_003_claim_trace_epsilon_V_plus_via_eigenvalues`、
ラベル **`trace_of_epsilon_V_plus_via_check_eigenvalues`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）の
`Ising2D.NecSuf.sum_powerset_signed_exp`。本ファイルの Step 2 はその**系**である。

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
| Step 3〜7 | `VPlusData.trace_epsilon_mul_V`・`traceFactor_pos`・`eta_univ_eq_one_of_trace_pos`（旧い Step の分け方のまま。Step 2 の `checkU_prod_eq_neg_one_pow` はまだ使っていない。人手の新しい鎖と 1 対 1 にするのは状態台帳の次の一歩） |
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonEigenvalueOnCheckQ
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWords
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.NecSuf.PowerFromProductOfTwoValuedFactors
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf

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

/-- `tr(εV^{(+)}) = Σ_T η_T Λ̌_T`（和は部分集合の上の `Finset.sum`）。人手の主張の行ではなく、Step 2 以降の Lean の
証明（`trace_epsilon_mul_V`）が受け取る形である。`M = r + 1` は Step 1 の鎖 `trace_epsilon_mul_V_step1` を通し、
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

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-! ## Step 3 以降（旧い Step の分け方のまま）: 積への分解 -/

/-- 人手証明 Step 2 の右辺の実数因子 `(2 sinh 2K_2)^{M/2} ∏_μ 2 sinh(γ(θ̃_μ)/2)`。 -/
noncomputable def traceFactor : ℝ := D.C * ∏ μ : Fin M, (2 * Real.sinh (D.gam μ / 2))

/-- **人手証明 Step 3**: 右辺の `η` 以外の因子はすべて正。 -/
theorem traceFactor_pos : 0 < D.traceFactor := by
  unfold traceFactor
  refine mul_pos D.hC (Finset.prod_pos fun μ _ => ?_)
  have := D.hgam μ
  have hs : 0 < Real.sinh (D.gam μ / 2) := Real.sinh_pos_iff.2 (by linarith)
  linarith

/-- **人手証明 `trace_of_epsilon_V_plus_via_check_eigenvalues` そのもの**:

  `tr(εV^{(+)}) = η_{(1,…,1)} (2 sinh 2K_2)^{M/2} ∏_μ 2 sinh(γ(θ̃_μ)/2)`。 -/
theorem trace_epsilon_mul_V :
    (epsilon M * D.V).trace = F.eta Finset.univ * ((D.traceFactor : ℝ) : ℂ) := by
  rw [D.trace_epsilon_mul_V_eq_sum]
  have hreal : ∀ T : Finset (Fin M),
      F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ)
        = F.eta Finset.univ * (((-1 : ℝ) ^ (M - T.card)
            * checkLambda D.C D.gam T : ℝ) : ℂ) := by
    intro T
    rw [F.eta_eq_eta_univ_mul T]
    push_cast
    ring
  rw [Finset.sum_congr rfl (fun T _ => hreal T), ← Finset.mul_sum]
  congr 1
  rw [← Complex.ofReal_sum]
  congr 1
  -- 実数の等式に落とす
  have hcard : (Finset.univ : Finset (Fin M)).card = M := by simp
  have hkey := NecSuf.sum_powerset_signed_exp (Finset.univ : Finset (Fin M)) D.gam
  rw [Finset.powerset_univ, hcard] at hkey
  unfold traceFactor checkLambda
  rw [← hkey, Finset.mul_sum]
  exact Finset.sum_congr rfl fun T _ => by ring

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
