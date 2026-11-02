/-
# 零行列を右から掛けると零行列（**具体版**）

対応する人手証明のラベル: `zero_matrix_is_right_zero_of_mat_mult`（`structured-latex/content/002_linear_space_general.ts` の
`linear_space_general_claim_zero_matrix_is_right_zero_of_mat_mult`）。

**必要十分版**: `Ising2D/NecSuf/MatrixMulZero.lean`。具体版をその系として導くのは
`ClaimZeroMatrixIsRightZeroOfMatMultFromNecSuf.lean`。

## 人手証明との対応

* 成分の鎖の 5 行は、`matrix_mul_zero_matrix_apply` の `calc` の 5 段と 1 対 1 である。
  `z 0_ℂ = 0_ℂ`（`complex_times_zero_is_zero`）は `mul_zero`、`Σ_{j=1}^{n} 0_ℂ = 0_ℂ`（`finite_sum_of_complex_zeros`）は
  `Finset.sum_const_zero` で出す（どちらも人手の主張に Lean の具体版が無い。`zero_matrix_mul_apply` と同じ扱い）。
* 最後の「全ての成分が一致する」は `Matrix.ext`。人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`zero_matrix_is_right_zero_of_mat_mult`** の成分の鎖: `(A O_{n,p})_{ik} = (O_{m,p})_{ik}`。 -/
theorem matrix_mul_zero_matrix_apply {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin p) :
    (A * (0 : Matrix (Fin n) (Fin p) ℂ)) i k = (0 : Matrix (Fin m) (Fin p) ℂ) i k :=
  calc (A * (0 : Matrix (Fin n) (Fin p) ℂ)) i k
      = ∑ j, A i j * (0 : Matrix (Fin n) (Fin p) ℂ) j k := matrix_mul_apply_sum _ _ _ _  -- `mat_mult`
    _ = ∑ j, A i j * (0 : ℂ) := by simp only [matrix_zero_apply]                      -- `def_zero_matrix` を各項へ
    _ = ∑ _j : Fin n, (0 : ℂ) := by simp only [mul_zero]                               -- `complex_times_zero_is_zero` を各項へ
    _ = 0 := Finset.sum_const_zero                                                      -- `finite_sum_of_complex_zeros`
    _ = (0 : Matrix (Fin m) (Fin p) ℂ) i k := (matrix_zero_apply _ _).symm             -- `def_zero_matrix`

/-- **`zero_matrix_is_right_zero_of_mat_mult`**: `A O_{n,p} = O_{m,p}`。 -/
theorem matrix_mul_zero_matrix {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    A * (0 : Matrix (Fin n) (Fin p) ℂ) = 0 :=
  Matrix.ext (matrix_mul_zero_matrix_apply A)   -- 全ての成分が一致する

end Ising2D
