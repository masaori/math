/-
# `tr(V̌') = tr((V̌')^{-1}) > 0`（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`trace_of_check_Vprime`（`evenEigen_007_claim_...`）。

**必要十分版は置かない。** 使っている一般論はトレースの線型性（既に
`Ising2D/NecSuf/NumberOperator.lean` の「加法的かつ巡回的な汎関数 `τ`」として
抽象化してある）と、実数の指数法則・体の計算規則・`cosh` の偶関数性だけで、
取り払える構造が残っていない。

## 原文 Step 1 との対応

人手の `M_col` が Lean の `r + 1`、人手の和 `Σ_{ε∈{0,1}^𝓜̌}` が `NecSuf.binWordSum r`（行列の和は `def_sum_over_binary_words`、
複素数の和は `def_sum_over_binary_words_of_complex_numbers`。`TensorPow M` と `ℂ` の和はどちらも `NecSuf.binWordSum`）、
人手の `Q̌_ε` が `F.Qproj (finsetOfBinWord ε)` である。Step 1 の 8 行の鎖は `trace_Vprime_step1` の `calc` と 1 対 1 である。
4 行目の `trace_of_sum_over_binary_words` は、`TensorPow M` の系 `trace_binWordSum_tensorPow`（必要十分版 `NecSuf.binWordSum_map` の
特殊化。3 行目の `mul_binWordSum_tensorPow` と同じ作り）で受ける。人手の帰納法と 1 対 1 の `calc` は添字 `Fin n` の `trace_binaryWordMatrixSum` にある。
`trace_Vprime` は、`M = r + 1` では `trace_Vprime_step1` の ℂ の和を、Step 2 の 1 行目（`real_inclusion_preserves_sum_over_binary_words`。
`NecSuf.binWordSum` の系 `binWordSum_ofReal`）で ℝ の和（`def_sum_over_binary_words_of_real_numbers`）の包含へ移し、
Step 2 の指数法則の 2 行と展開の 2 行（`sum_exp_gval_step2_expansion`。各項に `exp_gval_step2_product`、展開は
`expansion_of_finite_product_of_two_term_sums_of_real`）で積へ移し、続く 6 行（`prod_step2_cosh`。ℝ の計算規則を 1 行に 1 つと、
`def_cosh_sinh` の `cosh` を右辺から左辺へ）で各因子を `2cosh(γ/2)` に書き換え、積の添字を `𝓜̌` へ戻す（運ぶ段）。人手の範囲外の `M = 0` は mathlib の `Matrix.trace_sum`・`Matrix.trace_smul` と `sum_exp_gval` で閉じる。

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
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

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

