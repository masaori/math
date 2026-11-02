/-
# 行列の共役は和・スカラー倍・有限和を保つ（具体版を必要十分版から導く）

具体版 `ClaimMatrixConjugationPreservesSums.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixConjugationSum.lean` の
係数 `R := ℂ`、添字 `Fin n`、`B := ↑B`、`B' := ↑B⁻¹`（単元 `B` の逆元）の特殊化として得る。
人手のラベルは `mat_conj`・`matrix_conjugation_preserves_finite_sum`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixConjugationPreservesSums
import Ising2D.NecSuf.MatrixConjugationSum
import Ising2D.Basic

namespace Ising2D

/-- `conj_add_matrix` を `NecSuf.conj_add_matrix'`（係数 `ℂ`、`B' = B^{-1}`）の特殊化として得る。 -/
theorem conj_add_matrix_of_necSuf {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (A C : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (A + C) = Conjugation.T B A + Conjugation.T B C :=
  NecSuf.conj_add_matrix' (B : Matrix (Fin n) (Fin n) ℂ) ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) A C

/-- `conj_smul_matrix` を `NecSuf.conj_smul_matrix'`（係数 `ℂ`、`B' = B^{-1}`）の特殊化として得る。 -/
theorem conj_smul_matrix_of_necSuf {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (α : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (α • A) = α • Conjugation.T B A :=
  NecSuf.conj_smul_matrix' α (B : Matrix (Fin n) (Fin n) ℂ) ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) A

/-- `conj_finite_sum_of_matrices` を `NecSuf.conj_finite_sum_matrix'`（係数 `ℂ`、`B' = B^{-1}`）の特殊化として得る。 -/
theorem conj_finite_sum_of_matrices_of_necSuf {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (r : ℕ)
    (X : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (∑ j, X j) = ∑ j, Conjugation.T B (X j) :=
  NecSuf.conj_finite_sum_matrix' (B : Matrix (Fin n) (Fin n) ℂ)
    ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) r X

/-- `mat_conj`（和を保つ）の `TensorPow M` での系（`NecSuf.conj_add_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conj_add_tensorPow {M : ℕ} (B : (TensorPow M)ˣ) (A C : TensorPow M) :
    Conjugation.T B (A + C) = Conjugation.T B A + Conjugation.T B C :=
  NecSuf.conj_add_matrix' (B : TensorPow M) ((B⁻¹ : (TensorPow M)ˣ) : TensorPow M) A C

/-- `mat_conj`（スカラー倍を保つ）の `TensorPow M` での系（`NecSuf.conj_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conj_smul_tensorPow {M : ℕ} (B : (TensorPow M)ˣ) (α : ℂ) (A : TensorPow M) :
    Conjugation.T B (α • A) = α • Conjugation.T B A :=
  NecSuf.conj_smul_matrix' α (B : TensorPow M) ((B⁻¹ : (TensorPow M)ˣ) : TensorPow M) A

/-- `matrix_conjugation_preserves_finite_sum` の `TensorPow M` での系（`NecSuf.conj_finite_sum_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conj_finite_sum_tensorPow {M : ℕ} (B : (TensorPow M)ˣ) (r : ℕ) (X : Fin (r + 1) → TensorPow M) :
    Conjugation.T B (∑ j, X j) = ∑ j, Conjugation.T B (X j) :=
  NecSuf.conj_finite_sum_matrix' (B : TensorPow M) ((B⁻¹ : (TensorPow M)ˣ) : TensorPow M) r X

end Ising2D
