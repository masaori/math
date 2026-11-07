/-
# 成分が非負で 0 でない `u` について、成分が `u_k + (ε_ℝu)_k` のベクトルは 0 でない

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`
  （ラベル **`sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `u ≠ 0` なので `u_{k_0} ≠ 0` を満たす `k_0` が在る（`x = 0` は「すべての `k` で `x_k = 0`」） | `obtain ⟨k₀, hk₀⟩`（否定を取ると `funext` で `u = 0` になり仮定と矛盾） |
| 準備: `u_{k_0} ≥ 0` と `u_{k_0} ≠ 0` より `u_{k_0} > 0` | `hpos` |
| 準備: `epsilon_real_preserves_nonnegative_vectors`（`u → u`, `k → k_0`）より `(ε_ℝu)_{k_0} ≥ 0` | `heps` |
| 鎖の 4 行 `v_{k_0} = u_{k_0} + (ε_ℝu)_{k_0} ≥ u_{k_0} + 0 = u_{k_0} > 0` | `hvk` の `calc` の 4 段 |
| 結び（`v_{k_0} ≠ 0` なので、すべての `k` で `v_k = 0` ではなく `v ≠ 0`） | 最後の 2 行（`v = 0` なら `v_{k_0} = 0`） |

- 人手の `M_col` は Lean の `n + 1`、`ε_ℝ` は `epsilonReal n`、`ℝ^d` の元は `Conf (n + 1) → ℝ` で、
  `x = 0` は関数の零（`funext` で「すべての `k` で `x_k = 0`」と行き来する）である。
- 人手は `ℝ^d` の元どうしの和を定めず、`v` を成分の等式 `v_k = u_k + (ε_ℝu)_k` で与える。Lean も同じく仮定 `hv` に置く
  （`epsilon_real_fixes_sum_of_vector_and_its_image` と同じ形。引く側で `v := u + ε_ℝ *ᵥ u` なら `hv := fun _ => rfl`）。

必要十分版は置かない。証明は `epsilon_real_preserves_nonnegative_vectors` を 1 回当てたうえで、ℝ の順序と加法の両立・
加法の単位元を 1 回ずつ使うことに尽き、それらの外に抽象的な内容を持たない（`epsilon_real_preserves_nonnegative_vectors` と同じ判断）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealPreservesNonnegativeVectors

namespace Ising2D

open Matrix

/-- **人手 `sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`**: すべての `k` で `u_k ≥ 0`、かつ `u ≠ 0` のとき、
すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `v ≠ 0`（人手の `M_col` は `n + 1`。準備と 4 行の鎖と 1 対 1）。 -/
theorem sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero (n : ℕ) (u v : Conf (n + 1) → ℝ)
    (hu : ∀ k, 0 ≤ u k) (hu0 : u ≠ 0)
    (hv : ∀ k, v k = u k + (epsilonReal n *ᵥ u) k) :
    v ≠ 0 := by
  obtain ⟨k₀, hk₀⟩ : ∃ k₀, u k₀ ≠ 0 := by                          -- `u ≠ 0` なので `u_{k_0} ≠ 0` を満たす `k_0` が在る
    by_contra h
    exact hu0 (funext fun k => not_not.mp fun hk => h ⟨k, hk⟩)
  have hpos : u k₀ > 0 := lt_of_le_of_ne (hu k₀) (Ne.symm hk₀)       -- `u_{k_0} ≥ 0` と `u_{k_0} ≠ 0` より `u_{k_0} > 0`
  have heps : (epsilonReal n *ᵥ u) k₀ ≥ 0 :=
    epsilon_real_preserves_nonnegative_vectors n u hu k₀              -- `epsilon_real_preserves_nonnegative_vectors`（`u → u`, `k → k_0`）
  have hvk : v k₀ > 0 :=
    calc v k₀
        = u k₀ + (epsilonReal n *ᵥ u) k₀ := hv k₀                     -- `v` の定義（`k → k_0`）
      _ ≥ u k₀ + 0 := add_le_add (le_refl (u k₀)) heps               -- `(ε_ℝu)_{k_0} ≥ 0` と ℝ の順序と加法の両立
      _ = u k₀ := add_zero _                                          -- `0` は ℝ の加法の単位元
      _ > 0 := hpos                                                   -- `u_{k_0} > 0`
  intro hv0                                                           -- 結び: `v = 0` なら `v_{k_0} = 0` で `v_{k_0} > 0` と矛盾
  exact (ne_of_gt hvk) (congrFun hv0 k₀)

end Ising2D
