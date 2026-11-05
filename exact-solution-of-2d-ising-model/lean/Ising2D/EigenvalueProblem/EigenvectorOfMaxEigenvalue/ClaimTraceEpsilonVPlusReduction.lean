/-
# `tr(εV^{(+)})` を `tr(εV_1^{(+)}V_2)` へ移し、`εV_1^{(+)}` を `exp(K_1D_0)` と `ε, G` で書く（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の準備 (P1)〜(P4)・Step 1・Step 2）

| 人手 | Lean |
| --- | --- |
| Step 1 の 6 行 `tr(εV^{(+)}) = tr(εBV_2B) = tr(BεV_2B) = tr(εV_2BB) = tr(εV_2V_1^{(+)}) = tr(V_1^{(+)}εV_2) = tr(εV_1^{(+)}V_2)` | `trace_epsilon_VPlusOfTransfer` の calc の印 `人手 1`〜`人手 6` の段（ほかの段は括弧の付け替えと `A^2 := AA`） |
| 準備 (P1) の 4 行 `(iκ)H_1^{(+)} = (κi)H_1^{(+)} = κ(iH_1^{(+)}) = κ(D_0 + εG) = κD_0 + κ(εG)` | `I_mul_smul_H1plus` の calc の 4 段 |
| 準備 (P2) の 5 行 `D_0(εG) = (D_0ε)G = ⋯ = (εG)D_0` | `commute_openChainD0_epsilon_mul_boundaryG` の calc の 5 段 |
| 準備 (P2) の `commuting_with_scalar_multiple` の 3 回の適用 `D_0(κ(εG)) = (κ(εG))D_0`・`(κ(εG))(κD_0) = (κD_0)(κ(εG))`・`ε(κD_0) = (κD_0)ε` | `openChainD0_mul_smul_epsilon_mul_boundaryG`・`smul_epsilon_mul_boundaryG_mul_smul_openChainD0`・`epsilon_mul_smul_openChainD0` |
| 準備 (P3) の帰納法 `(εG)^{2j} = I`（`j = 0` と `j → j+1` の 4 行）・`(εG)^{2j+1} = εG` の 3 行 | `pow_two_mul_of_sq_eq_one`・`pow_two_mul_add_one_of_pow_two_mul_eq_one`（`(εG)^2 = I` から `(εG)^{2j+1} = εG` を出す系 `pow_two_mul_add_one_of_sq_eq_one`） |
| 準備 (P4) の帰納法 `(κX)^n = κ^nX^n`（`n = 0` と `n → n+1` の 6 行） | `smul_pow_tensorPow` の 2 つの calc |
| Step 2 の最初の鎖の 3 行 `V_1^{(+)} = exp((iκ)H_1^{(+)}) = exp(κD_0 + κ(εG)) = exp(κD_0)exp(κ(εG))` | `V1plus_eq_exp_openChainD0_mul_exp` の calc の 3 段 |
| Step 2 の `exp(κ(εG)) = (cosh K_1)_ℂI + (sinh K_1)_ℂ(εG)`（`def_exp` の級数を偶数次と奇数次に分ける） | `matExp_smul_of_sq_eq_one`（`εG` について `exp_epsilon_mul_boundaryG`） |
| Step 2 の最後の鎖の 11 行 `εV_1^{(+)} = ε(exp(κD_0)exp(κ(εG))) = ⋯ = exp(κD_0)((cosh K_1)_ℂε + (sinh K_1)_ℂG)` | `epsilon_mul_V1plus` の calc の印 `人手 1`〜`人手 11` の段 |

