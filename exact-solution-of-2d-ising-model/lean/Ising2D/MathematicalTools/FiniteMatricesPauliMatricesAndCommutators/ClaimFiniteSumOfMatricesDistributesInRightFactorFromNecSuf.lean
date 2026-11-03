/-
# 行列の有限和を右の因子とする積は各項の積の有限和（具体版を必要十分版から導く）

具体版 `ClaimFiniteSumOfMatricesDistributesInRightFactor.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixMulFiniteSum.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは `finite_sum_of_matrices_distributes_in_right_factor`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInRightFactor
import Ising2D.NecSuf.MatrixMulFiniteSum
import Ising2D.Basic

namespace Ising2D

/-- `mul_finite_sum_of_matrices` を `NecSuf.mul_finite_sum_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_finite_sum_of_matrices_of_necSuf {m n p : ℕ} (C : Matrix (Fin m) (Fin n) ℂ) (r : ℕ)
    (X : Fin (r + 1) → Matrix (Fin n) (Fin p) ℂ) : C * (∑ j, X j) = ∑ j, C * X j :=
  NecSuf.mul_finite_sum_matrix' C r X

/-- `finite_sum_of_matrices_distributes_in_right_factor` の `TensorPow M` での系（`NecSuf.mul_finite_sum_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem mul_finite_sum_tensorPow {M : ℕ} (r : ℕ) (C : TensorPow M) (X : Fin (r + 1) → TensorPow M) :
    C * (∑ j, X j) = ∑ j, C * X j :=
  NecSuf.mul_finite_sum_matrix' C r X

end Ising2D
