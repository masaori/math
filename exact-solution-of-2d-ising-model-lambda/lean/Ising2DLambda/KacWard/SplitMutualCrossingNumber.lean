import Ising2DLambda.KacWard.SmoothedCrossingNumber
import Ising2DLambda.KacWard.SmoothingIndexBlocks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_split_mutual_crossing_number` for an actual closed nonbacktracking walk. -/
noncomputable def splitMutualCrossingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 ∈ smoothingIndexBlockA γ hγ k l ∧
      p.2 ∈ smoothingIndexBlockB γ hγ k l ∧
      orientedTarget (γ p.1) = orientedTarget (γ p.2) ∧
      stepTurning (γ p.1) (smoothedExitEdge γ k l p.1) = 0 ∧
      stepTurning (γ p.2) (smoothedExitEdge γ k l p.2) = 0 ∧
      directionAxis (directionNumber (γ p.1)) ≠
        directionAxis (directionNumber (γ p.2))).card

end Ising2DLambda.KacWard
