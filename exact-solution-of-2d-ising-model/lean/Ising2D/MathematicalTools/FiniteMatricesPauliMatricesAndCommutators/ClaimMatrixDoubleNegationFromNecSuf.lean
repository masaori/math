/-
# 行列の符号反転を二回施すと元に戻る（具体版を必要十分版から導く）

具体版 `ClaimMatrixDoubleNegation.lean` の主張を、必要十分版 `Ising2D/NecSuf/NegNegMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `matrix_double_negation`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegation
import Ising2D.NecSuf.NegNegMatrix
import Ising2D.Basic

namespace Ising2D

/-- 必要十分版の仮定 `hneg` を `ℂ` で与える（人手の `multiply_by_minus_one`）。 -/
theorem complex_neg_eq_neg_one_mul (x : ℂ) : -x = (-1) * x := (neg_one_mul x).symm

/-- 必要十分版の仮定 `hmm` を `ℂ` で与える（人手の `minus_one_times_minus_one_is_one_in_cc`）。 -/
theorem complex_neg_one_mul_neg_one : (-1 : ℂ) * (-1) = 1 := complex_minus_one_mul_minus_one

/-- `neg_neg_matrix` を `NecSuf.neg_neg_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_neg_matrix_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : -(-A) = A :=
  NecSuf.neg_neg_matrix' complex_neg_eq_neg_one_mul complex_neg_one_mul_neg_one A

/-- `matrix_double_negation` の `TensorPow M` での系（`NecSuf.neg_neg_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem neg_neg_tensorPow {M : ℕ} (A : TensorPow M) : -(-A) = A :=
  NecSuf.neg_neg_matrix' complex_neg_eq_neg_one_mul complex_neg_one_mul_neg_one A

end Ising2D
