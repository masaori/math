/-
# 複素数の和の有限和と、行列の積の因子の和への分配（具体版を必要十分版から導く）

具体版 `ClaimMatMultDistributesOverSum.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatMulDistribSum.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは `finite_sum_of_complex_sums`・
`mat_mult_distributes_over_sum_in_right_factor`・`mat_mult_distributes_over_sum_in_left_factor`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである（積の中で縮める添字 `Conf M` には、必要十分版の `finite_sum_add'` が
`Fintype.equivFin` で番号を付けてから人手と同じ帰納法を使う）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Ising2D.NecSuf.MatMulDistribSum
import Ising2D.Basic

namespace Ising2D

/-- `finite_sum_of_complex_sums` を `NecSuf.finite_sum_add_fin'`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_of_complex_sums_of_necSuf (n : ℕ) (a b : Fin n → ℂ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j :=
  NecSuf.finite_sum_add_fin' n a b

/-- `mul_add_matrix` を `NecSuf.mul_add_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_add_matrix_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B C : Matrix (Fin n) (Fin p) ℂ) :
    A * (B + C) = A * B + A * C :=
  NecSuf.mul_add_matrix' A B C

/-- `add_mul_matrix` を `NecSuf.add_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem add_mul_matrix_of_necSuf {m n p : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (C : Matrix (Fin n) (Fin p) ℂ) :
    (A + B) * C = A * C + B * C :=
  NecSuf.add_mul_matrix' A B C

/-- `mat_mult_distributes_over_sum_in_right_factor` の `TensorPow M` での系（`NecSuf.mul_add_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem mul_add_matrix_tensorPow {M : ℕ} (A B C : TensorPow M) : A * (B + C) = A * B + A * C :=
  NecSuf.mul_add_matrix' A B C

/-- `mat_mult_distributes_over_sum_in_left_factor` の `TensorPow M` での系（`NecSuf.add_mul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem add_mul_matrix_tensorPow {M : ℕ} (A B C : TensorPow M) : (A + B) * C = A * C + B * C :=
  NecSuf.add_mul_matrix' A B C

end Ising2D
