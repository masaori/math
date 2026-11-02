/-
# 行列の 1 倍は元の行列（**具体版**）

対応する人手証明のラベル: `scalar_multiple_by_one`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_multiple_by_one`）。

**必要十分版**: `Ising2D/NecSuf/OneSmulMatrix.lean`。具体版をその系として導くのは
`ClaimScalarMultipleByOneFromNecSuf.lean`。

## 人手証明との対応

* 成分の鎖の 2 行は `matrix_one_smul_apply` の `calc` の 2 段と 1 対 1 である。
  1 行目は `matrix_smul_apply`（`def_matrix_scalar_multiple`）、2 行目の「`1_ℂ` は `ℂ` の積の単位元」
  （`complex_numbers_form_a_field`）は `one_mul`。
* 最後の「全ての成分が一致する」は `Matrix.ext`。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`scalar_multiple_by_one`** の成分の鎖: `(1_ℂ A)_{ij} = A_{ij}`。 -/
theorem matrix_one_smul_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    ((1 : ℂ) • A) i j = A i j :=
  calc ((1 : ℂ) • A) i j
      = 1 * A i j := matrix_smul_apply _ _ _ _     -- `def_matrix_scalar_multiple`
    _ = A i j := one_mul _                         -- `1_ℂ` は `ℂ` の積の単位元（`complex_numbers_form_a_field`）

/-- **`scalar_multiple_by_one`**: `1_ℂ A = A`。 -/
theorem matrix_one_smul {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : (1 : ℂ) • A = A :=
  Matrix.ext (matrix_one_smul_apply A)   -- 全ての成分が一致する

end Ising2D
