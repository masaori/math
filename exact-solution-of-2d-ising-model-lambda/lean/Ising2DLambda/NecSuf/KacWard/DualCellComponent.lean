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

end Ising2DLambda.NecSuf.KacWard