`B := (V_1^{(+)})^{1/2}` は `V1plusHalf M K_1`、`V^{(+)} = BV_2B` は `VPlusOfTransfer M K_1 K_2`
（`def_V_plus`）、`BB = V_1^{(+)}` は `V1_plus_square_root_property`、`εB = Bε`・`εV_1^{(+)} = V_1^{(+)}ε` は
`epsilon_commute_V1plusHalf`・`epsilon_commute_V1plus`（`epsilon_commutes_with_V1_plus_square_root`・`epsilon_commutes_with_V1_plus`）、
トレースの巡回性は `trace_cyclic`（`trace_basic_properties` (2)）である。
準備 (P1)・(P2) の根拠は、`scalar_multiple_distributes_over_matrix_sum` が `smul_add_tensorPow`、
`commuting_with_scalar_multiple` が `mul_smul_comm_of_commute_tensorPow`（どちらも `TensorPow M` での系）、
`scalar_multiple_is_associative`・`mat_mult_associative` は Lean の具体版が無いので既存の慣行どおり mathlib の
`smul_smul`・`mul_assoc`、ℂ の積の可換律（`complex_numbers_form_a_field`）は `mul_comm` である。
準備 (P3)・(P4) の根拠は、冪の定義 `A^0 := I`・`A^{n+1} := A^nA`（`def_exp`）と `def_power_of_complex_number` が
`pow_zero`・`pow_succ`、`epsilon_G_is_involution` の `X^2 := XX` が `pow_two`、`identity_matrix_is_left_unit_of_mat_mult` が
`identity_matrix_mul_tensorPow`、`scalar_multiple_by_one` が `one_smul_tensorPow`、`scalar_multiple_factors_out_of_left_factor`・
`scalar_multiple_factors_out_of_right_factor` が `smul_mul_matrix_tensorPow`・`mul_smul_matrix_tensorPow`（いずれも `TensorPow M` での系）である。
人手 Step 1 は `V_2` との可換性を挙げるが、式変形の各行が使うのは `B` と `V_1^{(+)}` との可換性だけなので、
Lean の主張は `K_2 > 0` を仮定しない。
Step 2 の最初の鎖と最後の鎖の根拠は、`V1_plus_exponential_representation` が同名の定理、
`mat_mult_distributes_over_sum_in_right_factor` が `mul_add_matrix_tensorPow`、`identity_matrix_is_right_unit_of_mat_mult` が
`mul_identity_matrix_tensorPow`（どちらも `TensorPow M` での系）、`epsilon_square_and_eigenvalues` の `ε^2 = I` が `epsilon_sq`（積の形 `εε = I`）、
`theorem_exp_product`・`commuting_matrix_commutes_with_exp` は Lean の具体版が無いので既存の慣行どおり mathlib の
`Matrix.exp_add_of_commute`・`Commute.exp_right` である。

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
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 1: `ε` を外へ出す -/

/-- **人手 `trace_of_epsilon_V_plus` Step 1**: `tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`。

