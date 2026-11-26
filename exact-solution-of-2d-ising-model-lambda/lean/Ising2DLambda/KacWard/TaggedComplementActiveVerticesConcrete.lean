import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The actual tagged pair at an oriented edge is compared with its reference
    reversal pair. The Bool label remains distinct when the two supports agree. -/
noncomputable def taggedActiveByLabels {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Set (OrientedEdge L) :=
  {e | (({e, perfectMatchingMate D e},
      decide (({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈
        shortUnderlyingPairs t)) : Set (OrientedEdge L) × Bool) ≠
      (({e, reversal e}, false) : Set (OrientedEdge L) × Bool)}

end Ising2DLambda.KacWard
