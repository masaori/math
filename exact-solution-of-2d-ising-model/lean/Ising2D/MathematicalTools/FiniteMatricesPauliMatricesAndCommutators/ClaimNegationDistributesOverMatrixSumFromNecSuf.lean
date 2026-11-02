/-
# 行列の和・有限和の符号反転は符号反転の和・有限和に等しい（具体版を必要十分版から導く）

具体版 `ClaimNegationDistributesOverMatrixSum.lean` の主張を、必要十分版 `Ising2D/NecSuf/NegMatrixSum.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`、`hneg := complex_neg_eq_neg_one_mul`（人手の `multiply_by_minus_one`）の特殊化として得る。
人手のラベルは `negation_distributes_over_matrix_sum`・`finite_sum_of_negated_matrices`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationDistributesOverMatrixSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.NecSuf.NegMatrixSum
import Ising2D.Basic

namespace Ising2D

/-- `neg_add_matrix` を `NecSuf.neg_add_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_add_matrix_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : -(A + B) = (-A) + (-B) :=
  NecSuf.neg_add_matrix' complex_neg_eq_neg_one_mul A B

/-- `neg_finite_sum_of_matrices` を `NecSuf.neg_finite_sum_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_finite_sum_of_matrices_of_necSuf {m n : ℕ} (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) :
    ∑ j, -X j = -∑ j, X j :=
  NecSuf.neg_finite_sum_matrix' complex_neg_eq_neg_one_mul r X

/-- `negation_distributes_over_matrix_sum` の `TensorPow M` での系（`NecSuf.neg_add_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem neg_add_tensorPow {M : ℕ} (A B : TensorPow M) : -(A + B) = (-A) + (-B) :=
  NecSuf.neg_add_matrix' complex_neg_eq_neg_one_mul A B

/-- `finite_sum_of_negated_matrices` の `TensorPow M` での系（`NecSuf.neg_finite_sum_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem neg_finite_sum_tensorPow {M : ℕ} (r : ℕ) (X : Fin (r + 1) → TensorPow M) :
    ∑ j, -X j = -∑ j, X j :=
  NecSuf.neg_finite_sum_matrix' complex_neg_eq_neg_one_mul r X

end Ising2D
