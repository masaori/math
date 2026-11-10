/-
# 行列の符号反転を二回施すと元に戻る（**具体版**）

対応する人手証明のラベル: `matrix_double_negation`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_matrix_double_negation`）。

**必要十分版**: `Ising2D/NecSuf/NegNegMatrix.lean`。具体版をその系として導くのは
`ClaimMatrixDoubleNegationFromNecSuf.lean`。

## 人手証明との対応

* `(i, j)` 成分の鎖を人手の 6 行の順に辿り、最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_neg_apply`（`def_matrix_negation`）である。
* 人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  `ℂ` の積の結合律は `mul_assoc`、`(-1_ℂ)(-1_ℂ) = 1_ℂ` は人手 `minus_one_times_minus_one_is_one_in_cc` の具体版
  `complex_minus_one_mul_minus_one`、`1_ℂ` が積の単位元であることは `one_mul` で出す。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC

namespace Ising2D

open Matrix

/-- **`matrix_double_negation`** の成分の鎖: `(-(-A))_{ij} = A_{ij}`。 -/
theorem neg_neg_matrix_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (-(-A)) i j = A i j :=
  calc (-(-A)) i j
      = -((-A) i j) := matrix_neg_apply _ _ _                                -- `def_matrix_negation`
    _ = -(-A i j) := by rw [matrix_neg_apply]                                -- `def_matrix_negation`
    _ = (-1) * ((-1) * A i j) := by rw [neg_one_mul, neg_one_mul]            -- `multiply_by_minus_one`（2 か所へ同時適用）
    _ = ((-1) * (-1)) * A i j := (mul_assoc _ _ _).symm                      -- `ℂ` の積の結合律
    _ = 1 * A i j := by rw [complex_minus_one_mul_minus_one]                 -- `minus_one_times_minus_one_is_one_in_cc`
    _ = A i j := one_mul _                                                   -- `1_ℂ` は積の単位元

/-- **`matrix_double_negation`**: `-(-A) = A`。 -/
theorem neg_neg_matrix {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : -(-A) = A :=
  Matrix.ext (neg_neg_matrix_apply A)   -- 全ての成分が一致する

end Ising2D
