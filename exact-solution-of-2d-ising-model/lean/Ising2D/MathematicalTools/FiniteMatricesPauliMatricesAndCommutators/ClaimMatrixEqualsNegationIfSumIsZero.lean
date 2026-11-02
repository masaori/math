/-
# 和が零行列なら一方は他方の符号反転（**具体版**）

対応する人手証明のラベル: `matrix_equals_negation_if_sum_is_zero`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_matrix_equals_negation_if_sum_is_zero`）。

**必要十分版**: `Ising2D/NecSuf/MatrixEqNegOfAddEqZero.lean`。具体版をその系として導くのは
`ClaimMatrixEqualsNegationIfSumIsZeroFromNecSuf.lean`。

## 人手証明との対応

* 人手の鎖 `X - (-Y) = X + (-(-Y)) = X + Y = O` の 3 行は、`matrix_sub_neg_eq_zero_of_add_eq_zero` の `calc` の 3 段と 1 対 1 である
  （`matrix_difference_is_sum_with_negation` は `matrix_sub_eq_add_neg`、`matrix_double_negation` は `neg_neg_matrix`）。
* 続く「`matrix_difference_zero_iff_equal` を `A → X`、`B → -Y` で引く」は `matrix_sub_eq_zero_iff` の `⟹` である。
* 人手の `m, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegation

namespace Ising2D

open Matrix

/-- **`matrix_equals_negation_if_sum_is_zero`** の証明の鎖: `X + Y = O` なら `X - (-Y) = O`。 -/
theorem matrix_sub_neg_eq_zero_of_add_eq_zero {m p : ℕ} (X Y : Matrix (Fin m) (Fin p) ℂ)
    (h : X + Y = 0) : X - (-Y) = 0 :=
  calc X - (-Y)
      = X + (-(-Y)) := matrix_sub_eq_add_neg X (-Y)    -- `matrix_difference_is_sum_with_negation`（`A → X`, `B → -Y`）
    _ = X + Y := by rw [neg_neg_matrix]                 -- `matrix_double_negation`
    _ = 0 := h                                          -- 仮定 `X + Y = O`

/-- **`matrix_equals_negation_if_sum_is_zero`**: `X + Y = O` なら `X = -Y`。 -/
theorem matrix_eq_neg_of_add_eq_zero {m p : ℕ} (X Y : Matrix (Fin m) (Fin p) ℂ) (h : X + Y = 0) :
    X = -Y :=
  (matrix_sub_eq_zero_iff X (-Y)).mp (matrix_sub_neg_eq_zero_of_add_eq_zero X Y h)
                                                        -- `matrix_difference_zero_iff_equal`（`A → X`, `B → -Y`）

end Ising2D
