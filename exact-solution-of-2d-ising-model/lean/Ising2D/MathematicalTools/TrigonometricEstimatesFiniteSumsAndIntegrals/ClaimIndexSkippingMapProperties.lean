/-
# 一つの添字を飛ばす写像の性質（**具体版**）

対応する人手証明のラベル: `index_skipping_map_never_takes_skipped_index`, `index_skipping_map_is_injective`,
`index_skipping_map_reaches_every_other_index`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_claim_index_skipping_map_never_takes_skipped_index`, `calc_formulae_claim_index_skipping_map_is_injective`,
`calc_formulae_claim_index_skipping_map_reaches_every_other_index`）。

## 人手証明との対応

* 人手の `δ^{m}_{k}` は `skipIndex k`（`DefinitionIndexSkippingMap.lean`）。人手の添字 `j ∈ {1, …, m}` は Lean の `Fin (n + 1)`（人手の `m` が `n + 1`）の `j - 1` なので、
  人手の大小 `j < k`・`j ≥ k` は Lean の `j.val < k.val`・`k.val ≤ j.val` に、人手の値の比較は `Fin` の値 `.val` の比較に当たる。
* 各主張の場合分けを `by_cases` に、各場合の鎖を人手の行と 1 対 1 の `calc` にした。人手の「`≠`」「仮定に反する」の結び（鎖の後の 1 文）は
  `calc` の後の 1 行（`Nat.ne_of_lt` などと `Fin.ext`）である。
* `index_skipping_map_reaches_every_other_index` の `i > k` の場合の `j := i − 1` は、Lean では `⟨i.val − 1, _⟩ : Fin (n + 1)`。
  人手の `i − 1 ≥ 1` は、Lean では 0 始まりなので `i.val ≥ 1`（`i.val > k.val ≥ 0` から）に当たり、`(i.val − 1) + 1 = i.val` の段で使う。
* 人手の `m ≥ 1` は、`DefinitionIndexSkippingMap.lean` の約束どおり Lean の `n + 1`（`k : Fin (n + 2)`、`j : Fin (n + 1)`）で立てる。
* 添字の集合の上の写像の性質だけで、係数の環を持たないので、必要十分版は置かない（仮定に削れる構造が無い）。
-/
import Mathlib.Order.Basic
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionIndexSkippingMap

namespace Ising2D

/-- **`index_skipping_map_never_takes_skipped_index`**: すべての `j` で `δ^{m}_{k}(j) ≠ k`。 -/
theorem skipIndex_ne {n : ℕ} (k : Fin (n + 2)) (j : Fin (n + 1)) : skipIndex k j ≠ k := by
  by_cases h : j.val < k.val
  · have hlt : (skipIndex k j).val < k.val :=                                 -- 人手の `j < k` の場合
      calc (skipIndex k j).val
          = j.val := by rw [skipIndex_of_lt k j h]; rfl                       -- `def_index_skipping_map`, `j < k`
        _ < k.val := h                                                        -- `j < k`
    exact fun heq => Nat.ne_of_lt hlt (congrArg Fin.val heq)
  · have hle : k.val ≤ j.val := Nat.le_of_not_lt h
    have hgt : (skipIndex k j).val > k.val :=                                 -- 人手の `j ≥ k` の場合
      calc (skipIndex k j).val
          = j.val + 1 := by rw [skipIndex_of_le k j hle]; rfl                 -- `def_index_skipping_map`, `j ≥ k`
        _ > j.val := Nat.lt_succ_self _                                       -- `1 > 0`
        _ ≥ k.val := hle                                                      -- `j ≥ k`
    exact fun heq => Nat.ne_of_gt hgt (congrArg Fin.val heq)

/-- **`index_skipping_map_is_injective`**: `δ^{m}_{k}(j) = δ^{m}_{k}(j')` なら `j = j'`。 -/
theorem skipIndex_injective {n : ℕ} (k : Fin (n + 2)) : Function.Injective (skipIndex k) := by
  intro j j' hjj'
  by_cases h : j.val < k.val
  · by_cases h' : j'.val < k.val
    · apply Fin.ext                                                           -- 人手の `j < k` かつ `j' < k`
      calc j.val
          = (skipIndex k j).val := by rw [skipIndex_of_lt k j h]; rfl         -- `def_index_skipping_map` を右辺から左辺へ
        _ = (skipIndex k j').val := by rw [hjj']                              -- 仮定
        _ = j'.val := by rw [skipIndex_of_lt k j' h']; rfl                    -- `def_index_skipping_map`, `j' < k`
    · exfalso                                                                 -- 人手の `j < k ≤ j'`
      have hle' : k.val ≤ j'.val := Nat.le_of_not_lt h'
      have hlt : (skipIndex k j).val < (skipIndex k j').val :=
        calc (skipIndex k j).val
            = j.val := by rw [skipIndex_of_lt k j h]; rfl                     -- `def_index_skipping_map`, `j < k`
          _ < k.val := h                                                      -- `j < k`
          _ ≤ j'.val := hle'                                                  -- `k ≤ j'`
          _ < j'.val + 1 := Nat.lt_succ_self _                                -- `1 > 0`
          _ = (skipIndex k j').val := by rw [skipIndex_of_le k j' hle']; rfl  -- `def_index_skipping_map` を右辺から左辺へ
      exact Nat.ne_of_lt hlt (congrArg Fin.val hjj')                          -- 仮定に反する
  · have hle : k.val ≤ j.val := Nat.le_of_not_lt h
    by_cases h' : j'.val < k.val
    · exfalso                                                                 -- 人手の `j' < k ≤ j`
      have hlt : (skipIndex k j').val < (skipIndex k j).val :=
        calc (skipIndex k j').val
            = j'.val := by rw [skipIndex_of_lt k j' h']; rfl                  -- `def_index_skipping_map`, `j' < k`
          _ < k.val := h'                                                     -- `j' < k`
          _ ≤ j.val := hle                                                    -- `k ≤ j`
          _ < j.val + 1 := Nat.lt_succ_self _                                 -- `1 > 0`
          _ = (skipIndex k j).val := by rw [skipIndex_of_le k j hle]; rfl     -- `def_index_skipping_map` を右辺から左辺へ
      exact Nat.ne_of_lt hlt (congrArg Fin.val hjj'.symm)                     -- 仮定に反する
    · have hle' : k.val ≤ j'.val := Nat.le_of_not_lt h'                       -- 人手の `j ≥ k` かつ `j' ≥ k`
      apply Fin.ext
      calc j.val
          = (j.val + 1) - 1 := (Nat.add_sub_cancel _ _).symm                  -- `1 - 1 = 0`
        _ = (skipIndex k j).val - 1 := by rw [skipIndex_of_le k j hle]; rfl   -- `def_index_skipping_map` を右辺から左辺へ
        _ = (skipIndex k j').val - 1 := by rw [hjj']                          -- 仮定
        _ = (j'.val + 1) - 1 := by rw [skipIndex_of_le k j' hle']; rfl        -- `def_index_skipping_map`, `j' ≥ k`
        _ = j'.val := Nat.add_sub_cancel _ _                                  -- `1 - 1 = 0`

/-- **`index_skipping_map_reaches_every_other_index`**: `i ≠ k` なら `δ^{m}_{k}(j) = i` を満たす `j` がある。 -/
theorem skipIndex_reaches_every_other_index {n : ℕ} (k : Fin (n + 2)) (i : Fin (n + 2)) (hik : i ≠ k) :
    ∃ j : Fin (n + 1), skipIndex k j = i := by
  by_cases h : i.val < k.val
  · have him : i.val < n + 1 := Nat.lt_of_lt_of_le h (Nat.le_of_lt_succ k.isLt)  -- 人手の `i < k ≤ m+1` から `i ≤ m`
    let j : Fin (n + 1) := ⟨i.val, him⟩                                             -- `j := i`
    refine ⟨j, Fin.ext ?_⟩
    calc (skipIndex k j).val
        = (skipIndex k ⟨i.val, him⟩).val := rfl                               -- `j` の置き方
      _ = i.val := by rw [skipIndex_of_lt k ⟨i.val, him⟩ h]; rfl              -- `def_index_skipping_map`, `i < k`
  · have hki : k.val < i.val :=                                               -- 人手の `i > k`（`i ≠ k` なので）
      Nat.lt_of_le_of_ne (Nat.le_of_not_lt h) (fun he => hik (Fin.ext he.symm))
    have hi1 : 1 ≤ i.val := Nat.lt_of_le_of_lt (Nat.zero_le _) hki           -- 人手の `i − 1 ≥ 1`（0 始まりでは `i ≥ 1`）
    have him : i.val - 1 < n + 1 := by                                            -- 人手の `i ≤ m+1` から `i − 1 ≤ m`
      have := i.isLt; omega
    have hkj : k.val ≤ i.val - 1 := by omega                                  -- 人手の `j = i − 1 ≥ k`
    let j : Fin (n + 1) := ⟨i.val - 1, him⟩                                         -- `j := i − 1`
    refine ⟨j, Fin.ext ?_⟩
    calc (skipIndex k j).val
        = j.val + 1 := by rw [skipIndex_of_le k j hkj]; rfl                   -- `def_index_skipping_map`, `j ≥ k`
      _ = (i.val - 1) + 1 := rfl                                              -- `j` の置き方
      _ = i.val := Nat.sub_add_cancel hi1                                     -- `-1 + 1 = 0`

end Ising2D
