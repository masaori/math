/-
# 一つの添字を飛ばす写像とその性質（**必要十分版**）

対応する人手証明のラベル: `def_index_skipping_map`, `index_skipping_map_never_takes_skipped_index`,
`index_skipping_map_is_injective`, `index_skipping_map_reaches_every_other_index`
（具体版は `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionIndexSkippingMap.lean` と
同じフォルダの `ClaimIndexSkippingMapProperties.lean`）。
具体版の `skipIndex` とこのファイルの `skipIndex'` が同じ写像であることは
`DefinitionIndexSkippingMapFromNecSuf.lean`（具体版と同じフォルダ）が述べる。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `skipIndex`（場合分けの定義） | `skipIndex'`（同じ場合分け） | なし |
| `skipIndex_of_lt`・`skipIndex_of_le` | `skipIndex'_of_lt`・`skipIndex'_of_le` | なし |
| `skipIndex_ne` | `skipIndex'_ne`（同じ場合分けと鎖） | なし |
| `skipIndex_injective` | `skipIndex'_injective`（同じ場合分けと鎖） | なし |
| `skipIndex_reaches_every_other_index` | `skipIndex'_reaches_every_other_index`（同じ場合分けと鎖） | なし |

* 人手の添字 `{1, …, m}` と Lean の 0 始まりの `Fin m` の対応、人手の `m ≥ 1` を Lean の `n + 1` で立てることは、
  具体版の `DefinitionIndexSkippingMap.lean`・`ClaimIndexSkippingMapProperties.lean` の注と同じである。
* 添字の集合 `{1, …, m}` の上の写像とその性質だけで、係数の環も値の構造も現れない。削れる仮定が無いので、
  主張と証明は具体版と同じである。
* このファイルを置くのは、添字を飛ばす写像を使う必要十分版（`FiniteSumMovesOneTermToEnd.lean`・
  `BijectionComposedWithIndexSkippingMap.lean`・`FiniteSumReindexedByBijection.lean`）が、具体版の定義と定理を
  参照せずに済むようにするためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。
-/
import Mathlib.Order.Basic
import Mathlib.Data.Fin.Basic

namespace Ising2D.NecSuf

/-- `def_index_skipping_map`: `δ^{m}_{k}(j) := j (j < k)、j + 1 (j ≥ k)`（具体版 `skipIndex` と同じ場合分け）。 -/
def skipIndex' {m : ℕ} (k : Fin (m + 1)) (j : Fin m) : Fin (m + 1) :=
  if j.val < k.val then j.castSucc else j.succ

/-- `def_index_skipping_map` の `j < k` の場合: `δ^{m}_{k}(j) = j`。 -/
theorem skipIndex'_of_lt {m : ℕ} (k : Fin (m + 1)) (j : Fin m) (h : j.val < k.val) :
    skipIndex' k j = j.castSucc := by
  unfold skipIndex'
  rw [if_pos h]

/-- `def_index_skipping_map` の `j ≥ k` の場合: `δ^{m}_{k}(j) = j + 1`。 -/
theorem skipIndex'_of_le {m : ℕ} (k : Fin (m + 1)) (j : Fin m) (h : k.val ≤ j.val) :
    skipIndex' k j = j.succ := by
  unfold skipIndex'
  rw [if_neg (Nat.not_lt.mpr h)]

