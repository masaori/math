/-
# 転置は行列のノルムと行列の列の極限を保つ（**具体版**）

対応する人手証明のラベル: `transpose_preserves_matrix_norm`, `transpose_preserves_matrix_limits`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_transpose_preserves_matrix_norm`,
`eigenvalues_of_V_claim_transpose_preserves_matrix_limits`）。

**必要十分版**: `Ising2D/NecSuf/TransposePreservesMatrixNormAndLimits.lean`。具体版をその特殊化として導くのは
`ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `transpose_preserves_matrix_norm` の 4 行（`def_matrix_norm`（`A → A^⊤`）→ `def_matrix_transpose` を各項へ → `ℝ` の有限和の順序の入れ替え → `def_matrix_norm`） | `matrix_transpose_norm` の `calc` の 4 段 |
| `transpose_preserves_matrix_limits` の各 `N` の 2 行（`transpose_of_matrix_difference` → `transpose_preserves_matrix_norm`（`A → A_N − A`）） | `matrix_transpose_tendsto` の中の `heq` の `calc` の 2 段 |
| 同じ主張の「2 つの実数列はすべての項が等しく、仮定より `‖A_N^⊤ − A^⊤‖ → 0`」 | `matrix_transpose_tendsto` の最後の段（`funext heq` で列を書き換えて仮定を使う） |

* ノルムは mathlib の Frobenius ノルム（成分のノルムの `2` 乗の和の `1/2` 乗。`Matrix.frobenius_norm_def`）で、
  `def_matrix_norm` の行列ノルム（成分の絶対値の二乗和の非負の平方根）と値が一致する（`ClaimMatrixMultiplicationContinuity.lean` と同じ入れ方）。
* 人手の `A_N → A` は `def_matrix_norm` の定義どおり実数列 `‖A_N − A‖` の `0` への収束で、Lean も `Tendsto (fun N => ‖A N − A‖) atTop (𝓝 0)` と書く。
  ここで `ℝ` へ脱出する（人手の主張に書いてある）。
* `ℝ` の有限和の順序の入れ替えは、人手が名前だけで引いており本文に主張が無いので、mathlib の `Finset.sum_comm` を引く
  （人手 `star_preserves_norm_and_limits` (2) と同じ扱い）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixSumsAndScalarMultiples
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Complex.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- **`transpose_preserves_matrix_norm`**: `‖A^⊤‖ = ‖A‖`（人手の 4 行）。必要十分版は `NecSuf.transpose_norm'`（同じ段の並び）。 -/
theorem matrix_transpose_norm {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : ‖Aᵀ‖ = ‖A‖ :=
  calc ‖Aᵀ‖
      = (∑ k, ∑ l, ‖Aᵀ k l‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) :=
        Matrix.frobenius_norm_def _                                   -- `def_matrix_norm`（`A → A^⊤`）
    _ = (∑ k, ∑ l, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by
        simp only [matrix_transpose_apply]                            -- `def_matrix_transpose` を各項へ
    _ = (∑ l, ∑ k, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by
        rw [Finset.sum_comm]                                          -- `ℝ` の有限和の順序の入れ替え
    _ = ‖A‖ := (Matrix.frobenius_norm_def A).symm                     -- `def_matrix_norm`（`i = l`, `j = k`）

/-- **`transpose_preserves_matrix_limits`**: `‖A_N − A‖ → 0` なら `‖A_N^⊤ − A^⊤‖ → 0`。
必要十分版は `NecSuf.transpose_tendsto'`（同じ段の並び）。 -/
theorem matrix_transpose_tendsto {n : ℕ} (A : ℕ → Matrix (Fin n) (Fin n) ℂ) (Alim : Matrix (Fin n) (Fin n) ℂ)
    (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᵀ - Alimᵀ‖) atTop (𝓝 0) := by
  have heq : ∀ N, ‖(A N)ᵀ - Alimᵀ‖ = ‖A N - Alim‖ := fun N =>
    calc ‖(A N)ᵀ - Alimᵀ‖
        = ‖(A N - Alim)ᵀ‖ := by
          rw [matrix_transpose_sub]                                   -- `transpose_of_matrix_difference`（`A → A_N`, `B → A`）
      _ = ‖A N - Alim‖ := matrix_transpose_norm _                     -- `transpose_preserves_matrix_norm`（`A → A_N − A`）
  -- 2 つの実数列はすべての項が等しいので、仮定の収束がそのまま使える
  rw [funext heq]
  exact h

end Ising2D
