/-
# 行列の 0 倍は零行列・行列の和の可換則（**具体版**）

対応する人手証明のラベル: `zero_scalar_multiple_is_zero_matrix`, `matrix_sum_is_commutative`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_zero_scalar_multiple_is_zero_matrix`,
`linear_space_general_claim_matrix_sum_is_commutative`）。

**必要十分版**: `Ising2D/NecSuf/ZeroSmulAndAddCommMatrix.lean`。具体版をその系として導くのは
`ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf.lean`。

## 人手証明との対応

* `zero_scalar_multiple_is_zero_matrix` の成分の鎖の 3 行は `matrix_zero_smul_apply` の `calc` の 3 段と 1 対 1 である。
  `complex_zero_times_is_zero`（`0_ℂ z = 0_ℂ`）は、本文の他の箇所の Lean と同じく `zero_mul` で出す。
* `matrix_sum_is_commutative` の成分の鎖の 3 行は `matrix_add_comm_apply` の `calc` の 3 段と 1 対 1 である。
  `ℂ` の加法の交換律（`complex_numbers_form_a_field`）は `add_comm`。
* 成分の式との接点は `matrix_smul_apply`（`def_matrix_scalar_multiple`）・`matrix_zero_apply`（`def_zero_matrix`）・
  `matrix_sum_apply`（`def_matrix_sum`）、最後の「行列の等号は成分ごと」は `Matrix.ext`。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix

namespace Ising2D

open Matrix

/-- **`zero_scalar_multiple_is_zero_matrix`** の成分の鎖: `(0_ℂ A)_{ik} = O_{ik}`。 -/
theorem matrix_zero_smul_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    ((0 : ℂ) • A) i k = (0 : Matrix (Fin m) (Fin n) ℂ) i k :=
  calc ((0 : ℂ) • A) i k
      = 0 * A i k := matrix_smul_apply _ _ _ _                                 -- `def_matrix_scalar_multiple`
    _ = 0 := zero_mul _                                                        -- `complex_zero_times_is_zero`（`z → A_{ik}`）
    _ = (0 : Matrix (Fin m) (Fin n) ℂ) i k := (matrix_zero_apply i k).symm    -- `def_zero_matrix`

/-- **`zero_scalar_multiple_is_zero_matrix`**: `0_ℂ A = O`。 -/
theorem matrix_zero_smul {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : (0 : ℂ) • A = 0 :=
  Matrix.ext (matrix_zero_smul_apply A)   -- 行列の等号は成分ごと

/-- **`matrix_sum_is_commutative`** の成分の鎖: `(A + B)_{ik} = (B + A)_{ik}`。 -/
theorem matrix_add_comm_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (A + B) i k = (B + A) i k :=
  calc (A + B) i k
      = A i k + B i k := matrix_sum_apply _ _ _ _       -- `def_matrix_sum`
    _ = B i k + A i k := add_comm _ _                   -- `ℂ` の加法の交換律（`complex_numbers_form_a_field`）
    _ = (B + A) i k := (matrix_sum_apply _ _ _ _).symm  -- `def_matrix_sum` を右辺から左辺へ

/-- **`matrix_sum_is_commutative`**: `A + B = B + A`。 -/
theorem matrix_add_comm {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : A + B = B + A :=
  Matrix.ext (matrix_add_comm_apply A B)   -- 行列の等号は成分ごと

end Ising2D
