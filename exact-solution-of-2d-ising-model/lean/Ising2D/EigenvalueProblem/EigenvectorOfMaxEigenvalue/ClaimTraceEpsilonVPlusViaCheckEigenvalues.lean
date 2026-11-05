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
| Step 2〜7 | `VPlusData.trace_epsilon_mul_V`・`traceFactor_pos`・`eta_univ_eq_one_of_trace_pos`（旧い Step の分け方のまま。人手の新しい鎖と 1 対 1 にするのは状態台帳の次の一歩） |
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonEigenvalueOnCheckQ
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWords

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

/-! ## Step 2: 積への分解 -/

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
