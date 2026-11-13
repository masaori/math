/-
# 一つの行列のスカラー倍の差と有限和（具体版を必要十分版から導く）

具体版 `ClaimScalarMultiplesOfOneMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulOneMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `difference_of_scalar_multiples_of_one_matrix`・
`finite_sum_of_scalar_multiples_of_one_matrix`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.NecSuf.SmulOneMatrix
import Ising2D.Basic

namespace Ising2D

/-- `smul_sub_smul_matrix` を `NecSuf.smul_sub_smul_matrix'`（係数 `ℂ`、`hsub := sub_eq_add_neg`）の特殊化として得る。 -/
theorem smul_sub_smul_matrix_of_necSuf {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    a • A - b • A = (a - b) • A :=
  NecSuf.smul_sub_smul_matrix' sub_eq_add_neg a b A

/-- `finite_sum_smul_one_matrix` を `NecSuf.finite_sum_smul_one_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_smul_one_matrix_of_necSuf {m n : ℕ} (r : ℕ) (c : Fin (r + 1) → ℂ)
    (A : Matrix (Fin m) (Fin n) ℂ) : ∑ j, c j • A = (∑ j, c j) • A :=
  NecSuf.finite_sum_smul_one_matrix' r c A

/-- `difference_of_scalar_multiples_of_one_matrix` の `TensorPow M` での系（`NecSuf.smul_sub_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem smul_sub_smul_tensorPow {M : ℕ} (a b : ℂ) (A : TensorPow M) : a • A - b • A = (a - b) • A :=
  NecSuf.smul_sub_smul_matrix' sub_eq_add_neg a b A

/-- `finite_sum_of_scalar_multiples_of_one_matrix` の `TensorPow M` での系（`NecSuf.finite_sum_smul_one_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem finite_sum_smul_one_tensorPow {M : ℕ} (r : ℕ) (c : Fin (r + 1) → ℂ) (A : TensorPow M) :
    ∑ j, c j • A = (∑ j, c j) • A :=
  NecSuf.finite_sum_smul_one_matrix' r c A

/-- `finite_sum_of_scalar_multiples_of_one_matrix` の `TensorPow M` での系で、項の個数 `n` を問わない形。
`n = r + 1` では `finite_sum_smul_one_tensorPow` そのものである。`n = 0` は人手の範囲の外（`def_finite_sum_of_matrices` は
項の個数が `1` 以上の和だけを定める）で、両辺とも空の和なので `zero_scalar_multiple_is_zero_matrix` で `O` に揃う。
人手 `Z_Y_linearly_independent` の Step 6 の `Σ_{m=1}^{M_col}`（人手は `M_col ≥ 1`）を、Lean の `Fin M` の上の和で書くために置く。 -/
theorem finite_sum_smul_one_tensorPow_fin {M : ℕ} (n : ℕ) (c : Fin n → ℂ) (A : TensorPow M) :
    ∑ j, c j • A = (∑ j, c j) • A := by
  cases n with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, zero_smul_tensorPow]
  | succ r => exact finite_sum_smul_one_tensorPow r c A

end Ising2D