人手の 6 行が calc の印 `-- 人手 1`〜`-- 人手 6` の段に 1 対 1 で対応する（4 行目だけは `A^2 := AA` の段と合わせて 2 段）。人手は積の括弧を
`mat_mult_associative` で省き、Lean の積は左から結合する（`εBV_2B` は `((εB)V_2)B`）。
人手の行が引く事実を当てるために括弧を付け替える段（`-- 括弧の付け替え`）は Lean で補った中間であり、
`mat_mult_associative` の具体版が無いので既存の慣行どおり mathlib の `mul_assoc` で閉じる。
人手 4 行目の `BB = V_1^{(+)}` は、`V1_plus_square_root_property` の主張 `B^2 = V_1^{(+)}` と
その主張の中の `A^2 := AA` の 2 段に分けて当てる。 -/
theorem trace_epsilon_VPlusOfTransfer (K1 : ℂ) (K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M K1 K2).trace = (epsilon M * V1plus M K1 * V2 M K2).trace := by
  calc (epsilon M * VPlusOfTransfer M K1 K2).trace
      = (epsilon M * (V1plusHalf M K1 * V2 M K2 * V1plusHalf M K1)).trace := by
        rw [VPlusOfTransfer]                              -- 人手 1: `def_V_plus`
    _ = (epsilon M * V1plusHalf M K1 * V2 M K2 * V1plusHalf M K1).trace := by
        rw [← mul_assoc, ← mul_assoc]                     -- 括弧の付け替え（`mat_mult_associative`）
    _ = (V1plusHalf M K1 * epsilon M * V2 M K2 * V1plusHalf M K1).trace := by
        rw [(epsilon_commute_V1plusHalf K1).eq]           -- 人手 2: `epsilon_commutes_with_V1_plus_square_root` の `εB = Bε`
    _ = (V1plusHalf M K1 * (epsilon M * V2 M K2 * V1plusHalf M K1)).trace := by
        rw [mul_assoc (V1plusHalf M K1) (epsilon M), mul_assoc (V1plusHalf M K1)]
                                                          -- 括弧の付け替え（`mat_mult_associative`）
    _ = (epsilon M * V2 M K2 * V1plusHalf M K1 * V1plusHalf M K1).trace :=
        trace_cyclic _ _                                  -- 人手 3: `trace_basic_properties` (2) を `A = B`, `B' = εV_2B` に
    _ = (epsilon M * V2 M K2 * (V1plusHalf M K1 * V1plusHalf M K1)).trace := by
        rw [mul_assoc (epsilon M * V2 M K2)]              -- 括弧の付け替え（`mat_mult_associative`）
    _ = (epsilon M * V2 M K2 * V1plusHalf M K1 ^ 2).trace := by
        rw [← pow_two]                                    -- 人手 4 の前半: `V1_plus_square_root_property` の `A^2 := AA`
    _ = (epsilon M * V2 M K2 * V1plus M K1).trace := by
        rw [V1_plus_square_root_property]                 -- 人手 4: `V1_plus_square_root_property` の `BB = V_1^{(+)}`
    _ = (V1plus M K1 * (epsilon M * V2 M K2)).trace :=
        trace_cyclic _ _                                  -- 人手 5: `trace_basic_properties` (2) を `A = εV_2`, `B' = V_1^{(+)}` に
    _ = (V1plus M K1 * epsilon M * V2 M K2).trace := by
        rw [← mul_assoc]                                  -- 括弧の付け替え（`mat_mult_associative`）
    _ = (epsilon M * V1plus M K1 * V2 M K2).trace := by
        rw [← (epsilon_commute_V1plus K1).eq]             -- 人手 6: `epsilon_commutes_with_V1_plus` の `V_1^{(+)}ε = εV_1^{(+)}`

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

/-- **人手 `trace_of_epsilon_V_plus` Step 2 の最初の鎖**: `V_1^{(+)} = exp(κD_0)exp(κ(εG))`。

人手の 3 行と calc の 3 段が 1 対 1 である。`κ := (K_1)_ℂ` は Lean では任意の `K1 : ℂ`
（鎖は `κ` が実数の像であることを使わない）。3 段目の `theorem_exp_product` は Lean の具体版が無く、
ほかのファイルと同じく mathlib の `Matrix.exp_add_of_commute` を引く（`DefinitionV1PlusSquareRoot.lean` と同じ扱い）。 -/
theorem V1plus_eq_exp_openChainD0_mul_exp (hM : 2 ≤ M) (K1 : ℂ) :
    V1plus M K1
      = matExp (K1 • openChainD0 M) * matExp (K1 • (epsilon M * boundaryG M (by omega))) :=
  calc V1plus M K1
      = matExp ((Complex.I * K1) • H1plus M) :=
        V1plus_exponential_representation M K1            -- `V1_plus_exponential_representation`
    _ = matExp (K1 • openChainD0 M + K1 • (epsilon M * boundaryG M (by omega))) := by
        rw [I_mul_smul_H1plus hM]                         -- (P1)
    _ = matExp (K1 • openChainD0 M) * matExp (K1 • (epsilon M * boundaryG M (by omega))) :=
        Matrix.exp_add_of_commute _ _
          (smul_epsilon_mul_boundaryG_mul_smul_openChainD0 hM K1).symm
                                                          -- `theorem_exp_product` を `A = κD_0`, `B = κ(εG)` に。可換性は (P2)

