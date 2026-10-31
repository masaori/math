/-
# `tr(εV^{(+)})` を `tr(εV_1^{(+)}V_2)` へ移し、`εV_1^{(+)}` を `exp(K_1D_0)` と `ε, G` で書く（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の Step 1・Step 2）

| 人手 | Lean |
| --- | --- |
| Step 1 の式変形 `tr(εV^{(+)}) = tr(εBV_2B) = ⋯ = tr(εV_1^{(+)}V_2)` | `trace_epsilon_VPlusOfTransfer` |
| Step 2 の `iK_1H_1^{(+)} = K_1D_0 + K_1εG`（`H1_plus_in_sigma_z_form`） | `I_mul_smul_H1plus` |
| 同 `K_1D_0` と `K_1εG` は可換（`epsilon_D0_G_pairwise_commute`） | `commute_openChainD0_epsilon_mul_boundaryG` |
| 同 `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)`（`theorem_exp_product`） | `V1plus_eq_exp_openChainD0_mul_exp` |
| 同 `exp(K_1εG) = cosh(K_1)I + sinh(K_1)εG`（`def_exp` の級数を偶数次と奇数次に分ける） | `matExp_smul_of_sq_eq_one`（`εG` について `exp_epsilon_mul_boundaryG`） |
| 同 `εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)` | `epsilon_mul_V1plus` |

`B := (V_1^{(+)})^{1/2}` は `V1plusHalf M K_1`、`V^{(+)} = BV_2B` は `VPlusOfTransfer M K_1 K_2`
（`def_V_plus`）、`BB = V_1^{(+)}` は `V1_plus_square_root_property`、`εB = Bε`・`εV_1^{(+)} = V_1^{(+)}ε` は
`epsilon_commute_V1plusHalf`・`epsilon_commute_V1plus`（`epsilon_commutes_with_transfer_matrices`）、
トレースの巡回性は `trace_cyclic`（`trace_basic_properties` (2)）である。
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
import Ising2D.Part018.ClaimH1PlusInSigmaZForm
import Ising2D.Part018.ClaimEpsilonD0GCommuteAndDiagonalAction
import Ising2D.Part010.DefinitionV1PlusSquareRoot
import Ising2D.Part009.Definition001_Trace
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
    -- `BB = V_1^{(+)}`（人手はこの行で `theorem_exp_product` を直接引く。Lean はその適用を済ませた
    -- `V1_plus_square_root_property`（`def_V1_plus_square_root` の平方根性）を引く）
    _ = (epsilon M * V2 M K2 * V1plus M K1).trace := by
        rw [mul_assoc (epsilon M * V2 M K2), V1_plus_square_root_property]
    -- 巡回性
    _ = (V1plus M K1 * (epsilon M * V2 M K2)).trace := by
        rw [trace_cyclic]
    -- `V_1^{(+)}ε = εV_1^{(+)}`
    _ = (epsilon M * V1plus M K1 * V2 M K2).trace := by
        rw [← mul_assoc, ← (epsilon_commute_V1plus K1).eq]

/-! ## Step 2: `εV_1^{(+)}` を対角行列と `ε` で書く -/

/-- 人手 Step 2 の `iK_1H_1^{(+)} = K_1D_0 + K_1εG`（`H1_plus_in_sigma_z_form` に `K_1` を掛ける）。 -/
theorem I_mul_smul_H1plus (hM : 2 ≤ M) (K1 : ℂ) :
    (Complex.I * K1) • H1plus M
      = K1 • openChainD0 M + K1 • (epsilon M * boundaryG M (by omega)) := by
  rw [mul_comm, ← smul_smul, H1_plus_in_sigma_z_form hM, smul_add]

