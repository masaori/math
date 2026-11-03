import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.NecSuf.KacWard.ClosedWalkPasses

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of cyclic passes through `v` that go straight along axis `a`. -/
noncomputable def vertexAxisStraightVisitCount {E V A : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V)
    (straight : E → E → Prop) (axis : E → A) (v : V) (a : A) : ℕ := by
  classical
  exact (Finset.univ.filter fun k : Fin (m + 1) =>
    target (γ k) = v ∧ straight (γ k) (γ (cyclicSuccessor k)) ∧
      axis (γ k) = a).card

end Ising2DLambda.NecSuf.KacWard
