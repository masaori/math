/-
# 行列の差は符号反転した行列との和に等しい・符号反転した行列の差は差の符号反転に等しい（具体版を必要十分版から導く）

具体版 `ClaimMatrixDifferenceIsSumWithNegation.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixSubNeg.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`、`hsub := sub_eq_add_neg`（人手の `def_complex_difference`）、
`hneg := complex_neg_eq_neg_one_mul`（人手の `multiply_by_minus_one`）の特殊化として得る。
人手のラベルは `matrix_difference_is_sum_with_negation`・`difference_of_negated_matrices`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowDifferenceIsSumWithNegation.lean` の主張 `sub_eq_add_neg_tensorPow` も、
同じ必要十分版の添字 `Conf M` の特殊化として得る（`sub_eq_add_neg_tensorPow_of_necSuf`）。
`difference_of_negated_matrices` の `TensorPow M` での系 `neg_sub_neg_tensorPow` は、具体版がまだ無いので必要十分版の特殊化として置く
（人手の証明が引く `negation_distributes_over_matrix_sum` の `TensorPow M` の具体版が要る）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.NecSuf.MatrixSubNeg
import Ising2D.Basic

namespace Ising2D

/-- `matrix_sub_eq_add_neg` を `NecSuf.sub_eq_add_neg_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_sub_eq_add_neg_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : A - B = A + (-B) :=
  NecSuf.sub_eq_add_neg_matrix' (fun x y => sub_eq_add_neg x y) A B

/-- `neg_sub_neg_matrix` を `NecSuf.neg_sub_neg_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_sub_neg_matrix_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : (-A) - (-B) = -(A - B) :=
  NecSuf.neg_sub_neg_matrix' (fun x y => sub_eq_add_neg x y) complex_neg_eq_neg_one_mul A B

/-- 具体版 `sub_eq_add_neg_tensorPow`（`matrix_difference_is_sum_with_negation` の `TensorPow M` での具体版）を
`NecSuf.sub_eq_add_neg_matrix'` の添字 `Conf M` の特殊化として得る。 -/
theorem sub_eq_add_neg_tensorPow_of_necSuf {M : ℕ} (A B : TensorPow M) : A - B = A + (-B) :=
  NecSuf.sub_eq_add_neg_matrix' (fun x y => sub_eq_add_neg x y) A B

/-- `difference_of_negated_matrices` の `TensorPow M` での系（`NecSuf.neg_sub_neg_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem neg_sub_neg_tensorPow {M : ℕ} (A B : TensorPow M) : (-A) - (-B) = -(A - B) :=
  NecSuf.neg_sub_neg_matrix' (fun x y => sub_eq_add_neg x y) complex_neg_eq_neg_one_mul A B

end Ising2D
