import Mathlib.Logic.Relation
import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- Three edges from one corner suffice to connect all four corners. -/
theorem fourCorners_connected {α : Type*} [DecidableEq α]
    (a b c d : α) (step : α → α → Prop)
    (hab : step a b) (hac : step a c) (hbd : step b d) :
    ∀ u ∈ ({a, b, c, d} : Finset α),
      ∀ v ∈ ({a, b, c, d} : Finset α), Relation.EqvGen step u v := by
  have hbase : ∀ u ∈ ({a, b, c, d} : Finset α), Relation.EqvGen step a u := by
    intro u hu
    simp only [Finset.mem_insert, Finset.mem_singleton] at hu
    rcases hu with rfl | rfl | rfl | rfl
    · exact Relation.EqvGen.refl _
    · exact Relation.EqvGen.rel _ _ hab
    · exact Relation.EqvGen.rel _ _ hac
    · exact Relation.EqvGen.trans _ _ _
        (Relation.EqvGen.rel _ _ hab) (Relation.EqvGen.rel _ _ hbd)
  intro u hu v hv
  exact Relation.EqvGen.trans _ _ _
    (Relation.EqvGen.symm _ _ (hbase u hu)) (hbase v hv)

end Ising2DLambda.NecSuf.KacWard
