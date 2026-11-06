/-
# `u_k ≥ 0 (∀k)` なら `(ε_ℝu)_k ≥ 0 (∀k)`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_epsilon_real_preserves_nonnegative_vectors`（ラベル **`epsilon_real_preserves_nonnegative_vectors`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `row_configuration_numbering_bijective` で `k = ord(s)` を満たす `s ∈ 𝔐` を取る | `(configBasisIso _).surjective k` |
| 準備: `-s ∈ 𝔐`（`def_negated_row_configuration`）と `ord(-s) ∈ {1,…,d}` | `negSpinConf s` と添字 `configBasisIso _ (negSpinConf s) : Conf (n + 1)`（型が値域を持つので段は無い） |
| 鎖の 1 行目 `(ε_ℝu)_k = (ε_ℝu)_{ord(s)}`（`k = ord(s)`） | `obtain ⟨s, rfl⟩` で `k` を `ord(s)` に置いた後の `show`（段は無い） |
| 鎖の 2 行目 `= u_{ord(-s)}`（`epsilon_real_permutes_entries_by_spin_flip`） | `calc` の 1 段目 |
| 鎖の 3 行目 `≥ 0`（仮定の `k → ord(-s)`） | `calc` の 2 段目 |

- 人手の `ord(s)` で番号を付けた成分は、Lean では添字 `configBasisIso M s : Conf M` そのものである
  （`ClaimEpsilonRealPermutesEntriesBySpinFlip.lean` 冒頭と同じ扱い）。人手の `M_col` は `n + 1`、`ε_ℝ` は `epsilonReal n` である。
- 本文に実数のベクトルの順序 `u ≥ 0` を定めるブロックが無いので、人手も Lean も成分ごとに述べる。

必要十分版は置かない。主張は `epsilon_real_permutes_entries_by_spin_flip` と番号付けの全射性を 1 回ずつ当てることに尽きる
（置換行列の一般の性質は `Ising2D/NecSuf/PermMatrix.lean` にある）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealPermutesEntriesBySpinFlip

namespace Ising2D

open Matrix

/-- **人手 `epsilon_real_preserves_nonnegative_vectors`**: すべての `k` で `u_k ≥ 0` なら、すべての `k` で `(ε_ℝu)_k ≥ 0`
（人手の `M_col` は `n + 1`）。 -/
theorem epsilon_real_preserves_nonnegative_vectors (n : ℕ) (u : Conf (n + 1) → ℝ)
    (hu : ∀ k, 0 ≤ u k) : ∀ k, 0 ≤ (epsilonReal n *ᵥ u) k := by
  intro k
  obtain ⟨s, rfl⟩ := (configBasisIso (n + 1)).surjective k        -- `row_configuration_numbering_bijective`（`k = ord(s)`）
  show (epsilonReal n *ᵥ u) (configBasisIso (n + 1) s) ≥ 0         -- 人手の鎖の 1 行目 `(ε_ℝu)_k = (ε_ℝu)_{ord(s)}`（`k = ord(s)`）
  calc (epsilonReal n *ᵥ u) (configBasisIso (n + 1) s)
      = u (configBasisIso (n + 1) (negSpinConf s)) :=
        epsilon_real_permutes_entries_by_spin_flip n u s            -- `epsilon_real_permutes_entries_by_spin_flip`（`u → u`, `s → s`）
    _ ≥ 0 := hu _                                                   -- 仮定の `u_k ≥ 0`（`k → ord(-s)`）

end Ising2D
