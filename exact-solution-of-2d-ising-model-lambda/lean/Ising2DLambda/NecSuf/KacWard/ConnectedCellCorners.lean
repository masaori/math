import Mathlib.Logic.Relation
import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- A chain of adjacent connected cells joins all corners of its endpoint cells. -/
theorem connectedCellCorners_connected {C V : Type*} [DecidableEq V]
    (S : Set C) (corners : C → Finset V) (adjacent : C → C → Prop)
    (step : V → V → Prop)
    (hcell : ∀ p ∈ S, ∀ u ∈ corners p, ∀ v ∈ corners p,
      Relation.EqvGen step u v)
    (hadj : ∀ p ∈ S, ∀ q ∈ S, adjacent p q →
      ∀ u ∈ corners p, ∀ v ∈ corners q, Relation.EqvGen step u v)
    (hne : ∀ p ∈ S, (corners p).Nonempty)
    {p q : C}
    (hpath : Relation.ReflTransGen
      (fun a b => a ∈ S ∧ b ∈ S ∧ adjacent a b) p q)
    (hp : p ∈ S) :
    ∀ u ∈ corners p, ∀ v ∈ corners q, Relation.EqvGen step u v := by
  induction hpath with
  | refl =>
      exact hcell p hp
  | @tail b c hab hbc ih =>
      obtain ⟨hb, hc, hbcAdj⟩ := hbc
      obtain ⟨w, hw⟩ := hne b hb
      intro u hu v hv
      exact Relation.EqvGen.trans _ _ _ (ih u hu w hw)
        (hadj b hb c hc hbcAdj w hw v hv)

end Ising2DLambda.NecSuf.KacWard