/-- `index_skipping_map_never_takes_skipped_index`（具体版 `skipIndex_ne`）: すべての `j` で `δ^{m}_{k}(j) ≠ k`。 -/
theorem skipIndex'_ne {n : ℕ} (k : Fin (n + 2)) (j : Fin (n + 1)) : skipIndex' k j ≠ k := by
  by_cases h : j.val < k.val
  · have hlt : (skipIndex' k j).val < k.val :=                                -- 人手の `j < k` の場合
      calc (skipIndex' k j).val
          = j.val := by rw [skipIndex'_of_lt k j h]; rfl                      -- `def_index_skipping_map`, `j < k`
        _ < k.val := h                                                        -- `j < k`
    exact fun heq => Nat.ne_of_lt hlt (congrArg Fin.val heq)
  · have hle : k.val ≤ j.val := Nat.le_of_not_lt h
    have hgt : (skipIndex' k j).val > k.val :=                                -- 人手の `j ≥ k` の場合
      calc (skipIndex' k j).val
          = j.val + 1 := by rw [skipIndex'_of_le k j hle]; rfl                -- `def_index_skipping_map`, `j ≥ k`
        _ > j.val := Nat.lt_succ_self _                                       -- `1 > 0`
        _ ≥ k.val := hle                                                      -- `j ≥ k`
    exact fun heq => Nat.ne_of_gt hgt (congrArg Fin.val heq)

/-- `index_skipping_map_is_injective`（具体版 `skipIndex_injective`）: `δ^{m}_{k}(j) = δ^{m}_{k}(j')` なら `j = j'`。 -/
theorem skipIndex'_injective {n : ℕ} (k : Fin (n + 2)) : Function.Injective (skipIndex' k) := by
  intro j j' hjj'
  by_cases h : j.val < k.val
  · by_cases h' : j'.val < k.val
    · apply Fin.ext                                                           -- 人手の `j < k` かつ `j' < k`
      calc j.val
          = (skipIndex' k j).val := by rw [skipIndex'_of_lt k j h]; rfl       -- `def_index_skipping_map` を右辺から左辺へ
        _ = (skipIndex' k j').val := by rw [hjj']                             -- 仮定
        _ = j'.val := by rw [skipIndex'_of_lt k j' h']; rfl                   -- `def_index_skipping_map`, `j' < k`
    · exfalso                                                                 -- 人手の `j < k ≤ j'`
      have hle' : k.val ≤ j'.val := Nat.le_of_not_lt h'
      have hlt : (skipIndex' k j).val < (skipIndex' k j').val :=
        calc (skipIndex' k j).val
            = j.val := by rw [skipIndex'_of_lt k j h]; rfl                    -- `def_index_skipping_map`, `j < k`
          _ < k.val := h                                                      -- `j < k`
          _ ≤ j'.val := hle'                                                  -- `k ≤ j'`
          _ < j'.val + 1 := Nat.lt_succ_self _                                -- `1 > 0`
          _ = (skipIndex' k j').val := by rw [skipIndex'_of_le k j' hle']; rfl -- `def_index_skipping_map` を右辺から左辺へ
      exact Nat.ne_of_lt hlt (congrArg Fin.val hjj')                          -- 仮定に反する
  · have hle : k.val ≤ j.val := Nat.le_of_not_lt h
    by_cases h' : j'.val < k.val
    · exfalso                                                                 -- 人手の `j' < k ≤ j`
      have hlt : (skipIndex' k j').val < (skipIndex' k j).val :=
        calc (skipIndex' k j').val
            = j'.val := by rw [skipIndex'_of_lt k j' h']; rfl                 -- `def_index_skipping_map`, `j' < k`
          _ < k.val := h'                                                     -- `j' < k`
          _ ≤ j.val := hle                                                    -- `k ≤ j`
          _ < j.val + 1 := Nat.lt_succ_self _                                 -- `1 > 0`
          _ = (skipIndex' k j).val := by rw [skipIndex'_of_le k j hle]; rfl   -- `def_index_skipping_map` を右辺から左辺へ
      exact Nat.ne_of_lt hlt (congrArg Fin.val hjj'.symm)                     -- 仮定に反する
    · have hle' : k.val ≤ j'.val := Nat.le_of_not_lt h'                       -- 人手の `j ≥ k` かつ `j' ≥ k`
      apply Fin.ext
      calc j.val
          = (j.val + 1) - 1 := (Nat.add_sub_cancel _ _).symm                  -- `1 - 1 = 0`
        _ = (skipIndex' k j).val - 1 := by rw [skipIndex'_of_le k j hle]; rfl -- `def_index_skipping_map` を右辺から左辺へ
        _ = (skipIndex' k j').val - 1 := by rw [hjj']                         -- 仮定
        _ = (j'.val + 1) - 1 := by rw [skipIndex'_of_le k j' hle']; rfl       -- `def_index_skipping_map`, `j' ≥ k`
        _ = j'.val := Nat.add_sub_cancel _ _                                  -- `1 - 1 = 0`

/-- `index_skipping_map_reaches_every_other_index`（具体版 `skipIndex_reaches_every_other_index`）:
`i ≠ k` なら `δ^{m}_{k}(j) = i` を満たす `j` がある。 -/
theorem skipIndex'_reaches_every_other_index {n : ℕ} (k : Fin (n + 2)) (i : Fin (n + 2)) (hik : i ≠ k) :
    ∃ j : Fin (n + 1), skipIndex' k j = i := by
  by_cases h : i.val < k.val
  · have him : i.val < n + 1 := Nat.lt_of_lt_of_le h (Nat.le_of_lt_succ k.isLt)  -- 人手の `i < k ≤ m+1` から `i ≤ m`
    let j : Fin (n + 1) := ⟨i.val, him⟩                                         -- `j := i`
    refine ⟨j, Fin.ext ?_⟩
    calc (skipIndex' k j).val
        = (skipIndex' k ⟨i.val, him⟩).val := rfl                              -- `j` の置き方
      _ = i.val := by rw [skipIndex'_of_lt k ⟨i.val, him⟩ h]; rfl             -- `def_index_skipping_map`, `i < k`
  · have hki : k.val < i.val :=                                               -- 人手の `i > k`（`i ≠ k` なので）
      Nat.lt_of_le_of_ne (Nat.le_of_not_lt h) (fun he => hik (Fin.ext he.symm))
    have hi1 : 1 ≤ i.val := Nat.lt_of_le_of_lt (Nat.zero_le _) hki           -- 人手の `i − 1 ≥ 1`（0 始まりでは `i ≥ 1`）
    have him : i.val - 1 < n + 1 := by                                        -- 人手の `i ≤ m+1` から `i − 1 ≤ m`
      have := i.isLt; omega
    have hkj : k.val ≤ i.val - 1 := by omega                                  -- 人手の `j = i − 1 ≥ k`
    let j : Fin (n + 1) := ⟨i.val - 1, him⟩                                     -- `j := i − 1`
    refine ⟨j, Fin.ext ?_⟩
    calc (skipIndex' k j).val
        = j.val + 1 := by rw [skipIndex'_of_le k j hkj]; rfl                  -- `def_index_skipping_map`, `j ≥ k`
      _ = (i.val - 1) + 1 := rfl                                              -- `j` の置き方
      _ = i.val := Nat.sub_add_cancel hi1                                     -- `-1 + 1 = 0`

end Ising2D.NecSuf
