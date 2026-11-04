/-
# `tr(V̌') = tr((V̌')^{-1}) > 0`（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`trace_of_check_Vprime`（`evenEigen_007_claim_...`）。

**必要十分版は置かない。** 使っている一般論はトレースの線型性（既に
`Ising2D/NecSuf/NumberOperator.lean` の「加法的かつ巡回的な汎関数 `τ`」として
抽象化してある）と、実数の指数法則・`cosh` の偶関数性だけで、
取り払える構造が残っていない。

## 原文 Step 1 との対応

人手の `M_col` が Lean の `r + 1`、人手の和 `Σ_{ε∈{0,1}^𝓜̌}` が `NecSuf.binWordSum r`（行列の和は `def_sum_over_binary_words`、
複素数の和は `def_sum_over_binary_words_of_complex_numbers`。`TensorPow M` と `ℂ` の和はどちらも `NecSuf.binWordSum`）、
人手の `Q̌_ε` が `F.Qproj (finsetOfBinWord ε)` である。Step 1 の 8 行の鎖は `trace_Vprime_step1` の `calc` と 1 対 1 である。
4 行目の `trace_of_sum_over_binary_words` は、`TensorPow M` の系 `trace_binWordSum_tensorPow`（必要十分版 `NecSuf.binWordSum_map` の
特殊化。3 行目の `mul_binWordSum_tensorPow` と同じ作り）で受ける。人手の帰納法と 1 対 1 の `calc` は添字 `Fin n` の `trace_binaryWordMatrixSum` にある。
`trace_Vprime` は、`M = r + 1` では `trace_Vprime_step1` の ℂ の和を、Step 2 の 1 行目（`real_inclusion_preserves_sum_over_binary_words`。
`NecSuf.binWordSum` の系 `binWordSum_ofReal`）で ℝ の和（`def_sum_over_binary_words_of_real_numbers`）の包含へ移し、
その ℝ の和を Lean の `𝓜̌` の部分集合の上の `Finset.sum` へ付け替え（運ぶ段）、Step 2 の `sum_exp_gval` へつなぐ。人手の範囲外の `M = 0` は mathlib の `Matrix.trace_sum`・`Matrix.trace_smul` で閉じる。

## 章 009 との違い

章 009 の `trace_of_Vprime` は `tr(V') = 2^{M-m} ∏_μ 2cosh(γ_μ/2)` だった。
半整数運動量では `m = M` なので**前因子 `2^{M-m}` が消える**
（`tr(Q̌_ε) = 1` になったことの直接の帰結）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimEigenvaluesCheckVprime
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimCheckJointEigenspace
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.NecSuf.BinaryWordSumAsFinsetSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- `V̌'` を単元として取り出したもの（原文 `def_check_Vprime` (2) の可逆性）。 -/
noncomputable def VprimeUnits (g : CheckIdx M → ℝ) : (TensorPow M)ˣ := matExpUnits (F.Xop g)

@[simp]
theorem VprimeUnits_val (g : CheckIdx M → ℝ) :
    ((F.VprimeUnits g : (TensorPow M)ˣ) : TensorPow M) = F.Vprime g := rfl

/-- **原文 `trace_of_check_Vprime` の `(V̌')^{-1} = exp(-X̌)`**。 -/
theorem VprimeUnits_inv (g : CheckIdx M → ℝ) :
    (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = F.Vprime (fun i => -(g i)) := by
  rw [VprimeUnits, matExpUnits_inv, Vprime, F.Xop_neg g]

theorem Vprime_mul_Vprime_neg (g : CheckIdx M → ℝ) :
    F.Vprime g * F.Vprime (fun i => -(g i)) = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).mul_inv

theorem Vprime_neg_mul_Vprime (g : CheckIdx M → ℝ) :
    F.Vprime (fun i => -(g i)) * F.Vprime g = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).inv_mul

