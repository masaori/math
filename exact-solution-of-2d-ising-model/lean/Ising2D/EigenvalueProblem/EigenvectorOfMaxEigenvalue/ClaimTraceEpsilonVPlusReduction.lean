/-
# `tr(εV^{(+)})` を `tr(εV_1^{(+)}V_2)` へ移し、`εV_1^{(+)}` を `exp(K_1D_0)` と `ε, G` で書く（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の準備 (P1)・(P2)・Step 1・Step 2）

| 人手 | Lean |
| --- | --- |
| Step 1 の式変形 `tr(εV^{(+)}) = tr(εBV_2B) = ⋯ = tr(εV_1^{(+)}V_2)` | `trace_epsilon_VPlusOfTransfer` |
| 準備 (P1) の 4 行 `(iκ)H_1^{(+)} = (κi)H_1^{(+)} = κ(iH_1^{(+)}) = κ(D_0 + εG) = κD_0 + κ(εG)` | `I_mul_smul_H1plus` の calc の 4 段 |
| 準備 (P2) の 5 行 `D_0(εG) = (D_0ε)G = ⋯ = (εG)D_0` | `commute_openChainD0_epsilon_mul_boundaryG` の calc の 5 段 |
| 同 `commuting_with_scalar_multiple` の 3 回の適用 `D_0(κ(εG)) = (κ(εG))D_0`・`(κ(εG))(κD_0) = (κD_0)(κ(εG))`・`ε(κD_0) = (κD_0)ε` | `openChainD0_mul_smul_epsilon_mul_boundaryG`・`smul_epsilon_mul_boundaryG_mul_smul_openChainD0`・`epsilon_mul_smul_openChainD0` |
| Step 2 の `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)`（`theorem_exp_product`） | `V1plus_eq_exp_openChainD0_mul_exp` |
| 同 `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG`（`def_exp` の級数を偶数次と奇数次に分ける） | `matExp_smul_of_sq_eq_one`（`εG` について `exp_epsilon_mul_boundaryG`） |
| 同 `εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)` | `epsilon_mul_V1plus` |

`B := (V_1^{(+)})^{1/2}` は `V1plusHalf M K_1`、`V^{(+)} = BV_2B` は `VPlusOfTransfer M K_1 K_2`
（`def_V_plus`）、`BB = V_1^{(+)}` は `V1_plus_square_root_property`、`εB = Bε`・`εV_1^{(+)} = V_1^{(+)}ε` は
`epsilon_commute_V1plusHalf`・`epsilon_commute_V1plus`（`epsilon_commutes_with_V1_plus_square_root`・`epsilon_commutes_with_V1_plus`）、
トレースの巡回性は `trace_cyclic`（`trace_basic_properties` (2)）である。
準備 (P1)・(P2) の根拠は、`scalar_multiple_distributes_over_matrix_sum` が `smul_add_tensorPow`、
`commuting_with_scalar_multiple` が `mul_smul_comm_of_commute_tensorPow`（どちらも `TensorPow M` での系）、
`scalar_multiple_is_associative`・`mat_mult_associative` は Lean の具体版が無いので既存の慣行どおり mathlib の
`smul_smul`・`mul_assoc`、ℂ の積の可換律（`complex_numbers_form_a_field`）は `mul_comm` である。
人手 Step 1 は `V_2` との可換性を挙げるが、式変形の各行が使うのは `B` と `V_1^{(+)}` との可換性だけなので、
Lean の主張は `K_2 > 0` を仮定しない。

`exp(K_1εG)` の偶奇分解は、人手どおり指数級数 `∑_k (k!)^{-1}(K_1εG)^k` を偶数次と奇数次に分け、
`(εG)^{2n} = I`、`(εG)^{2n+1} = εG` と `cosh K_1 = ∑_n K_1^{2n}/(2n)!`、`sinh K_1 = ∑_n K_1^{2n+1}/(2n+1)!`
（`Complex.hasSum_cosh`・`Complex.hasSum_sinh`）を代入して足し直す（`HasSum.even_add_odd`）。
最後に、`def_exp` の部分和の極限が一つに決まることで `exp(K_1εG)` と足し直した和を等しいとする。
この偶奇分解が使うのは `A^2 = 1` と、スカラー倍・和と極限の交換だけなので、必要十分版
`NecSuf/ExpOfInvolution.lean` を置き、具体版の `matExp_smul_of_sq_eq_one` をその系として
`ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` で導く。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimH1PlusInSigmaZForm
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonD0GCommuteAndDiagonalAction
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionV1PlusSquareRoot
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithScalarMultipleFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 1: `ε` を外へ出す -/

