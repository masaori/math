/-
# 最後の添字へ送られる添字を飛ばしてから全単射で送る写像（必要十分版からの導出）

具体版 `ClaimBijectionComposedWithIndexSkippingMap.lean` の主張を、必要十分版
`Ising2D/NecSuf/BijectionComposedWithIndexSkippingMap.lean` の特殊化として得る。人手のラベルは
`bijection_composed_with_index_skipping_map_stays_in_lower_indices`, `def_bijection_composed_with_index_skipping_map`,
`bijection_composed_with_index_skipping_map_is_bijective`。人手証明と 1 対 1 に対応する形は具体版のほうである。
特殊化は、全単射の仮定 `hπ` から単射の部分 `hπ.1` を取り出して必要十分版へ渡すことである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimBijectionComposedWithIndexSkippingMap
import Ising2D.NecSuf.BijectionComposedWithIndexSkippingMap

namespace Ising2D

/-- `bijection_comp_skipIndex_ne_last` を `NecSuf.comp_skipIndex_ne_last`（`hπ.1` だけを渡す）の特殊化として得る。 -/
theorem bijection_comp_skipIndex_ne_last_of_necSuf {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) :
    π (skipIndex k j) ≠ Fin.last (n + 1) :=
  NecSuf.comp_skipIndex_ne_last π hπ.1 k hk j

/-- 具体版の `τ^{π}_{k}` は、必要十分版の `τ^{π}_{k}` に `hπ.1` を渡したものと一致する。 -/
theorem bijectionCompSkipIndex_eq_necSuf {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) :
    bijectionCompSkipIndex π hπ k hk = NecSuf.compSkipIndex π hπ.1 k hk :=
  rfl

/-- `bijectionCompSkipIndex_bijective` を `NecSuf.compSkipIndex_bijective` の特殊化として得る。 -/
theorem bijectionCompSkipIndex_bijective_of_necSuf {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) :
    Function.Bijective (bijectionCompSkipIndex π hπ k hk) := by
  rw [bijectionCompSkipIndex_eq_necSuf]
  exact NecSuf.compSkipIndex_bijective π hπ k hk

end Ising2D
