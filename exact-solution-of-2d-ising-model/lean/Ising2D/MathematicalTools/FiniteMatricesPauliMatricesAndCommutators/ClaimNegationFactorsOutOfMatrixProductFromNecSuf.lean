/-
# 因子の符号反転は行列の積の外へ出る（具体版を必要十分版から導く）

具体版 `ClaimNegationFactorsOutOfMatrixProduct.lean` の主張を、必要十分版 `Ising2D/NecSuf/NegMatrixProduct.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは
`negation_factors_out_of_left_factor`・`negation_factors_out_of_right_factor`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProduct
import Ising2D.NecSuf.NegMatrixProduct

namespace Ising2D

/-- `neg_mul_matrix` を `NecSuf.neg_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_mul_matrix_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    (-A) * B = -(A * B) :=
  NecSuf.neg_mul_matrix' A B

/-- `mul_neg_matrix` を `NecSuf.mul_neg_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_neg_matrix_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    A * (-B) = -(A * B) :=
  NecSuf.mul_neg_matrix' A B

end Ising2D