/-- **人手 `trace_of_epsilon_V_plus` Step 1**: `tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`。 -/
theorem trace_epsilon_VPlusOfTransfer (K1 : ℂ) (K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M K1 K2).trace = (epsilon M * V1plus M K1 * V2 M K2).trace := by
  calc (epsilon M * VPlusOfTransfer M K1 K2).trace
      = (epsilon M * (V1plusHalf M K1 * V2 M K2 * V1plusHalf M K1)).trace := by
        rw [VPlusOfTransfer]
    -- `εB = Bε`
    _ = (V1plusHalf M K1 * (epsilon M * V2 M K2 * V1plusHalf M K1)).trace := by
        rw [← mul_assoc, ← mul_assoc, (epsilon_commute_V1plusHalf K1).eq]
        simp only [mul_assoc]
    -- 巡回性を `A = B`, `B' = εV_2B` に適用
    _ = (epsilon M * V2 M K2 * V1plusHalf M K1 * V1plusHalf M K1).trace := by
        rw [trace_cyclic]
    -- `BB = V_1^{(+)}`（人手と同じく `V1_plus_square_root_property`（`def_V1_plus_square_root` の平方根性）を引く）
    _ = (epsilon M * V2 M K2 * V1plus M K1).trace := by
        rw [mul_assoc (epsilon M * V2 M K2), ← sq, V1_plus_square_root_property]
    -- 巡回性
    _ = (V1plus M K1 * (epsilon M * V2 M K2)).trace := by
        rw [trace_cyclic]
    -- `V_1^{(+)}ε = εV_1^{(+)}`
    _ = (epsilon M * V1plus M K1 * V2 M K2).trace := by
        rw [← mul_assoc, ← (epsilon_commute_V1plus K1).eq]

/-! ## Step 2: `εV_1^{(+)}` を対角行列と `ε` で書く -/

/-- **人手 `trace_of_epsilon_V_plus` の準備 (P1)**: `(iκ)H_1^{(+)} = κD_0 + κ(εG)`。

人手の 4 行と calc の 4 段が 1 対 1 である。`κ := (K_1)_ℂ` は Lean では任意の `κ : ℂ`
（鎖は `κ` が実数の像であることを使わない）。 -/
theorem I_mul_smul_H1plus (hM : 2 ≤ M) (κ : ℂ) :
    (Complex.I * κ) • H1plus M
      = κ • openChainD0 M + κ • (epsilon M * boundaryG M (by omega)) :=
  calc (Complex.I * κ) • H1plus M
      = (κ * Complex.I) • H1plus M := by
        rw [mul_comm Complex.I κ]                         -- `complex_numbers_form_a_field` の積の可換律
    _ = κ • (Complex.I • H1plus M) := by
        rw [smul_smul]                                    -- `scalar_multiple_is_associative`
    _ = κ • (openChainD0 M + epsilon M * boundaryG M (by omega)) := by
        rw [H1_plus_in_sigma_z_form hM]                   -- `H1_plus_in_sigma_z_form`
    _ = κ • openChainD0 M + κ • (epsilon M * boundaryG M (by omega)) :=
        smul_add_tensorPow κ _ _                          -- `scalar_multiple_distributes_over_matrix_sum`

/-- **人手の準備 (P2)** の鎖: `D_0(εG) = (εG)D_0`（`epsilon_D0_G_pairwise_commute` の `εD_0 = D_0ε`・`D_0G = GD_0`）。

人手の 5 行と calc の 5 段が 1 対 1 である。 -/
theorem commute_openChainD0_epsilon_mul_boundaryG (hM : 2 ≤ M) :
    Commute (openChainD0 M) (epsilon M * boundaryG M (by omega)) :=
  calc openChainD0 M * (epsilon M * boundaryG M (by omega))
      = (openChainD0 M * epsilon M) * boundaryG M (by omega) := (mul_assoc _ _ _).symm  -- `mat_mult_associative`
    _ = (epsilon M * openChainD0 M) * boundaryG M (by omega) := by
        rw [epsilon_mul_openChainD0 hM]                   -- `εD_0 = D_0ε`
    _ = epsilon M * (openChainD0 M * boundaryG M (by omega)) := mul_assoc _ _ _          -- `mat_mult_associative`
    _ = epsilon M * (boundaryG M (by omega) * openChainD0 M) := by
        rw [openChainD0_mul_boundaryG hM]                 -- `D_0G = GD_0`
    _ = (epsilon M * boundaryG M (by omega)) * openChainD0 M := (mul_assoc _ _ _).symm  -- `mat_mult_associative`

