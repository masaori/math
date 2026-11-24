/- 向き付き辺の集合へ必要十分版の標識付き対の入射判定を適用する。 -/
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree
import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

theorem taggedDifference_incident_iff_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (e : OrientedEdge L) (q : Set (OrientedEdge L) × Bool) :
    let R : PerfectMatching (OrientedEdge L) :=
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (q ∈ (Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
      Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅) ∧ e ∈ q.1) ↔
      let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D
        (shortUnderlyingPairs t) e
      let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ e
      d ≠ r ∧ (q = d ∨ q = r) := by
  exact Ising2DLambda.NecSuf.KacWard.taggedDifference_incident_iff
    D ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (shortUnderlyingPairs t) e q

end Ising2DLambda.KacWard