/-- 人手 Step 2 の「`D_0` と `εG` は可換」（`epsilon_D0_G_pairwise_commute` の `εD_0 = D_0ε`・`D_0G = GD_0`）。 -/
theorem commute_openChainD0_epsilon_mul_boundaryG (hM : M ≠ 0) :
    Commute (openChainD0 M) (epsilon M * boundaryG M hM) :=
  calc openChainD0 M * (epsilon M * boundaryG M hM)
      = (openChainD0 M * epsilon M) * boundaryG M hM := (mul_assoc _ _ _).symm
    _ = (epsilon M * openChainD0 M) * boundaryG M hM := by rw [epsilon_mul_openChainD0]
    _ = epsilon M * (openChainD0 M * boundaryG M hM) := mul_assoc _ _ _
    _ = epsilon M * (boundaryG M hM * openChainD0 M) := by rw [openChainD0_mul_boundaryG]
    _ = (epsilon M * boundaryG M hM) * openChainD0 M := (mul_assoc _ _ _).symm

/-- **人手 Step 2**: `V_1^{(+)} = exp(K_1D_0)exp(K_1εG)`（`V1_plus_exponential_representation`、
`H1_plus_in_sigma_z_form`、`K_1D_0` と `K_1εG` の可換性と `theorem_exp_product`）。 -/
theorem V1plus_eq_exp_openChainD0_mul_exp (hM : 2 ≤ M) (K1 : ℂ) :
    V1plus M K1
      = matExp (K1 • openChainD0 M) * matExp (K1 • (epsilon M * boundaryG M (by omega))) := by
  have hc : Commute (K1 • openChainD0 M) (K1 • (epsilon M * boundaryG M (by omega))) :=
    ((commute_openChainD0_epsilon_mul_boundaryG (by omega)).smul_left K1).smul_right K1
  rw [V1plus_exponential_representation, I_mul_smul_H1plus hM, matExp, matExp, matExp,
    Matrix.exp_add_of_commute _ _ hc]

/-- 人手 Step 2 の `(εG)^2 = I` から `(εG)^{2n} = I`。 -/
theorem pow_two_mul_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (n : ℕ) : A ^ (2 * n) = 1 := by
  rw [pow_mul, hA, one_pow]

/-- 人手 Step 2 の `(εG)^2 = I` から `(εG)^{2n+1} = εG`。 -/
theorem pow_two_mul_add_one_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (n : ℕ) :
    A ^ (2 * n + 1) = A := by
  rw [pow_succ, pow_two_mul_of_sq_eq_one hA n, one_mul]

/-- 人手 `def_exp`: `exp(X) = ∑_k (k!)^{-1}X^k`（級数の和として）。
収束は `def_matrix_norm` の行列ノルム（成分の絶対値の二乗和の平方根）で述べられているので、
ここでも同じノルムを入れて引く。 -/
theorem matExp_hasSum (X : TensorPow M) :
    HasSum (fun k : ℕ => ((k.factorial : ℂ))⁻¹ • X ^ k) (matExp X) := by
  letI : NormedRing (TensorPow M) := Matrix.frobeniusNormedRing
  letI : NormedAlgebra ℂ (TensorPow M) := Matrix.frobeniusNormedAlgebra
  exact NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) X

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
theorem exp_epsilon_mul_boundaryG (hM : M ≠ 0) (K1 : ℝ) :
    matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM))
      = ((Real.cosh K1 : ℝ) : ℂ) • (1 : TensorPow M)
        + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * boundaryG M hM) :=
  matExp_smul_of_sq_eq_one (epsilon_mul_boundaryG_sq hM) K1

/-- **人手 `trace_of_epsilon_V_plus` Step 2**: `εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`。 -/
theorem epsilon_mul_V1plus (hM : 2 ≤ M) (K1 : ℝ) :
    epsilon M * V1plus M (K1 : ℂ)
      = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  -- `εexp(K_1D_0) = exp(K_1D_0)ε`（`εD_0 = D_0ε` から、級数の部分和とも極限とも可換）
  have hcomm : Commute (epsilon M) (matExp ((K1 : ℂ) • openChainD0 M)) := by
    have h : Commute (epsilon M) (openChainD0 M) := epsilon_mul_openChainD0 M
    rw [matExp]
    exact (h.smul_right _).exp_right
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
        rw [exp_epsilon_mul_boundaryG hM0 K1]
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
