/- 具体版の標識付き対称差に接する対の判定が、必要十分版の標識付き辺の特殊化であることの導出。 -/
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
  simpa [concreteTaggedDifference, concreteTaggedPairs,
    concreteReferenceTaggedPairs, concreteTaggedPairAt,
    Ising2DLambda.NecSuf.KacWard.taggedEdges,
    Ising2DLambda.NecSuf.KacWard.taggedPairAt, shortUnderlyingPairs_empty] using
    taggedDifference_incident_iff D t e q

end Ising2DLambda.KacWard
