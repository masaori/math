/-
# `‖u‖ = 1` のとき、成分が `u_k + (ε_ℝu)_k` のベクトル `v` について `‖v‖^2 ≤ 4`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`
  （ラベル **`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `‖x‖^2 = (√Σ|x_k|^2)^2 = Σ|x_k|^2` の 2 行（`def_matrix_norm`、`definition_of_sqrt_r_positive` の `y^2 = x`） | `vecNorm_sq_eq_sum_abs_sq` の `calc` の 2 段（同じ準備を持つ `ClaimNormOfNormalizedRealVectorIsOne.lean` に置いた） |
| 準備: `|v_k|^2` の 4 行の鎖（`square_of_real_absolute_value`、`v` の定義、`square_of_real_sum_is_at_most_twice_sum_of_squares`、`square_of_real_absolute_value` を 2 か所） | `hterm` の `calc` の 4 段 |
| 主張の 8 行の鎖 | 主定理の `calc` の 8 段 |

- 人手の `M_col` は Lean の `n + 1`、`ε_ℝ` は `epsilonReal n`、`ℝ^d` の元は `Conf (n + 1) → ℝ`、`‖·‖` は `vecNorm`（`def_matrix_norm` の `K = ℝ`）である。
- 人手の `def_matrix_norm` の `‖w‖ = √(Σ|w_k|^2)` は、Lean の `vecNorm w = √(w ⬝ᵥ w)` を `vecNormSq_eq_sum` で `√(Σ w_k^2)` に開き、
  `square_of_real_absolute_value` で `√(Σ|w_k|^2)` に書いたものである（`ClaimEpsilonRealPreservesNorm.lean` と同じ。そちらは同じ段を mathlib の `sq_abs` で埋めている）。
- 人手の `definition_of_sqrt_r_positive`（`√x` は `y ≥ 0, y^2 = x` を満たす `y`）は Lean では `Real.sqrt` で、その `y^2 = x` の行は `Real.sq_sqrt` である。
- 人手の和の添字は `{1, …, d}` で、Lean の和の添字は `Conf (n + 1)` である。有限和の段は添字が有限型の系
  `finite_sum_of_real_numbers_is_monotone_fintype`・`finite_sum_of_real_sums_fintype`・`finite_sum_of_real_scalar_multiples_fintype` で当てる。
- 人手は `ℝ^d` の元どうしの和を定めず、`v` を成分の等式 `v_k = u_k + (ε_ℝu)_k` で与える。Lean も同じく仮定 `hv` に置く
  （`epsilon_real_fixes_sum_of_vector_and_its_image` と同じ形）。

必要十分版は置かない。`ε_ℝ` は `epsilon_real_preserves_norm`（`‖ε_ℝu‖ = ‖u‖`）を通してだけ効き、スピン反転による置換であることは
効いていない。それを抜いた内容「`‖x‖ = ‖y‖ = 1` なら `‖x + y‖^2 ≤ 4`」は、`square_of_real_absolute_value`・
`square_of_real_sum_is_at_most_twice_sum_of_squares`（必要十分版は `NecSuf/SquareOfAbsoluteValueAndOfSum.lean`）と有限和の 3 つの主張を
成分ごとに当てることに尽き、それらの必要十分版の外に新しい抽象的な内容を持たない。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealPreservesNorm
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfNormalizedRealVectorIsOne
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum

namespace Ising2D

open Matrix

/-- **人手 `norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`**: `‖u‖ = 1` のとき、
すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `‖v‖^2 ≤ 4`（人手の `M_col` は `n + 1`。準備と 8 行の鎖と 1 対 1）。 -/
theorem norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four (n : ℕ)
    (u v : Conf (n + 1) → ℝ) (hu : vecNorm u = 1)
    (hv : ∀ k, v k = u k + (epsilonReal n *ᵥ u) k) :
    vecNorm v ^ 2 ≤ 4 := by
  have hterm : ∀ k, |v k| ^ 2 ≤ 2 * |u k| ^ 2 + 2 * |(epsilonReal n *ᵥ u) k| ^ 2 := by
    intro k
    calc |v k| ^ 2
        = v k ^ 2 := square_of_real_absolute_value (v k)            -- `square_of_real_absolute_value`（`q → v_k`）
      _ = (u k + (epsilonReal n *ᵥ u) k) ^ 2 := by rw [hv k]        -- `v` の定義
      _ ≤ 2 * u k ^ 2 + 2 * (epsilonReal n *ᵥ u) k ^ 2 :=
          square_of_real_sum_is_at_most_twice_sum_of_squares _ _    -- `square_of_real_sum_is_at_most_twice_sum_of_squares`（`a → u_k, b → (ε_ℝu)_k`）
      _ = 2 * |u k| ^ 2 + 2 * |(epsilonReal n *ᵥ u) k| ^ 2 := by
          rw [square_of_real_absolute_value, square_of_real_absolute_value]
                                                                    -- `square_of_real_absolute_value` を右辺から左辺へ 2 か所へ同時適用
  calc vecNorm v ^ 2
      = ∑ k, |v k| ^ 2 := vecNorm_sq_eq_sum_abs_sq v                -- 準備の `‖x‖^2 = Σ|x_k|^2`（`x → v`）
    _ ≤ ∑ k, (2 * |u k| ^ 2 + 2 * |(epsilonReal n *ᵥ u) k| ^ 2) :=
        finite_sum_of_real_numbers_is_monotone_fintype _ _ hterm    -- `finite_sum_of_real_numbers_is_monotone` と `|v_k|^2` の評価
    _ = (∑ k, 2 * |u k| ^ 2) + ∑ k, 2 * |(epsilonReal n *ᵥ u) k| ^ 2 :=
        finite_sum_of_real_sums_fintype _ _                         -- `finite_sum_of_real_sums`
    _ = 2 * ∑ k, |u k| ^ 2 + 2 * ∑ k, |(epsilonReal n *ᵥ u) k| ^ 2 := by
        rw [finite_sum_of_real_scalar_multiples_fintype, finite_sum_of_real_scalar_multiples_fintype]
                                                                    -- `finite_sum_of_real_scalar_multiples`（`c → 2`）を 2 か所へ同時適用
    _ = 2 * vecNorm u ^ 2 + 2 * vecNorm (epsilonReal n *ᵥ u) ^ 2 := by
        rw [vecNorm_sq_eq_sum_abs_sq u, vecNorm_sq_eq_sum_abs_sq (epsilonReal n *ᵥ u)]
                                                                    -- 準備の `‖x‖^2 = Σ|x_k|^2`（`x → u, ε_ℝu`）を右辺から左辺へ 2 か所へ
    _ = 2 * vecNorm u ^ 2 + 2 * vecNorm u ^ 2 := by
        rw [epsilon_real_preserves_norm]                            -- `epsilon_real_preserves_norm`（`u → u`）
    _ = 2 * 1 ^ 2 + 2 * 1 ^ 2 := by rw [hu]                         -- `‖u‖ = 1` を 2 か所へ同時適用
    _ = 4 := by norm_num                                            -- ℝ の四則演算

end Ising2D
