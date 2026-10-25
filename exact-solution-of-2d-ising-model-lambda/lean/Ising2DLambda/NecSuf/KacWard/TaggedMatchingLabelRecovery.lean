import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A disjoint cover of pairs determines a tag from the selected endpoints,
    even if two different contributions can use the same underlying pair. -/
theorem labels_eq_filter_of_endpoint_cover {J : Type*} [DecidableEq J]
    (pairs tagged : Finset (J × J)) (selected : J → Prop)
    [DecidablePred selected]
    (htagged : tagged ⊆ pairs)
    (hdisjoint : ∀ p ∈ pairs, ∀ q ∈ pairs,
      ∀ x, x ∈ [p.1, p.2] → x ∈ [q.1, q.2] → p = q)
    (hselected : ∀ x, selected x ↔ ∃ p ∈ tagged, x = p.1 ∨ x = p.2) :
    tagged = pairs.filter (fun p => selected p.1) := by
  classical
  ext p
  constructor
  · intro hp
    exact Finset.mem_filter.mpr ⟨htagged hp,
      (hselected p.1).2 ⟨p, hp, Or.inl rfl⟩⟩
  · intro hp
    obtain ⟨q, hq, hx⟩ := (hselected p.1).1 (Finset.mem_filter.mp hp).2
    have hpq := hdisjoint p (Finset.mem_filter.mp hp).1 q (htagged hq)
      p.1 (by simp) (by simpa using hx)
    exact hpq ▸ hq

end Ising2DLambda.NecSuf.KacWard
