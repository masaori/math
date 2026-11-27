/-
# `Mat(2^M, ℂ)` の行列について `exp(-A)exp(A) = I`（**具体版**）

対応する人手証明のラベル: `exp_of_negative_is_left_inverse`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_exp_of_negative_is_left_inverse`）の、
行列が `Mat(2^M, ℂ)` の場合（`n → 2^M`）。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/ExpNegMulExp.lean`。具体版をその系として導くのは
`ClaimExpOfNegativeIsLeftInverseFromNecSuf.lean`（`matExp_neg_mul_matExp_tensorPow_of_necSuf`）。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。

| 人手 | Lean（具体版） |
| --- | --- |
| 準備の第一の鎖 `((-A)A)_{kl} = … = (A(-A))_{kl}` と「なので `(-A)A = A(-A)`」 | `neg_tensorPow_mul_self_comm` |
| 準備の第二の鎖 `((-A)+A)_{kl} = … = O_{kl}` と「なので `(-A)+A = O`」 | `neg_tensorPow_add_self` |
| 指数の鎖の 3 行 | `matExp_neg_mul_matExp_tensorPow` の `calc` の 3 段 |

* 準備の二つの鎖は、成分を番号で読んだ行列 `Aν`（`Fin n` の添字の行列、`(Aν)_{jl} = A (σ j) (σ l)`）の成分の鎖そのものである。
  積・符号反転・和・零行列の成分を番号の上の本文の式へ移し（`tensorPow_mul_apply_eq_mat_mult`（`mat_mult`）・`tensorPow_neg_apply`
  （`def_matrix_negation`）・`tensorPow_add_apply`（`def_matrix_sum`）・`tensorPow_zero_apply`（`def_zero_matrix`））、
  `Aν` の鎖（`ClaimExpOfNegativeIsLeftInverse.lean` の `neg_matrix_mul_self_apply`・`neg_matrix_add_self_apply`）を引く。
  行列の等号は、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 指数の鎖の 1 行目 `theorem_exp_product`（`K = ℂ`）と 3 行目 `theorem_exp_zero` は、`Fin n` の場合と同じく Lean の具体版が無く、
  mathlib の `Matrix.exp_add_of_commute`・`NormedSpace.exp_zero` を引く。
-/
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverse
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices
import Ising2D.Representation

namespace Ising2D

open Matrix

/-- **`exp_of_negative_is_left_inverse`**（`Mat(2^M, ℂ)`）の準備の第一の鎖と「なので `(-A)A = A(-A)`」（`A ∈ TensorPow M`）。 -/
theorem neg_tensorPow_mul_self_comm {M : ℕ} (A : TensorPow M) : (-A) * A = A * (-A) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  refine (hent.1 _ _).2 (fun k l => ?_)                                      -- 行列の等号は成分ごと（`def_complex_matrices`）
  calc ((-A) * A) (σ k) (σ l)
      = ∑ j : Fin n, (-A) (σ k) (σ j) * A (σ j) (σ l) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ k l                  -- `mat_mult`
    _ = ∑ j : Fin n, (-Aν) k j * Aν j l := by
        simp only [tensorPow_neg_apply, matrix_neg_apply, hAν, Matrix.of_apply]  -- `def_matrix_negation`、`Aν` の定義
    _ = ((-Aν) * Aν) k l := (matrix_mul_apply_sum _ _ _ _).symm               -- `mat_mult`
    _ = (Aν * (-Aν)) k l := neg_matrix_mul_self_apply Aν k l                  -- 準備の第一の鎖（`Aν` の成分）
    _ = ∑ j : Fin n, Aν k j * (-Aν) j l := matrix_mul_apply_sum _ _ _ _        -- `mat_mult`
    _ = ∑ j : Fin n, A (σ k) (σ j) * (-A) (σ j) (σ l) := by
        simp only [tensorPow_neg_apply, matrix_neg_apply, hAν, Matrix.of_apply]  -- `def_matrix_negation`、`Aν` の定義
    _ = (A * (-A)) (σ k) (σ l) :=
        (tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ k l).symm           -- `mat_mult`

/-- **`exp_of_negative_is_left_inverse`**（`Mat(2^M, ℂ)`）の準備の第二の鎖と「なので `(-A)+A = O`」（`A ∈ TensorPow M`）。 -/
theorem neg_tensorPow_add_self {M : ℕ} (A : TensorPow M) : (-A) + A = 0 := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  refine (hent.1 _ _).2 (fun k l => ?_)                                      -- 行列の等号は成分ごと（`def_complex_matrices`）
  calc ((-A) + A) (σ k) (σ l)
      = ((-Aν) + Aν) k l := by
        simp only [tensorPow_add_apply, tensorPow_neg_apply, matrix_sum_apply, matrix_neg_apply,
          hAν, Matrix.of_apply]                                                -- `def_matrix_sum`・`def_matrix_negation`、`Aν` の定義
    _ = (0 : Matrix (Fin n) (Fin n) ℂ) k l := neg_matrix_add_self_apply Aν k l  -- 準備の第二の鎖（`Aν` の成分）
    _ = (0 : TensorPow M) (σ k) (σ l) := by
        rw [matrix_zero_apply, tensorPow_zero_apply]                           -- `def_zero_matrix`

/-- **`exp_of_negative_is_left_inverse`**（`Mat(2^M, ℂ)`）: `exp(-A)exp(A) = I`（`A ∈ TensorPow M`）。 -/
theorem matExp_neg_mul_matExp_tensorPow {M : ℕ} (A : TensorPow M) : matExp (-A) * matExp A = 1 :=
  calc matExp (-A) * matExp A
      = matExp ((-A) + A) :=                                                   -- `theorem_exp_product`（`K = ℂ`）と準備の `(-A)A = A(-A)`
        (Matrix.exp_add_of_commute (-A) A (neg_tensorPow_mul_self_comm A)).symm
    _ = matExp (0 : TensorPow M) := by                                          -- 準備の `(-A)+A = O`
        rw [neg_tensorPow_add_self]
    _ = 1 := NormedSpace.exp_zero                                              -- `theorem_exp_zero`

end Ising2D
