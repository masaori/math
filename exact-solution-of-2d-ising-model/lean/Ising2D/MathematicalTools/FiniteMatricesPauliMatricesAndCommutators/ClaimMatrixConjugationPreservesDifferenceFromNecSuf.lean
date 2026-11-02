/-
# 行列の共役は符号反転と差を保つ（具体版を必要十分版から導く）

具体版 `ClaimMatrixConjugationPreservesDifference.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixConjugationNegSub.lean` の
係数 `R := ℂ`、添字 `Fin n`、`B := ↑B`、`B' := ↑B⁻¹`（単元 `B` の逆元）、`hsub := sub_eq_add_neg`（人手の `def_complex_difference`）の特殊化として得る。
人手のラベルは `matrix_conjugation_preserves_negation`・`matrix_conjugation_preserves_difference`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixConjugationPreservesDifference
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

/-- `matrix_conjugation_preserves_negation` の `TensorPow M` での系（`NecSuf.conj_neg_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conj_neg_tensorPow {M : ℕ} (B : (TensorPow M)ˣ) (W : TensorPow M) :
    Conjugation.T B (-W) = -Conjugation.T B W :=
  NecSuf.conj_neg_matrix' (B : TensorPow M) ((B⁻¹ : (TensorPow M)ˣ) : TensorPow M) W

/-- `matrix_conjugation_preserves_difference` の `TensorPow M` での系（`NecSuf.conj_sub_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conj_sub_tensorPow {M : ℕ} (B : (TensorPow M)ˣ) (X W : TensorPow M) :
    Conjugation.T B (X - W) = Conjugation.T B X - Conjugation.T B W :=
  NecSuf.conj_sub_matrix' (fun x y => sub_eq_add_neg x y) (B : TensorPow M) ((B⁻¹ : (TensorPow M)ˣ) : TensorPow M) X W

end Ising2D
