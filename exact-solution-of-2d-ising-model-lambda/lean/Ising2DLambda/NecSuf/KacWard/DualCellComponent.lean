import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Finite reachability uses only a relation on cells, not a torus embedding. -/
noncomputable def reachableComponent {C : Type*} [Fintype C]
    (step : C → C → Prop) (root : C) : Finset C := by
  classical
  exact Finset.univ.filter (Relation.ReflTransGen step root)

theorem reachableComponent_closed {C : Type*} [Fintype C]
    (step : C → C → Prop) (root p q : C)
    (hp : p ∈ reachableComponent step root) (hstep : step p q) :
    q ∈ reachableComponent step root := by
  classical
  simp only [reachableComponent, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
  exact Relation.ReflTransGen.tail hp hstep

theorem reachableComponent_subset_of_closed_side {C : Type*} [Fintype C]
    (step : C → C → Prop) (root : C) (side : Finset C)
    (hroot : root ∈ side)
    (hclosed : ∀ p q, p ∈ side → step p q → q ∈ side) :
    reachableComponent step root ⊆ side := by
  classical
  intro q hq
  simp only [reachableComponent, Finset.mem_filter, Finset.mem_univ, true_and] at hq
  induction hq with
  | refl => exact hroot
  | @tail b c _ hstep ih => exact hclosed b c ih hstep

theorem reachableComponent_ne_univ_of_closed_side {C : Type*} [Fintype C]
    (step : C → C → Prop) (root outside : C) (side : Finset C)
    (hroot : root ∈ side) (houtside : outside ∉ side)
    (hclosed : ∀ p q, p ∈ side → step p q → q ∈ side) :
    reachableComponent step root ≠ Finset.univ := by
  intro hfull
  have hsubset := reachableComponent_subset_of_closed_side step root side hroot hclosed
  exact houtside (hsubset (by rw [hfull]; simp))

end Ising2DLambda.NecSuf.KacWard