/-- 各因子の展開: `exp(ǧ(ε)) = ∏_μ (μ ∈ T ? e^{γ_μ/2} : e^{-γ_μ/2})`。 -/
theorem exp_gval_eq_prod (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    Real.exp (F.gval g T)
      = ∏ i : CheckIdx M, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))) := by
  rw [gval, Real.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  by_cases hT : i ∈ T <;> simp [hT] <;> ring_nf

/-- **原文 `trace_of_check_Vprime` Step 2**:
`∑_ε e^{ǧ(ε)} = ∏_μ 2 cosh(γ(θ~_μ)/2)`。 -/
theorem sum_exp_gval (g : CheckIdx M → ℝ) :
    ∑ T : Finset (CheckIdx M), Real.exp (F.gval g T)
      = ∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) := by
  classical
  have hprod : ∏ i : CheckIdx M, (Real.exp (g i / 2) + Real.exp (-(g i / 2)))
      = ∑ T ∈ (Finset.univ : Finset (CheckIdx M)).powerset,
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) :=
    Finset.prod_add _ _ _
  have hsplit : ∀ T : Finset (CheckIdx M),
      (∏ i : CheckIdx M, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))))
        = (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) := by
    intro T
    rw [Finset.prod_ite]
    congr 1
    · congr 1
      ext i
      simp
    · congr 1
      ext i
      simp [Finset.mem_sdiff]
  calc ∑ T : Finset (CheckIdx M), Real.exp (F.gval g T)
      = ∑ T : Finset (CheckIdx M),
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.exp_gval_eq_prod g T, hsplit T]
    _ = ∏ i : CheckIdx M, (Real.exp (g i / 2) + Real.exp (-(g i / 2))) := by
        rw [hprod, Finset.powerset_univ]
    _ = ∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) := by
        refine Finset.prod_congr rfl fun i _ => ?_
        rw [Real.cosh_eq]
        ring

