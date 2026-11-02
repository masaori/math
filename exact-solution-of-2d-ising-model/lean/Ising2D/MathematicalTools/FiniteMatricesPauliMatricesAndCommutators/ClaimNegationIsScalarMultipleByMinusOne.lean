/-
# 行列の符号反転は −1 倍に等しい（**具体版**）

対応する人手証明のラベル: `negation_is_scalar_multiple_by_minus_one`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_negation_is_scalar_multiple_by_minus_one`）。

**必要十分版**: `Ising2D/NecSuf/NegEqNegOneSmulMatrix.lean`。具体版をその系として導くのは
`ClaimNegationIsScalarMultipleByMinusOneFromNecSuf.lean`。

## 人手証明との対応

* `(i, j)` 成分の鎖を人手の 3 行の順に辿り、最後に「全ての成分が一致する」で行列の等号にする。
* 成分の式との接点は `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の `matrix_neg_apply`（`def_matrix_negation`）と
  `matrix_smul_apply`（`def_matrix_scalar_multiple`）である。
* 人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`negation_is_scalar_multiple_by_minus_one`** の成分の鎖: `(-A)_{ij} = ((-1)A)_{ij}`。 -/
theorem neg_eq_neg_one_smul_matrix_apply {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (-A) i j = ((-1 : ℂ) • A) i j :=
  calc (-A) i j
      = -A i j := matrix_neg_apply _ _ _                                     -- `def_matrix_negation`
    _ = (-1) * A i j := (neg_one_mul _).symm                                 -- `multiply_by_minus_one`
    _ = ((-1 : ℂ) • A) i j := (matrix_smul_apply _ _ _ _).symm               -- `def_matrix_scalar_multiple`

/-- **`negation_is_scalar_multiple_by_minus_one`**: `-A = (-1_ℂ)A`。 -/
theorem neg_eq_neg_one_smul_matrix {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    -A = (-1 : ℂ) • A :=
  Matrix.ext (neg_eq_neg_one_smul_matrix_apply A)   -- 全ての成分が一致する

end Ising2D
