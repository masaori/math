import Ising2DLambda.KacWard.ClosedWalkCrossingNumber
import Ising2DLambda.NecSuf.KacWard.ContactPairCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_contact_pair_count` for an actual closed nonbacktracking walk. -/
noncomputable def contactPairCount {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    0 < p.1 ∧ p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)).card

theorem contactPairCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    contactPairCount γ hγ =
      Ising2DLambda.NecSuf.KacWard.contactPairCount γ orientedTarget := by
  classical
  simp only [contactPairCount, Ising2DLambda.NecSuf.KacWard.contactPairCount]
  congr 1
  ext p
  simp

end Ising2DLambda.KacWard
