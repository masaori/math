/-
# 一つの添字を飛ばす写像とその性質（必要十分版からの導出）

具体版 `DefinitionIndexSkippingMap.lean` の `skipIndex` と、必要十分版 `Ising2D/NecSuf/IndexSkippingMap.lean` の
`NecSuf.skipIndex'` は同じ場合分けで定義した同じ写像である。人手のラベルは `def_index_skipping_map`。
具体版 `ClaimIndexSkippingMapProperties.lean` の三つの性質（人手 `index_skipping_map_never_takes_skipped_index`・
`index_skipping_map_is_injective`・`index_skipping_map_reaches_every_other_index`）を、この一致で必要十分版の性質から得る。
添字を飛ばす写像を使う必要十分版（`NecSuf.finite_sum_skip_index_succ'`・`NecSuf.compSkipIndex` など）から具体版を導く
導出のファイルは、この一致で具体版の `skipIndex` へ読み替える。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.DefinitionIndexSkippingMap
import Ising2D.NecSuf.IndexSkippingMap
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimIndexSkippingMapProperties

namespace Ising2D

/-- 具体版の `δ^{m}_{k}` は、必要十分版の `δ^{m}_{k}` と一致する（同じ場合分けの定義）。 -/
theorem skipIndex_eq_skipIndex_necSuf {m : ℕ} (k : Fin (m + 1)) (j : Fin m) :
    skipIndex k j = NecSuf.skipIndex' k j :=
  rfl

/-- `skipIndex_ne` を `NecSuf.skipIndex'_ne` の特殊化として得る。 -/
theorem skipIndex_ne_of_necSuf {n : ℕ} (k : Fin (n + 2)) (j : Fin (n + 1)) : skipIndex k j ≠ k := by
  rw [skipIndex_eq_skipIndex_necSuf]
  exact NecSuf.skipIndex'_ne k j

/-- `skipIndex_injective` を `NecSuf.skipIndex'_injective` の特殊化として得る。 -/
theorem skipIndex_injective_of_necSuf {n : ℕ} (k : Fin (n + 2)) : Function.Injective (skipIndex k) := by
  intro j j' h
  rw [skipIndex_eq_skipIndex_necSuf, skipIndex_eq_skipIndex_necSuf] at h
  exact NecSuf.skipIndex'_injective k h

/-- `skipIndex_reaches_every_other_index` を `NecSuf.skipIndex'_reaches_every_other_index` の特殊化として得る。 -/
theorem skipIndex_reaches_every_other_index_of_necSuf {n : ℕ} (k : Fin (n + 2)) (i : Fin (n + 2)) (hik : i ≠ k) :
    ∃ j : Fin (n + 1), skipIndex k j = i := by
  obtain ⟨j, hj⟩ := NecSuf.skipIndex'_reaches_every_other_index k i hik
  exact ⟨j, by rw [skipIndex_eq_skipIndex_necSuf]; exact hj⟩

end Ising2D