/-- 人手の準備 (P3) の奇数冪の 3 行 `(εG)^{2j+1} = (εG)^{2j}(εG) = I(εG) = εG`（帰納法の仮定 `(εG)^{2j} = I` から）。
`A` は `εG` で、Lean は `TensorPow M` の任意の元で述べる（`A` が `εG` であることは使わない）。 -/
theorem pow_two_mul_add_one_of_pow_two_mul_eq_one {A : TensorPow M} (j : ℕ) (h : A ^ (2 * j) = 1) :
    A ^ (2 * j + 1) = A :=
  calc A ^ (2 * j + 1)
      = A ^ (2 * j) * A := pow_succ A (2 * j)                 -- 冪の定義 `A^{n+1} := A^nA`（`def_exp`）
    _ = 1 * A := by rw [h]                                    -- 帰納法の仮定 `(εG)^{2j} = I`
    _ = A := identity_matrix_mul_tensorPow A                  -- `identity_matrix_is_left_unit_of_mat_mult`

/-- **人手の準備 (P3)**: `(εG)^2 = I`（`epsilon_G_is_involution`）から、`j` に関する帰納法で `(εG)^{2j} = I`。
`j = 0` は冪の定義 `A^0 := I`、`j → j+1` は奇数冪の 3 行（`pow_two_mul_add_one_of_pow_two_mul_eq_one`）に続く 4 行
`(εG)^{2j+2} = (εG)^{2j+1}(εG) = (εG)(εG) = (εG)^2 = I`。 -/
theorem pow_two_mul_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (j : ℕ) : A ^ (2 * j) = 1 := by
  induction j with
  | zero => exact pow_zero A                                  -- 冪の定義 `A^0 := I`
  | succ j ih =>
    calc A ^ (2 * (j + 1))
        = A ^ (2 * j + 2) := rfl                              -- 指数 `2(j+1) = 2j+2`（人手は `(εG)^{2j+2}` と書く）
      _ = A ^ (2 * j + 1) * A := pow_succ A (2 * j + 1)       -- 冪の定義
      _ = A * A := by                                         -- 直前の `(εG)^{2j+1} = εG`
          rw [pow_two_mul_add_one_of_pow_two_mul_eq_one j ih]
      _ = A ^ 2 := (pow_two A).symm                           -- `epsilon_G_is_involution` の `X^2 := XX`
      _ = 1 := hA                                             -- `epsilon_G_is_involution`

/-- 人手の準備 (P3) の `(εG)^{2j+1} = εG`（`(εG)^{2j} = I` と奇数冪の 3 行から）。 -/
theorem pow_two_mul_add_one_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (j : ℕ) :
    A ^ (2 * j + 1) = A :=
  pow_two_mul_add_one_of_pow_two_mul_eq_one j (pow_two_mul_of_sq_eq_one hA j)

