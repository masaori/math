/-
# `Mat(2^M, ℂ)` の行列の差が零行列であることと等しいことの同値（**具体版**）

対応する人手証明のラベル: `matrix_difference_zero_iff_equal`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の `finite_matrix_claim_difference_is_zero_iff_equal`）の、
行列が `Mat(2^M, ℂ)` の場合（`m, p → 2^M`）。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixVectorIdentityScalarDifference.lean`。具体版をその系として導くのは
`ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
  `A - B = O` は `(A - B)_{ik} = O_{ik}` の全ての `i, k` に、`A = B` は `A_{ik} = B_{ik}` の全ての `i, k` に移る。
* 差と零行列の成分を、番号の上の本文の式へ移す（`tensorPow_sub_apply`（`def_matrix_difference`）・
  `tensorPow_zero_apply`（`def_zero_matrix`））。これで `A - B = O` は、番号で読んだ成分の行列（`Fin n` の添字の行列）
  `Aν - Bν = O` と同値になる。
* 番号で読んだ成分の行列について人手の主張（`ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の
  `matrix_sub_eq_zero_iff`）を引き、`Aν = Bν` を得る。人手の主張は任意の `m, p` について述べてあり、ここはその `2^M` の場合である。
* `Aν = Bν` を、番号で読んだ全ての成分の等号を通して `A = B` へ戻す。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`matrix_difference_zero_iff_equal`**（`Mat(2^M, ℂ)`）: `A - B = O ⟺ A = B`（`A, B ∈ TensorPow M`）。 -/
theorem matrix_sub_eq_zero_iff_tensorPow {M : ℕ} (A B : TensorPow M) : A - B = 0 ↔ A = B := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  calc A - B = 0
      ↔ ∀ i k : Fin n, (A - B) (σ i) (σ k) = (0 : TensorPow M) (σ i) (σ k) :=
        hent.1 _ _                                                          -- 行列の等号は成分ごと（`def_complex_matrices`）
    _ ↔ ∀ i k : Fin n, (Aν - Bν) i k = (0 : Matrix (Fin n) (Fin n) ℂ) i k := by
        simp only [tensorPow_sub_apply, tensorPow_zero_apply, matrix_sub_apply, matrix_zero_apply,
          hAν, hBν, Matrix.of_apply]                                        -- `def_matrix_difference`・`def_zero_matrix`、`Aν`・`Bν` の定義
    _ ↔ Aν - Bν = 0 := Matrix.ext_iff                                       -- 行列の等号は成分ごと
    _ ↔ Aν = Bν := matrix_sub_eq_zero_iff Aν Bν                             -- `matrix_difference_zero_iff_equal`
    _ ↔ ∀ i k : Fin n, Aν i k = Bν i k := Matrix.ext_iff.symm               -- 行列の等号は成分ごと
    _ ↔ ∀ i k : Fin n, A (σ i) (σ k) = B (σ i) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]                               -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ ↔ A = B := (hent.1 _ _).symm                                          -- 行列の等号は成分ごと（`def_complex_matrices`）

end Ising2D