/-- 人手の準備 (P2) の `D_0(κ(εG)) = (κ(εG))D_0`（`commuting_with_scalar_multiple` を `(G, X, c) = (D_0, εG, κ)` で）。 -/
theorem openChainD0_mul_smul_epsilon_mul_boundaryG (hM : 2 ≤ M) (κ : ℂ) :
    openChainD0 M * (κ • (epsilon M * boundaryG M (by omega)))
      = (κ • (epsilon M * boundaryG M (by omega))) * openChainD0 M :=
  mul_smul_comm_of_commute_tensorPow κ _ _ (commute_openChainD0_epsilon_mul_boundaryG hM).eq

/-- 人手の準備 (P2) の `(κ(εG))(κD_0) = (κD_0)(κ(εG))`
（`commuting_with_scalar_multiple` を `(G, X, c) = (κ(εG), D_0, κ)` で。仮定は直前の主張の両辺を入れ替えたもの）。 -/
theorem smul_epsilon_mul_boundaryG_mul_smul_openChainD0 (hM : 2 ≤ M) (κ : ℂ) :
    (κ • (epsilon M * boundaryG M (by omega))) * (κ • openChainD0 M)
      = (κ • openChainD0 M) * (κ • (epsilon M * boundaryG M (by omega))) :=
  mul_smul_comm_of_commute_tensorPow κ _ _ (openChainD0_mul_smul_epsilon_mul_boundaryG hM κ).symm

/-- 人手の準備 (P2) の `ε(κD_0) = (κD_0)ε`
（`epsilon_D0_G_pairwise_commute` の `εD_0 = D_0ε` に `commuting_with_scalar_multiple` を `(G, X, c) = (ε, D_0, κ)` で）。 -/
theorem epsilon_mul_smul_openChainD0 (hM : 2 ≤ M) (κ : ℂ) :
    epsilon M * (κ • openChainD0 M) = (κ • openChainD0 M) * epsilon M :=
  mul_smul_comm_of_commute_tensorPow κ _ _ (epsilon_mul_openChainD0 hM)

/-- **人手 Step 2**: `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)`（`V1_plus_exponential_representation`、
`H1_plus_in_sigma_z_form`、`K_1D_0` と `K_1εG` の可換性と `theorem_exp_product`）。 -/
theorem V1plus_eq_exp_openChainD0_mul_exp (hM : 2 ≤ M) (K1 : ℂ) :
    V1plus M K1
      = matExp (K1 • openChainD0 M) * matExp (K1 • (epsilon M * boundaryG M (by omega))) := by
  -- 可換性は (P2) の `(κ(εG))(κD_0) = (κD_0)(κ(εG))`
  have hc : Commute (K1 • openChainD0 M) (K1 • (epsilon M * boundaryG M (by omega))) :=
    (smul_epsilon_mul_boundaryG_mul_smul_openChainD0 hM K1).symm
  rw [V1plus_exponential_representation, I_mul_smul_H1plus hM, matExp, matExp, matExp,
    Matrix.exp_add_of_commute _ _ hc]

/-- 人手 Step 2 の `(εG)^2 = I` から `(εG)^{2n} = I`。 -/
theorem pow_two_mul_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (n : ℕ) : A ^ (2 * n) = 1 := by
  rw [pow_mul, hA, one_pow]

/-- 人手 Step 2 の `(εG)^2 = I` から `(εG)^{2n+1} = εG`。 -/
theorem pow_two_mul_add_one_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (n : ℕ) :
    A ^ (2 * n + 1) = A := by
  rw [pow_succ, pow_two_mul_of_sq_eq_one hA n, one_mul]

/-- **人手 Step 2 の偶奇分解**: `A^2 = I` なら `exp(tA) = cosh(t)I + sinh(t)A`（`t ∈ ℝ`）。

