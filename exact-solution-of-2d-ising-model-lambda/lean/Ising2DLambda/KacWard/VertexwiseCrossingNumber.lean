import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.IndexPairCrossing

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_vertexwise_crossing_number` for an actual closed nonbacktracking walk. -/
noncomputable def vertexwiseCrossingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ indexPairCrossing γ hγ p.1 p.2 ∧
      closedWalkPassVertex γ hγ p.1 = v).card

end Ising2DLambda.KacWard
