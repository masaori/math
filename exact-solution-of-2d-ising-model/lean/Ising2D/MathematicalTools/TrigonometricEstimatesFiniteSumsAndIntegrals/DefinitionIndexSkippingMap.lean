/-
# 一つの添字を飛ばす写像（**具体版**）

対応する人手証明のラベル: `def_index_skipping_map`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_definition_index_skipping_map`）。

## 人手証明との対応

* 人手の `δ^{m}_{k} : {1, …, m} → {1, …, m+1}`（`j < k` なら `j`、`j ≥ k` なら `j + 1`）を `skipIndex k : Fin m → Fin (m + 1)` で書く。
  人手の添字 `j ∈ {1, …, m}` は Lean の `Fin m` の `j - 1` である。人手の `j < k` は、両辺から 1 を引いた Lean の `j.val < k.val` に当たり、
  人手の値 `j` は `Fin.castSucc j`（`{1, …, m} ⊂ {1, …, m+1}` の包含）、`j + 1` は `Fin.succ j` に当たる。
* 人手の「値は `{1, …, m+1}` に入る」は、Lean では値の型が `Fin (m + 1)` であることで済む。
* 人手は `m ≥ 1` で定めるが、Lean の定義は `m = 0`（空の定義域）も含む。使う側の主張は人手と同じく `m ≥ 1`（Lean の `Fin (n + 1)`）で立てる。
* mathlib にも同じ写像 `Fin.succAbove` があるが、人手の場合分けの定義と 1 対 1 にするため、場合分けで定義し直した。
-/
import Mathlib.Data.Fin.Basic

namespace Ising2D

/-- **`def_index_skipping_map`**: `δ^{m}_{k}(j) := j (j < k)、j + 1 (j ≥ k)`。 -/
def skipIndex {m : ℕ} (k : Fin (m + 1)) (j : Fin m) : Fin (m + 1) :=
  if j.val < k.val then j.castSucc else j.succ

/-- `def_index_skipping_map` の `j < k` の場合: `δ^{m}_{k}(j) = j`。 -/
theorem skipIndex_of_lt {m : ℕ} (k : Fin (m + 1)) (j : Fin m) (h : j.val < k.val) :
    skipIndex k j = j.castSucc := by
  unfold skipIndex
  rw [if_pos h]

/-- `def_index_skipping_map` の `j ≥ k` の場合: `δ^{m}_{k}(j) = j + 1`。 -/
theorem skipIndex_of_le {m : ℕ} (k : Fin (m + 1)) (j : Fin m) (h : k.val ≤ j.val) :
    skipIndex k j = j.succ := by
  unfold skipIndex
  rw [if_neg (Nat.not_lt.mpr h)]

end Ising2D