/-- **原文 `eigenvalues_of_inverse_of_check_Vprime`** の 11 行の鎖:
`(V̌')^{-1}Q̌_ε = (V̌')^{-1}(1_ℂQ̌_ε) = (V̌')^{-1}((exp 0)_ℂQ̌_ε) = (V̌')^{-1}((exp(−ǧ+ǧ))_ℂQ̌_ε)
= (V̌')^{-1}((exp(−ǧ)exp(ǧ))_ℂQ̌_ε) = (V̌')^{-1}(((exp(−ǧ))_ℂ(exp ǧ)_ℂ)Q̌_ε) = (V̌')^{-1}((exp(−ǧ))_ℂ((exp ǧ)_ℂQ̌_ε))
= (exp(−ǧ))_ℂ((V̌')^{-1}((exp ǧ)_ℂQ̌_ε)) = (exp(−ǧ))_ℂ((V̌')^{-1}(V̌'Q̌_ε)) = (exp(−ǧ))_ℂ(((V̌')^{-1}V̌')Q̌_ε)
= (exp(−ǧ))_ℂ(IQ̌_ε) = (exp(−ǧ))_ℂQ̌_ε`。
人手の `(V̌')^{-1}`（`def_check_Vprime` (2) の `V̌' ∈ R^×` の逆元）が Lean の `↑(F.VprimeUnits g)⁻¹`、人手の `Q̌_ε` が `F.Qproj T`
（`ε` と `T` は `finsetOfBinWord` で対応する）、人手の `ǧ(ε)` が `F.gval g T` である。
人手が引く `scalar_exp_product`・`scalar_exp_zero` は、`real_exp_positive` の具体版と同じく mathlib の `Real.exp_add`・`Real.exp_zero` で表す
（`def_scalar_exp` の Lean の具体版は無い）。`scalar_multiple_is_associative`・`mat_mult_associative` は Lean の具体版が無いので、
mathlib の `smul_smul`・`Matrix.mul_assoc` を 1 回ずつ使う。 -/
theorem Vprime_inv_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) * F.Qproj T
      = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ) • F.Qproj T :=
  calc (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) * F.Qproj T
      = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) * ((1 : ℂ) • F.Qproj T) := by
        rw [one_smul_tensorPow]                         -- `scalar_multiple_by_one`（`A → Q̌_ε`）を右辺から左辺へ
    _ = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          * (((Real.exp 0 : ℝ) : ℂ) • F.Qproj T) := by
        rw [Real.exp_zero, Complex.ofReal_one]          -- `scalar_exp_zero`（`K → ℝ`）を右辺から左辺へ
                                                        -- （`1_ℂ = (1)_ℂ` は `inclusion_rr_to_cc` の略記。Lean では `Complex.ofReal_one`）
    _ = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          * (((Real.exp (-(F.gval g T) + F.gval g T) : ℝ) : ℂ) • F.Qproj T) := by
        rw [neg_add_cancel]                             -- ℝ で `−a + a = 0`（`a → ǧ(ε)`）を右辺から左辺へ
    _ = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          * (((Real.exp (-(F.gval g T)) * Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T) := by
        rw [Real.exp_add]                               -- `scalar_exp_product`（`K → ℝ`、`x → −ǧ(ε)`、`y → ǧ(ε)`）を右辺から左辺へ
    _ = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          * ((((Real.exp (-(F.gval g T)) : ℝ) : ℂ) * ((Real.exp (F.gval g T) : ℝ) : ℂ)) • F.Qproj T) := by
        rw [real_inclusion_mul]                         -- `real_inclusion_preserves_product`
                                                        -- （`a → exp(−ǧ(ε))`、`b → exp(ǧ(ε))`）を右辺から左辺へ
    _ = (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
          * (((Real.exp (-(F.gval g T)) : ℝ) : ℂ) • (((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T)) := by
        rw [smul_smul]                                  -- `scalar_multiple_is_associative`
                                                        -- （`a → (exp(−ǧ(ε)))_ℂ`、`b → (exp(ǧ(ε)))_ℂ`、`A → Q̌_ε`）を右辺から左辺へ
    _ = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ)
          • ((((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
              * (((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T)) :=
        mul_smul_matrix_tensorPow _ _ _                 -- `scalar_multiple_factors_out_of_right_factor`
                                                        -- （`a → (exp(−ǧ(ε)))_ℂ`、`A → (V̌')^{-1}`、`B → (exp(ǧ(ε)))_ℂQ̌_ε`）
    _ = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ)
          • ((((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) * (F.Vprime g * F.Qproj T)) := by
        rw [F.Vprime_mul_Qproj g T]                     -- `eigenvalues_of_check_Vprime` の `V̌'Q̌_ε = (exp(ǧ(ε)))_ℂQ̌_ε` を右辺から左辺へ
    _ = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ)
          • (((((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) * F.Vprime g) * F.Qproj T) := by
        rw [Matrix.mul_assoc]                           -- `mat_mult_associative`
                                                        -- （`A → (V̌')^{-1}`、`B → V̌'`、`C → Q̌_ε`）を右辺から左辺へ
    _ = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ) • ((1 : TensorPow M) * F.Qproj T) := by
        rw [← F.VprimeUnits_val g, (F.VprimeUnits g).inv_mul]
                                                        -- `def_invertible_elements_of_R`（`g → V̌'`）の `g^{-1}g = I`
    _ = ((Real.exp (-(F.gval g T)) : ℝ) : ℂ) • F.Qproj T := by
        rw [identity_matrix_mul_tensorPow]              -- `identity_matrix_is_left_unit_of_mat_mult`（`A → Q̌_ε`）

/-- **原文 `trace_of_check_Vprime` Step 2 の指数法則の 2 行の鎖**:
`exp(ǧ(ε)) = exp(Σ_{μ=1}^{M_col} γ(θ̃_μ)(ε_μ − 1/2)) = Π_{μ=1}^{M_col} exp(γ(θ̃_μ)(ε_μ − 1/2))`
（人手の `M_col` が Lean の `r + 1`、人手の `μ` が Lean の `checkIdxOfFin j`（`μ = j + 1`）、人手の `ε_μ ∈ {0,1}` を ℝ の元として使う箇所が
Lean の `((ε j : ℕ) : ℝ)`）。 -/
theorem exp_gval_step2_product {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ)
    (ε : Fin (r + 1) → Fin 2) :
    Real.exp (F.gval g (finsetOfBinWord ε))
      = ∏ j : Fin (r + 1), Real.exp (g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2)) := by
  have hterm : ∀ j : Fin (r + 1),
      g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2)
        = g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ finsetOfBinWord ε then (1 : ℝ) else 0) - 1 / 2) := by
    intro j
    simp only [checkIdxOfFin_mem_finsetOfBinWord]
    generalize ε j = e
    fin_cases e <;> simp
  calc Real.exp (F.gval g (finsetOfBinWord ε))
      = Real.exp (∑ i : CheckIdx (r + 1),
          g i * ((if i ∈ finsetOfBinWord ε then (1 : ℝ) else 0) - 1 / 2)) := by
        rw [gval]                                       -- `eigenvalues_of_check_Vprime` の `ǧ` の定義
    _ = Real.exp (∑ j : Fin (r + 1), g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2)) :=
        congrArg Real.exp
          (Fintype.sum_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _ hterm).symm
                                                        -- Lean の `gval` は `𝓜̌` の上の和なので、人手の `Σ_{μ=1}^{M_col}` へ
                                                        -- `μ = j + 1` の全単射で添字を付け替える（運ぶ段。人手の行は無い）
    _ = ∏ j : Fin (r + 1), Real.exp (g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2)) :=
        real_exp_of_finite_sum r _                      -- `real_exp_of_finite_sum`（`m → M_col`、`j → μ`、`x_j → γ(θ̃_μ)(ε_μ − 1/2)`）

/-- 各因子の展開: `exp(ǧ(ε)) = ∏_μ (μ ∈ T ? e^{γ_μ/2} : e^{-γ_μ/2})`。
`M = r + 1` の証明は、`exp_gval_step2_product` で積へ移し、積の添字を `𝓜̌` へ戻して各因子を書き換えて閉じる。`M = 0` は mathlib の `Real.exp_sum` で閉じる。
この定理は人手の行を持たない（`sum_exp_gval` だけが使い、人手の Step 2 は `trace_Vprime` が `sum_exp_gval_step2_expansion`・`prod_step2_cosh` で 1 対 1 に通る）。 -/
theorem exp_gval_eq_prod (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    Real.exp (F.gval g T)
      = ∏ i : CheckIdx M, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))) := by
  match M, F, g, T with
  | 0, F, g, T =>
    rw [gval, Real.exp_sum]
    refine Finset.prod_congr rfl fun i _ => ?_
    by_cases hT : i ∈ T <;> simp [hT] <;> ring_nf
  | r + 1, F, g, T =>
    obtain ⟨ε, rfl⟩ := finsetOfBinWord_bijective.2 T
    rw [F.exp_gval_step2_product g ε]
    refine Fintype.prod_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _ ?_
    intro j
    simp only [checkIdxOfFin_mem_finsetOfBinWord]
    generalize ε j = e
    fin_cases e <;> simp <;> ring_nf

/-- **原文 `trace_of_check_Vprime` Step 2 の展開の 2 行**:
`Σ_ε exp(ǧ(ε)) = Σ_ε Π_μ exp(γ(θ̃_μ)(ε_μ − 1/2)) = Π_μ (exp(γ(θ̃_μ)(1 − 1/2)) + exp(γ(θ̃_μ)(0 − 1/2)))`
（人手の `M_col` が Lean の `r + 1`、人手の `μ` が Lean の `checkIdxOfFin j`、人手の和 `Σ_{ε∈{0,1}^𝓜̌}`
（`def_sum_over_binary_words_of_real_numbers`）が `NecSuf.binWordSum r`（`trace_Vprime_step1` と同じ）、
人手の `e ∈ {0,1}` を ℝ の元として使う箇所が Lean の `((e : ℕ) : ℝ)`）。 -/
theorem sum_exp_gval_step2_expansion {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ) :
    NecSuf.binWordSum r (fun ε => Real.exp (F.gval g (finsetOfBinWord ε)))
      = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
            + Real.exp (g (checkIdxOfFin j) * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2))) :=
  calc NecSuf.binWordSum r (fun ε => Real.exp (F.gval g (finsetOfBinWord ε)))
      = NecSuf.binWordSum r
          (fun ε => ∏ j : Fin (r + 1), Real.exp (g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2))) := by
        congr 1; funext ε; exact F.exp_gval_step2_product g ε
                                                        -- 直前の鎖（`exp_gval_step2_product`）を各項へ同時に
    _ = binaryWordRealSum r
          (fun ε => ∏ j : Fin (r + 1), Real.exp (g (checkIdxOfFin j) * (((ε j : ℕ) : ℝ) - 1 / 2))) :=
        (binaryWordRealSum_eq_binWordSum r _).symm      -- 人手の和の Lean の二つの表し方を付け替える（運ぶ段。人手の行は無い）
    _ = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
            + Real.exp (g (checkIdxOfFin j) * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2))) :=
        (expansion_of_finite_product_of_two_term_sums_of_real r
          (fun j e => Real.exp (g (checkIdxOfFin j) * (((e : ℕ) : ℝ) - 1 / 2)))).symm
                                                        -- `expansion_of_finite_product_of_two_term_sums_of_real_numbers`
                                                        -- （`r → M_col`、`j → μ`、`a_j^{(e)} → exp(γ(θ̃_μ)(e − 1/2))`）を右辺から左辺へ