人手の式変形どおり、指数級数を偶数次の項 `t^{2n}/(2n)! · I` と奇数次の項 `t^{2n+1}/(2n+1)! · A` に分け、
それぞれの和が `cosh t`・`sinh t` であることを代入する。 -/
theorem matExp_smul_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (t : ℝ) :
    matExp ((t : ℂ) • A) = ((Real.cosh t : ℝ) : ℂ) • (1 : TensorPow M) + ((Real.sinh t : ℝ) : ℂ) • A := by
  -- 偶数次の項: `((2n)!)^{-1}(tA)^{2n} = (t^{2n}/(2n)!) I`
  have heven : HasSum (fun n : ℕ => (((2 * n).factorial : ℂ))⁻¹ • ((t : ℂ) • A) ^ (2 * n))
      (Complex.cosh (t : ℂ) • (1 : TensorPow M)) := by
    refine ((Complex.hasSum_cosh (t : ℂ)).smul_const (1 : TensorPow M)).congr_fun fun n => ?_
    rw [smul_pow, pow_two_mul_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
  -- 奇数次の項: `((2n+1)!)^{-1}(tA)^{2n+1} = (t^{2n+1}/(2n+1)!) A`
  have hodd : HasSum (fun n : ℕ => (((2 * n + 1).factorial : ℂ))⁻¹ • ((t : ℂ) • A) ^ (2 * n + 1))
      (Complex.sinh (t : ℂ) • A) := by
    refine ((Complex.hasSum_sinh (t : ℂ)).smul_const A).congr_fun fun n => ?_
    rw [smul_pow, pow_two_mul_add_one_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
  -- 偶数次と奇数次を足し直す
  have hall := HasSum.even_add_odd
    (f := fun k : ℕ => ((k.factorial : ℂ))⁻¹ • ((t : ℂ) • A) ^ k) heven hodd
  -- 部分和の極限は一つに決まる
  rw [tendsto_nhds_unique (matExp_hasSum ((t : ℂ) • A)).tendsto_sum_nat hall.tendsto_sum_nat,
    ← Complex.ofReal_cosh, ← Complex.ofReal_sinh]

/-- 人手 Step 2 の `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG`（`epsilon_G_is_involution` の `(εG)^2 = I`）。 -/
theorem exp_epsilon_mul_boundaryG (hM : 2 ≤ M) (K1 : ℝ) :
    matExp ((K1 : ℂ) • (epsilon M * boundaryG M (by omega)))
      = ((Real.cosh K1 : ℝ) : ℂ) • (1 : TensorPow M)
        + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * boundaryG M (by omega)) :=
  matExp_smul_of_sq_eq_one (epsilon_mul_boundaryG_sq hM) K1

/-- **人手 `trace_of_epsilon_V_plus` Step 2**: `εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`。 -/
theorem epsilon_mul_V1plus (hM : 2 ≤ M) (K1 : ℝ) :
    epsilon M * V1plus M (K1 : ℂ)
      = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  -- `εexp(K_1D_0) = exp(K_1D_0)ε`（(P2) の `ε(κD_0) = (κD_0)ε` から、級数の部分和とも極限とも可換）
  have hcomm : Commute (epsilon M) (matExp ((K1 : ℂ) • openChainD0 M)) := by
    have h : Commute (epsilon M) ((K1 : ℂ) • openChainD0 M) := epsilon_mul_smul_openChainD0 hM (K1 : ℂ)
    rw [matExp]
    exact h.exp_right
  calc epsilon M * V1plus M (K1 : ℂ)
      = epsilon M * (matExp ((K1 : ℂ) • openChainD0 M)
          * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0))) := by
        rw [V1plus_eq_exp_openChainD0_mul_exp hM]
    _ = matExp ((K1 : ℂ) • openChainD0 M) * epsilon M
          * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0)) := by
        rw [← mul_assoc, hcomm.eq]
    _ = matExp ((K1 : ℂ) • openChainD0 M) * epsilon M
          * (((Real.cosh K1 : ℝ) : ℂ) • (1 : TensorPow M)
            + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * boundaryG M hM0)) := by
        rw [exp_epsilon_mul_boundaryG hM K1]
    -- 行列の積の分配則
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M
            + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * epsilon M * boundaryG M hM0)) := by
        rw [mul_assoc, mul_add, mul_smul_comm, mul_smul_comm, mul_one, mul_assoc (epsilon M)]
    -- `ε^2 = I`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M hM0) := by
        rw [epsilon_sq, one_mul]

end Ising2D
