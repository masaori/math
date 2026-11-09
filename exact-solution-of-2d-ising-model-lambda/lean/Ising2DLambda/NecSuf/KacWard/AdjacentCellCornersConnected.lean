import Mathlib.Logic.Relation
import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- Two connected corner sets become connected when they share a corner. -/
theorem adjacentCornerSets_connected {α : Type*} [DecidableEq α]
    (A B : Finset α) (stepA stepB step : α → α → Prop)
    (hA : ∀ u ∈ A, ∀ v ∈ A, Relation.EqvGen stepA u v)
    (hB : ∀ u ∈ B, ∀ v ∈ B, Relation.EqvGen stepB u v)
    (hstepA : ∀ ⦃u v⦄, stepA u v → step u v)
    (hstepB : ∀ ⦃u v⦄, stepB u v → step u v)
    (w : α) (hwA : w ∈ A) (hwB : w ∈ B) :
    ∀ u ∈ A ∪ B, ∀ v ∈ A ∪ B, Relation.EqvGen step u v := by
  have hA' : ∀ u ∈ A, Relation.EqvGen step u w := by
    intro u hu
    exact (hA u hu w hwA).mono (fun _ _ h => hstepA h)
  have hB' : ∀ u ∈ B, Relation.EqvGen step w u := by
    intro u hu
    exact (hB w hwB u hu).mono (fun _ _ h => hstepB h)
  intro u hu v hv
  rcases Finset.mem_union.mp hu with huA | huB
  · rcases Finset.mem_union.mp hv with hvA | hvB
    · exact (hA u huA v hvA).mono (fun _ _ h => hstepA h)
    · exact Relation.EqvGen.trans _ _ _ (hA' u huA) (hB' v hvB)
  · rcases Finset.mem_union.mp hv with hvA | hvB
    · exact Relation.EqvGen.trans _ _ _
        (Relation.EqvGen.symm _ _ (hB' u huB))
        (Relation.EqvGen.symm _ _ (hA' v hvA))
    · exact (hB u huB v hvB).mono (fun _ _ h => hstepB h)

end Ising2DLambda.NecSuf.KacWard
