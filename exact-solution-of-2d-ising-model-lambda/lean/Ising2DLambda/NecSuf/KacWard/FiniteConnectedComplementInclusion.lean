import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite binary region that is constant across every exterior step is
contained in a finite set whose exterior is connected. -/
theorem finiteRegion_subset_of_connected_complement
    {Cell : Type*} [DecidableEq Cell] [Infinite Cell]
    (source selected : Finset Cell) (step : Cell → Cell → Prop)
    (hconnected : ∀ p ∉ source, ∀ q ∉ source,
      Relation.ReflTransGen
        (fun a b => a ∉ source ∧ b ∉ source ∧ step a b) p q)
    (hconstant : ∀ p q, p ∉ source → q ∉ source → step p q →
      (p ∈ selected ↔ q ∈ selected)) :
    selected ⊆ source := by
  have hfree : ((Set.univ : Set Cell) \ ↑(source ∪ selected)).Nonempty :=
    ((Set.infinite_univ).sdiff (Finset.finite_toSet (source ∪ selected))).nonempty
  obtain ⟨q, hq⟩ := hfree
  have hqsource : q ∉ source := by
    intro h
    exact hq.2 (Finset.mem_coe.mpr (Finset.mem_union_left selected h))
  have hqselected : q ∉ selected := by
    intro h
    exact hq.2 (Finset.mem_coe.mpr (Finset.mem_union_right source h))
  intro p hp
  by_contra hpsource
  have hpath := hconnected p hpsource q hqsource
  have hconst : ∀ a b, Relation.ReflTransGen
      (fun x y => x ∉ source ∧ y ∉ source ∧ step x y) a b →
      (a ∈ selected ↔ b ∈ selected) := by
    intro a b hab
    induction hab with
    | refl => rfl
    | tail _ hstep ih =>
      exact ih.trans (hconstant _ _ hstep.1 hstep.2.1 hstep.2.2)
  exact hqselected ((hconst p q hpath).mp hp)

end Ising2DLambda.NecSuf.KacWard
