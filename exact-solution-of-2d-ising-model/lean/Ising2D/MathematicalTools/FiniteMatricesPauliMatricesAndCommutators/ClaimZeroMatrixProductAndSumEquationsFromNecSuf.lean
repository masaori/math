/-
# 零行列を左から掛けると零行列・自分自身との和が零行列なら零行列・和の等式から右の項を差で表す（具体版を必要十分版から導く）

具体版 `ClaimZeroMatrixProductAndSumEquations.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixZeroMulAndSumEquations.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。`hz := zero_mul`（人手の `complex_zero_times_is_zero`）、
`h := complexTwo⁻¹`・`hinv`（人手の `2_ℂ^{-1}` の取り方）、`hone := one_mul`・`hassoc := mul_assoc`（`complex_numbers_form_a_field`）、
`h·0 = 0` は `mul_zero`（`complex_times_zero_is_zero`）を渡す。
人手のラベルは `zero_matrix_is_left_zero_of_mat_mult`・`matrix_sum_with_itself_zero_implies_zero`・`matrix_summand_from_sum_equation`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroMatrixProductAndSumEquations
import Ising2D.NecSuf.MatrixZeroMulAndSumEquations
import Ising2D.Basic

namespace Ising2D

/-- `2_ℂ^{-1}` は `1_ℂ + 1_ℂ` の左逆元（人手の `2_ℂ^{-1}` の取り方）。 -/
theorem complexTwo_inv_mul : complexTwo⁻¹ * (1 + 1) = 1 := by
  rw [one_add_one_eq_complexTwo]
  exact inv_mul_cancel₀ complexTwo_ne_zero

/-- `zero_matrix_mul` を `NecSuf.zero_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem zero_matrix_mul_of_necSuf {m n p : ℕ} (B : Matrix (Fin n) (Fin p) ℂ) :
    (0 : Matrix (Fin m) (Fin n) ℂ) * B = 0 :=
  NecSuf.zero_mul_matrix' (fun x => zero_mul x) B

/-- `matrix_eq_zero_of_add_self_eq_zero` を `NecSuf.eq_zero_of_add_self_eq_zero_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_eq_zero_of_add_self_eq_zero_of_necSuf {m p : ℕ} (X : Matrix (Fin m) (Fin p) ℂ)
    (h : X + X = 0) : X = 0 :=
  NecSuf.eq_zero_of_add_self_eq_zero_matrix' complexTwo⁻¹ complexTwo_inv_mul one_mul mul_assoc
    (mul_zero _) X h

/-- `matrix_eq_sub_of_add_eq` を `NecSuf.eq_sub_of_add_eq_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_eq_sub_of_add_eq_of_necSuf {m p : ℕ} (A B C : Matrix (Fin m) (Fin p) ℂ) (h : A + B = C) :
    B = C - A :=
  NecSuf.eq_sub_of_add_eq_matrix' A B C h

/-- `zero_matrix_is_left_zero_of_mat_mult` の `TensorPow M` での系（`NecSuf.zero_mul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem zero_matrix_mul_tensorPow {M : ℕ} (B : TensorPow M) : (0 : TensorPow M) * B = 0 :=
  NecSuf.zero_mul_matrix' (fun x => zero_mul x) B

/-- `matrix_sum_with_itself_zero_implies_zero` の `TensorPow M` での系。 -/
theorem eq_zero_of_add_self_eq_zero_tensorPow {M : ℕ} (X : TensorPow M) (h : X + X = 0) : X = 0 :=
  NecSuf.eq_zero_of_add_self_eq_zero_matrix' complexTwo⁻¹ complexTwo_inv_mul one_mul mul_assoc
    (mul_zero _) X h

/-- `matrix_summand_from_sum_equation` の `TensorPow M` での系。 -/
theorem eq_sub_of_add_eq_tensorPow {M : ℕ} (A B C : TensorPow M) (h : A + B = C) : B = C - A :=
  NecSuf.eq_sub_of_add_eq_matrix' A B C h

end Ising2D