/-- **人手の準備 (P4)**: `n` に関する帰納法で `(κX)^n = κ^nX^n`（`X := εG`、`κ^n` は `def_power_of_complex_number`）。
`n = 0` は両辺とも `I`（`κ^0 = 1_ℂ` と `scalar_multiple_by_one`）、`n → n+1` は人手の 6 行。
Lean は任意の `κ : ℂ`・`X : TensorPow M` で述べる（`X` が `εG` であることも `κ` が実数の像であることも使わない）。 -/
theorem smul_pow_tensorPow (κ : ℂ) (X : TensorPow M) (n : ℕ) : (κ • X) ^ n = κ ^ n • X ^ n := by
  induction n with
  | zero =>
    calc (κ • X) ^ 0
        = 1 := pow_zero _                                     -- 冪の定義 `A^0 := I`
      _ = (1 : ℂ) • (1 : TensorPow M) := (one_smul_tensorPow 1).symm   -- `scalar_multiple_by_one` を右辺から左辺へ
      _ = κ ^ 0 • X ^ 0 := by rw [pow_zero, pow_zero]         -- `κ^0 = 1_ℂ`（`def_power_of_complex_number`）と冪の定義
  | succ n ih =>
    calc (κ • X) ^ (n + 1)
        = (κ • X) ^ n * (κ • X) := pow_succ _ n               -- 冪の定義
      _ = (κ ^ n • X ^ n) * (κ • X) := by rw [ih]             -- 帰納法の仮定
      _ = κ ^ n • (X ^ n * (κ • X)) :=
          smul_mul_matrix_tensorPow _ _ _                     -- `scalar_multiple_factors_out_of_left_factor`
      _ = κ ^ n • (κ • (X ^ n * X)) := by
          rw [mul_smul_matrix_tensorPow]                      -- `scalar_multiple_factors_out_of_right_factor`
      _ = (κ ^ n * κ) • (X ^ n * X) := smul_smul _ _ _        -- `scalar_multiple_is_associative`（具体版が無いので mathlib の `smul_smul`）
      _ = κ ^ (n + 1) • X ^ (n + 1) := by                     -- `def_power_of_complex_number` と冪の定義
          rw [← pow_succ, ← pow_succ]

/-- **人手 Step 2 の偶奇分解**: `A^2 = I` なら `exp(tA) = cosh(t)I + sinh(t)A`（`t ∈ ℝ`）。