/-- **原文 `trace_of_check_Vprime` Step 1** の 8 行の鎖:
`tr(V̌') = tr(V̌'I) = tr(V̌'Σ_εQ̌_ε) = tr(Σ_εV̌'Q̌_ε) = Σ_εtr(V̌'Q̌_ε) = Σ_εtr(e^{ǧ(ε)}Q̌_ε) = Σ_εe^{ǧ(ε)}tr(Q̌_ε)
= Σ_εe^{ǧ(ε)}1_ℂ = Σ_εe^{ǧ(ε)}`（人手の `M_col` が Lean の `r + 1`）。 -/
theorem trace_Vprime_step1 {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ) :
    (F.Vprime g).trace
      = NecSuf.binWordSum r (fun ε => ((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) :=
  calc (F.Vprime g).trace
      = (F.Vprime g * 1).trace := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`（`A → V̌'`）を右辺から左辺へ
    _ = (F.Vprime g * NecSuf.binWordSum r (fun ε => F.Qproj (finsetOfBinWord ε))).trace := by
        rw [sum_Qproj_step2 F]                          -- `check_joint_eigenspace_decomposition` (2) を右辺から左辺へ
    _ = (NecSuf.binWordSum r (fun ε => F.Vprime g * F.Qproj (finsetOfBinWord ε))).trace := by
        rw [mul_binWordSum_tensorPow]                   -- `sum_over_binary_words_distributes_in_right_factor`
                                                        -- （`C → V̌'`、`X_ε → Q̌_ε`）
    _ = NecSuf.binWordSum r (fun ε => (F.Vprime g * F.Qproj (finsetOfBinWord ε)).trace) :=
        trace_binWordSum_tensorPow r _                  -- `trace_of_sum_over_binary_words`（`B_ε → V̌'Q̌_ε`）
    _ = NecSuf.binWordSum r
          (fun ε => ((((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) • F.Qproj (finsetOfBinWord ε)).trace) := by
        congr 1; funext ε; rw [F.Vprime_mul_Qproj]      -- `eigenvalues_of_check_Vprime` を各項へ同時に
    _ = NecSuf.binWordSum r
          (fun ε => (((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) * (F.Qproj (finsetOfBinWord ε)).trace) := by
        congr 1; funext ε; exact trace_smul_tensorPow _ _
                                                        -- `trace_of_scalar_multiple`（`α → (e^{ǧ(ε)})_ℂ`、`A → Q̌_ε`）を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε => (((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) * 1) := by
        congr 1; funext ε; rw [F.trace_Qproj]           -- `check_joint_eigenspace_decomposition` (4) の `tr(Q̌_ε) = 1` を各項へ同時に
    _ = NecSuf.binWordSum r (fun ε => ((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) := by
        congr 1; funext ε; exact mul_one _              -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）を各項へ同時に

/-- 人手の範囲外の `M = 0` の `tr(V̌') = Σ_T e^{ǧ(T)}`（mathlib の `Matrix.trace_sum`・`Matrix.trace_smul` で閉じる）。 -/
theorem trace_Vprime_eq_finset_sum_of_mathlib (g : CheckIdx M → ℝ) :
    (F.Vprime g).trace = ((∑ T : Finset (CheckIdx M), Real.exp (F.gval g T) : ℝ) : ℂ) := by
  classical
  calc (F.Vprime g).trace
      = (∑ T : Finset (CheckIdx M), F.Vprime g * F.Qproj T).trace := by
        rw [← Finset.mul_sum, F.sum_Qproj, mul_one]
    _ = ∑ T : Finset (CheckIdx M), (F.Vprime g * F.Qproj T).trace := Matrix.trace_sum _ _
    _ = ∑ T : Finset (CheckIdx M), ((Real.exp (F.gval g T) : ℝ) : ℂ) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.Vprime_mul_Qproj g T, Matrix.trace_smul, F.trace_Qproj T, smul_eq_mul, mul_one]
    _ = ((∑ T : Finset (CheckIdx M), Real.exp (F.gval g T) : ℝ) : ℂ) := by push_cast; ring

/-- **原文 `trace_of_check_Vprime` Step 1〜2**:
`tr(V̌') = ∏_μ 2 cosh(γ(θ~_μ)/2)`（**前因子 `2^{M-m}` は無い**）。 -/
theorem trace_Vprime (g : CheckIdx M → ℝ) :
    (F.Vprime g).trace = ((∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by
  classical
  have hsum : (F.Vprime g).trace = ((∑ T : Finset (CheckIdx M), Real.exp (F.gval g T) : ℝ) : ℂ) := by
    match M, F, g with
    | 0, F, g => exact F.trace_Vprime_eq_finset_sum_of_mathlib g
    | r + 1, F, g =>
      calc (F.Vprime g).trace
          = NecSuf.binWordSum r (fun ε => ((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) :=
            trace_Vprime_step1 F g                      -- Step 1 の鎖
        _ = ((NecSuf.binWordSum r (fun ε => Real.exp (F.gval g (finsetOfBinWord ε))) : ℝ) : ℂ) :=
            binWordSum_ofReal r _                       -- Step 2 の 1 行目: `real_inclusion_preserves_sum_over_binary_words`
                                                        -- （`x_ε → exp(ǧ(ε))`）
        _ = ((∑ ε : Fin (r + 1) → Fin 2, Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ) := by
            rw [NecSuf.binWordSum_eq_sum r]             -- 人手の和を Lean の和へ付け替える（運ぶ段）
        _ = ((∑ T : Finset (CheckIdx (r + 1)), Real.exp (F.gval g T) : ℝ) : ℂ) :=
            congrArg (fun t : ℝ => (t : ℂ))
              (Fintype.sum_bijective finsetOfBinWord finsetOfBinWord_bijective _ _ (fun _ => rfl))
                                                        -- 語から部分集合への全単射で添字を付け替える（運ぶ段）
  rw [hsum, F.sum_exp_gval g]

/-- **原文 `trace_of_check_Vprime` Step 3**: `tr((V̌')^{-1}) = tr(V̌')`（`cosh` が偶関数）。 -/
theorem trace_Vprime_inv (g : CheckIdx M → ℝ) :
    (F.Vprime (fun i => -(g i))).trace = (F.Vprime g).trace := by
  rw [F.trace_Vprime, F.trace_Vprime]
  norm_cast
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [show -(g i) / 2 = -(g i / 2) by ring, Real.cosh_neg]

/-- **原文 `trace_of_check_Vprime` Step 4**: `tr(V̌') > 0`（`cosh ≥ 1`）。 -/
theorem trace_Vprime_pos (g : CheckIdx M → ℝ) :
    ∃ r : ℝ, 0 < r ∧ (F.Vprime g).trace = (r : ℂ) := by
  refine ⟨∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)), ?_, F.trace_Vprime g⟩
  refine Finset.prod_pos fun i _ => ?_
  have : (0 : ℝ) < Real.cosh (g i / 2) := Real.cosh_pos _
  linarith

end CheckFermiSetup

end Ising2D
