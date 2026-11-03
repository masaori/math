import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.NecSuf.KacWard.IndexPairCrossing

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of crossing index pairs whose first pass has vertex `v`. -/
noncomputable def vertexwiseCrossingNumber {E V : Type*} {m : ℕ}
    (cross : E → E → E → E → Prop) (vertex : E → V)
    (γ : Fin (m + 1) → E) (v : V) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ indexPairCrossing cross γ p.1 p.2 ∧ vertex (γ p.1) = v).card

end Ising2DLambda.NecSuf.KacWard