人手の式変形どおり、指数級数を偶数次の項 `t^{2n}/(2n)! · I` と奇数次の項 `t^{2n+1}/(2n+1)! · A` に分け、
それぞれの和が `cosh t`・`sinh t` であることを代入する。 -/
theorem matExp_smul_of_sq_eq_one {A : TensorPow M} (hA : A ^ 2 = 1) (t : ℝ) :
    matExp ((t : ℂ) • A) = ((Real.cosh t : ℝ) : ℂ) • (1 : TensorPow M) + ((Real.sinh t : ℝ) : ℂ) • A := by
  -- 偶数次の項: `((2n)!)^{-1}(tA)^{2n} = (t^{2n}/(2n)!) I`
  have heven : HasSum (fun n : ℕ => (((2 * n).factorial : ℂ))⁻¹ • ((t : ℂ) • A) ^ (2 * n))
      (Complex.cosh (t : ℂ) • (1 : TensorPow M)) := by
    refine ((Complex.hasSum_cosh (t : ℂ)).smul_const (1 : TensorPow M)).congr_fun fun n => ?_
    rw [smul_pow_tensorPow, pow_two_mul_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
  -- 奇数次の項: `((2n+1)!)^{-1}(tA)^{2n+1} = (t^{2n+1}/(2n+1)!) A`
  have hodd : HasSum (fun n : ℕ => (((2 * n + 1).factorial : ℂ))⁻¹ • ((t : ℂ) • A) ^ (2 * n + 1))
      (Complex.sinh (t : ℂ) • A) := by
    refine ((Complex.hasSum_sinh (t : ℂ)).smul_const A).congr_fun fun n => ?_
    rw [smul_pow_tensorPow, pow_two_mul_add_one_of_sq_eq_one hA n, smul_smul, div_eq_inv_mul]
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

/-- **人手 `trace_of_epsilon_V_plus` Step 2 の最後の鎖**: `εV_1^{(+)} = exp(κD_0)((cosh K_1)_ℂε + (sinh K_1)_ℂG)`。

人手の 11 行と calc の 11 段が 1 対 1 である（印 `人手 1`〜`人手 11`）。`κ := (K_1)_ℂ` は `(K1 : ℂ)`。
- 3 行目の `commuting_matrix_commutes_with_exp`（`A = ε`、`B = κD_0`、可換性は (P2) の `ε(κD_0) = (κD_0)ε`）は
  Lean の具体版が無く、ほかのファイル（`ClaimEpsilonCommutes.lean`）と同じく mathlib の `Commute.exp_right` を引く。
- 7 行目の `scalar_multiple_factors_out_of_right_factor` は、同じ主張を和の二つの項へ同時に当てる 1 行である。
- 10 行目の `epsilon_square_and_eigenvalues` の `ε^2 = I` は、Lean の `epsilon_sq` が積の形 `εε = I` で述べている。
- `mat_mult_associative` は Lean の具体版が無いので既存の慣行どおり mathlib の `mul_assoc` で閉じる。 -/
theorem epsilon_mul_V1plus (hM : 2 ≤ M) (K1 : ℝ) :
    epsilon M * V1plus M (K1 : ℂ)
      = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  calc epsilon M * V1plus M (K1 : ℂ)
      = epsilon M * (matExp ((K1 : ℂ) • openChainD0 M)
          * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0))) := by
        rw [V1plus_eq_exp_openChainD0_mul_exp hM]         -- 人手 1: この Step の最初の鎖
    _ = (epsilon M * matExp ((K1 : ℂ) • openChainD0 M))
          * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0)) :=
        (mul_assoc _ _ _).symm                            -- 人手 2: `mat_mult_associative`
    _ = (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M)
          * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0)) := by
        -- 人手 3: `commuting_matrix_commutes_with_exp` を `A = ε`, `B = κD_0` に。可換性は (P2)
        have h : Commute (epsilon M) ((K1 : ℂ) • openChainD0 M) := epsilon_mul_smul_openChainD0 hM (K1 : ℂ)
        exact congrArg (· * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0))) h.exp_right.eq
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (epsilon M * matExp ((K1 : ℂ) • (epsilon M * boundaryG M hM0))) :=
        mul_assoc _ _ _                                   -- 人手 4: `mat_mult_associative`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (epsilon M * (((Real.cosh K1 : ℝ) : ℂ) • (1 : TensorPow M)
            + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * boundaryG M hM0))) := by
        rw [exp_epsilon_mul_boundaryG hM K1]              -- 人手 5: 直前の `exp(κ(εG))` の鎖
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (epsilon M * (((Real.cosh K1 : ℝ) : ℂ) • (1 : TensorPow M))
            + epsilon M * (((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * boundaryG M hM0))) := by
        rw [mul_add_matrix_tensorPow]                     -- 人手 6: `mat_mult_distributes_over_sum_in_right_factor`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • (epsilon M * 1)
            + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * (epsilon M * boundaryG M hM0))) := by
        rw [mul_smul_matrix_tensorPow, mul_smul_matrix_tensorPow]
                                                          -- 人手 7: `scalar_multiple_factors_out_of_right_factor` を 2 つの項に
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M
            + ((Real.sinh K1 : ℝ) : ℂ) • (epsilon M * (epsilon M * boundaryG M hM0))) := by
        rw [mul_identity_matrix_tensorPow]                -- 人手 8: `identity_matrix_is_right_unit_of_mat_mult`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M
            + ((Real.sinh K1 : ℝ) : ℂ) • ((epsilon M * epsilon M) * boundaryG M hM0)) := by
        rw [← mul_assoc (epsilon M) (epsilon M)]          -- 人手 9: `mat_mult_associative`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M
            + ((Real.sinh K1 : ℝ) : ℂ) • ((1 : TensorPow M) * boundaryG M hM0)) := by
        rw [epsilon_sq]                                   -- 人手 10: `epsilon_square_and_eigenvalues` の `ε^2 = I`
    _ = matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M hM0) := by
        rw [identity_matrix_mul_tensorPow]                -- 人手 11: `identity_matrix_is_left_unit_of_mat_mult`

end Ising2D
