/-
# 零行列のスカラー倍は零行列（**具体版**）

対応する人手証明のラベル: `scalar_multiple_of_zero_matrix`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_multiple_of_zero_matrix`）。

**必要十分版**: `Ising2D/NecSuf/SmulZeroMatrix.lean`。具体版をその系として導くのは
`ClaimScalarMultipleOfZeroMatrixFromNecSuf.lean`。

## 人手証明との対応

* 行列のスカラー倍・零行列は mathlib の `•`・`0` を使い、人手の成分の式との接点は
  `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_smul_apply`（`def_matrix_scalar_multiple`）・
  `matrix_zero_apply`（`def_zero_matrix`）である。
* 成分の鎖の 4 行は `matrix_smul_zero_matrix_apply` の `calc` の 4 段と 1 対 1 である。
  `complex_times_zero_is_zero`（`z 0_ℂ = 0_ℂ`）は、本文の他の箇所の Lean と同じく `mul_zero` で出す。
  最後の「行列の等号は成分ごと」は `Matrix.ext`。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`scalar_multiple_of_zero_matrix`** の成分の鎖: `(aO)_{ik} = O_{ik}`。 -/
theorem matrix_smul_zero_matrix_apply {m n : ℕ} (a : ℂ) (i : Fin m) (k : Fin n) :
    (a • (0 : Matrix (Fin m) (Fin n) ℂ)) i k = (0 : Matrix (Fin m) (Fin n) ℂ) i k :=
  calc (a • (0 : Matrix (Fin m) (Fin n) ℂ)) i k
      = a * (0 : Matrix (Fin m) (Fin n) ℂ) i k := matrix_smul_apply _ _ _ _   -- `def_matrix_scalar_multiple`
    _ = a * 0 := by rw [matrix_zero_apply]                                     -- `def_zero_matrix`
    _ = 0 := mul_zero a                                                        -- `complex_times_zero_is_zero`（`z = a`）
    _ = (0 : Matrix (Fin m) (Fin n) ℂ) i k := (matrix_zero_apply i k).symm    -- `def_zero_matrix`

/-- **`scalar_multiple_of_zero_matrix`**: `aO = O`。 -/
theorem matrix_smul_zero_matrix {m n : ℕ} (a : ℂ) :
    a • (0 : Matrix (Fin m) (Fin n) ℂ) = 0 :=
  Matrix.ext (matrix_smul_zero_matrix_apply a)   -- 行列の等号は成分ごと

end Ising2D
