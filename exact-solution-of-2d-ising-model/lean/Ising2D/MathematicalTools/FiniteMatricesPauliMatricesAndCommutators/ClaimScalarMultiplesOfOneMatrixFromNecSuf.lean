/-
# 一つの行列のスカラー倍の差と有限和（具体版を必要十分版から導く）

具体版 `ClaimScalarMultiplesOfOneMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulOneMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `difference_of_scalar_multiples_of_one_matrix`・
`finite_sum_of_scalar_multiples_of_one_matrix`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrix
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

end Ising2D
