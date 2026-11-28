/-
# 行列の共役は符号反転と差を保つ（具体版を必要十分版から導く）

具体版 `ClaimMatrixConjugationPreservesDifference.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixConjugationNegSub.lean` の
係数 `R := ℂ`、添字 `Fin n`、`B := ↑B`、`B' := ↑B⁻¹`（単元 `B` の逆元）、`hsub := sub_eq_add_neg`（人手の `def_complex_difference`）の特殊化として得る。
人手のラベルは `matrix_conjugation_preserves_negation`・`matrix_conjugation_preserves_difference`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowConjugationPreservesNegationAndDifference.lean` の
`conj_neg_tensorPow`・`conj_sub_tensorPow` も、同じ必要十分版の添字 `Conf M` の特殊化として得る（`*_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixConjugationPreservesDifference
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowConjugationPreservesNegationAndDifference
import Ising2D.NecSuf.MatrixConjugationNegSub
import Ising2D.Basic

namespace Ising2D

/-- `conj_neg_matrix` を `NecSuf.conj_neg_matrix'`（係数 `ℂ`、`B' = B^{-1}`）の特殊化として得る。 -/
theorem conj_neg_matrix_of_necSuf {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (W : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (-W) = -Conjugation.T B W :=
  NecSuf.conj_neg_matrix' (B : Matrix (Fin n) (Fin n) ℂ) ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) W

/-- `conj_sub_matrix` を `NecSuf.conj_sub_matrix'`（係数 `ℂ`、`B' = B^{-1}`）の特殊化として得る。 -/
theorem conj_sub_matrix_of_necSuf {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (X W : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (X - W) = Conjugation.T B X - Conjugation.T B W :=
  NecSuf.conj_sub_matrix' (fun x y => sub_eq_add_neg x y) (B : Matrix (Fin n) (Fin n) ℂ)
    ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) X W

/-- `matrix_conjugation_preserves_negation` の `TensorPow M` での具体版 `conj_neg_tensorPow`
（`ClaimTensorPowConjugationPreservesNegationAndDifference.lean`）を、`NecSuf.conj_neg_matrix'` の添字 `Conf M`、`B' := Binv` の特殊化として得る。 -/
theorem conj_neg_tensorPow_of_necSuf {M : ℕ} (B Binv : TensorPow M) (W : TensorPow M) :
    B * (-W) * Binv = -(B * W * Binv) :=
  NecSuf.conj_neg_matrix' B Binv W

/-- `matrix_conjugation_preserves_difference` の `TensorPow M` での具体版 `conj_sub_tensorPow`
（`ClaimTensorPowConjugationPreservesNegationAndDifference.lean`）を、`NecSuf.conj_sub_matrix'` の添字 `Conf M`、`B' := Binv` の特殊化として得る。 -/
theorem conj_sub_tensorPow_of_necSuf {M : ℕ} (B Binv : TensorPow M) (X W : TensorPow M) :
    B * (X - W) * Binv = B * X * Binv - B * W * Binv :=
  NecSuf.conj_sub_matrix' (fun x y => sub_eq_add_neg x y) B Binv X W

end Ising2D