/-- **原文 `trace_of_check_Vprime` Step 2 の展開の行に続く 6 行**:
`Π_μ(exp(γ(1 − 1/2)) + exp(γ(0 − 1/2))) = Π_μ(exp(γ·1/2) + exp(γ(0 − 1/2))) = Π_μ(exp(γ·1/2) + exp(γ(−1/2)))
= Π_μ(exp(γ·1/2) + exp(−(γ·1/2))) = Π_μ(exp(γ/2) + exp(−(γ/2))) = Π_μ 2·((exp(γ/2) + exp(−(γ/2)))/2) = Π_μ 2cosh(γ/2)`
（人手の `M_col` が Lean の `r + 1`、人手の `γ(θ̃_μ)` が Lean の `g (checkIdxOfFin j)`。各行は人手どおり各因子へ同時に書き換える）。
左辺の `(((1 : Fin 2) : ℕ) : ℝ)`・`(((0 : Fin 2) : ℕ) : ℝ)` は `sum_exp_gval_step2_expansion` の右辺の `e ∈ {0,1}` を ℝ の元として
使う書き方で、1 段目でこれを ℝ の `1`・`0` へ付け替える（運ぶ段。人手の行は無い）。 -/
theorem prod_step2_cosh {r : ℕ} (g : CheckIdx (r + 1) → ℝ) :
    ∏ j : Fin (r + 1),
        (Real.exp (g (checkIdxOfFin j) * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
          + Real.exp (g (checkIdxOfFin j) * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2)))
      = ∏ j : Fin (r + 1), 2 * Real.cosh (g (checkIdxOfFin j) / 2) :=
  calc ∏ j : Fin (r + 1),
        (Real.exp (g (checkIdxOfFin j) * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
          + Real.exp (g (checkIdxOfFin j) * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2)))
      = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * ((1 : ℝ) - 1 / 2))
            + Real.exp (g (checkIdxOfFin j) * ((0 : ℝ) - 1 / 2))) := by
        rw [Fin.val_one, Fin.val_zero, Nat.cast_one, Nat.cast_zero]
                                                        -- `e ∈ {0,1}` を ℝ の `1`・`0` へ付け替える（運ぶ段。人手の行は無い）
    _ = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * (1 / 2))
            + Real.exp (g (checkIdxOfFin j) * ((0 : ℝ) - 1 / 2))) := by
        rw [sub_half (1 : ℝ)]                           -- ℝ で `1 − 1/2 = 1/2` を各因子へ同時に
    _ = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * (1 / 2))
            + Real.exp (g (checkIdxOfFin j) * (-(1 / 2)))) := by
        rw [zero_sub (1 / 2 : ℝ)]                       -- ℝ で `0 − a = −a`（`a → 1/2`）を各因子へ同時に
    _ = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) * (1 / 2))
            + Real.exp (-(g (checkIdxOfFin j) * (1 / 2)))) := by
        refine Finset.prod_congr rfl fun j _ => ?_
        rw [mul_neg (g (checkIdxOfFin j)) (1 / 2)]      -- ℝ で `a(−b) = −(ab)`（`a → γ(θ̃_μ)`、`b → 1/2`）を各因子へ同時に
    _ = ∏ j : Fin (r + 1),
          (Real.exp (g (checkIdxOfFin j) / 2) + Real.exp (-(g (checkIdxOfFin j) / 2))) := by
        refine Finset.prod_congr rfl fun j _ => ?_
        rw [mul_one_div (g (checkIdxOfFin j)) 2]        -- ℝ で `a·(1/2) = a/2`（`a → γ(θ̃_μ)`）を各因子の 2 箇所へ同時に
    _ = ∏ j : Fin (r + 1),
          2 * ((Real.exp (g (checkIdxOfFin j) / 2) + Real.exp (-(g (checkIdxOfFin j) / 2))) / 2) := by
        refine Finset.prod_congr rfl fun j _ => ?_
        rw [mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- ℝ で `2 ≠ 0` なので `b = 2·(b/2)` を各因子へ同時に
    _ = ∏ j : Fin (r + 1), 2 * Real.cosh (g (checkIdxOfFin j) / 2) := by
        refine Finset.prod_congr rfl fun j _ => ?_
        rw [← Real.cosh_eq]                             -- `def_cosh_sinh` の `cosh`（`x → γ(θ̃_μ)/2`）を各因子へ同時に、右辺から左辺へ
                                                        -- （`def_cosh_sinh` は Lean で定義し直していない。mathlib の `Real.cosh` の
                                                        -- 等式 `Real.cosh_eq` が、人手の定義の式そのものとしてその役を担う）

/-- `∑_ε e^{ǧ(ε)} = ∏_μ 2 cosh(γ(θ~_μ)/2)`（mathlib の `Finset.prod_add`・`Real.cosh_eq` で閉じる）。
人手の行とは 1 対 1 でなく、このファイルでは人手の範囲外の `M = 0` の `trace_Vprime` だけが使う
（人手の範囲 `M = r + 1` の Step 2 は `sum_exp_gval_step2_expansion`・`prod_step2_cosh`）。 -/
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
`tr(V̌') = ∏_μ 2 cosh(γ(θ~_μ)/2)`（**前因子 `2^{M-m}` は無い**）。
人手の範囲 `M = r + 1` では、Step 1 の鎖 `trace_Vprime_step1`、Step 2 の 1 行目 `binWordSum_ofReal`、展開の 2 行
`sum_exp_gval_step2_expansion`、続く 6 行 `prod_step2_cosh` を順に通し、最後の段で積の添字を `𝓜̌` へ戻す（運ぶ段）。人手の範囲外の `M = 0` は `trace_Vprime_eq_finset_sum_of_mathlib` と `sum_exp_gval` で閉じる。 -/
theorem trace_Vprime (g : CheckIdx M → ℝ) :
    (F.Vprime g).trace = ((∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by
  match M, F, g with
  | 0, F, g => rw [F.trace_Vprime_eq_finset_sum_of_mathlib g, F.sum_exp_gval g]
  | r + 1, F, g =>
    calc (F.Vprime g).trace
        = NecSuf.binWordSum r (fun ε => ((Real.exp (F.gval g (finsetOfBinWord ε)) : ℝ) : ℂ)) :=
          trace_Vprime_step1 F g                        -- Step 1 の鎖
      _ = ((NecSuf.binWordSum r (fun ε => Real.exp (F.gval g (finsetOfBinWord ε))) : ℝ) : ℂ) :=
          binWordSum_ofReal r _                         -- Step 2 の 1 行目: `real_inclusion_preserves_sum_over_binary_words`
                                                        -- （`x_ε → exp(ǧ(ε))`）
      _ = ((∏ j : Fin (r + 1),
              (Real.exp (g (checkIdxOfFin j) * ((((1 : Fin 2) : ℕ) : ℝ) - 1 / 2))
                + Real.exp (g (checkIdxOfFin j) * ((((0 : Fin 2) : ℕ) : ℝ) - 1 / 2))) : ℝ) : ℂ) := by
          rw [sum_exp_gval_step2_expansion F g]         -- Step 2 の指数法則の 2 行と展開の 2 行
      _ = ((∏ j : Fin (r + 1), 2 * Real.cosh (g (checkIdxOfFin j) / 2) : ℝ) : ℂ) := by
          rw [prod_step2_cosh g]                        -- Step 2 の展開の行に続く 6 行
      _ = ((∏ i : CheckIdx (r + 1), (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) :=
          congrArg (fun x : ℝ => (x : ℂ))
            (Fintype.prod_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _
              fun _ => rfl)                             -- 積の添字を `μ = j + 1` の全単射で `𝓜̌` へ戻す（運ぶ段。人手の行は無い）

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
