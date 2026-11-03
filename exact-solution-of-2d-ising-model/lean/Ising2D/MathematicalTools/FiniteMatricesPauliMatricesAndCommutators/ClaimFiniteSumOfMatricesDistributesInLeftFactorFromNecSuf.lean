/-
# 行列の有限和を左の因子とする積は各項の積の有限和（具体版を必要十分版から導く）

具体版 `ClaimFiniteSumOfMatricesDistributesInLeftFactor.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteSumMulMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは `finite_sum_of_matrices_distributes_in_left_factor`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInLeftFactor
import Ising2D.NecSuf.FiniteSumMulMatrix
import Ising2D.Basic

namespace Ising2D

/-- `finite_sum_mul_of_matrices` を `NecSuf.finite_sum_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_mul_of_matrices_of_necSuf {m n p : ℕ} (C : Matrix (Fin n) (Fin p) ℂ) (r : ℕ)
    (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) : (∑ j, X j) * C = ∑ j, X j * C :=
  NecSuf.finite_sum_mul_matrix' C r X

/-- `finite_sum_of_matrices_distributes_in_left_factor` の `TensorPow M` での系（`NecSuf.finite_sum_mul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem finite_sum_mul_tensorPow {M : ℕ} (r : ℕ) (X : Fin (r + 1) → TensorPow M) (C : TensorPow M) :
    (∑ j, X j) * C = ∑ j, X j * C :=
  NecSuf.finite_sum_mul_matrix' C r X

end Ising2D
