/- 必要十分版の活動点の上の二つの固定点の無い対合を置く導出。具体版は
   concreteShortInvolution・concreteLongInvolution である。 -/
import Ising2DLambda.KacWard.TaggedDifferenceOrbitSeparation
import Ising2DLambda.KacWard.TaggedDifferenceTwoStepOrbitFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

noncomputable def shortInvolution {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    FixedPointFreeInvolution {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)} :=
  ⟨taggedActiveShortMate D t,
    (fun i h => perfectMatchingMate_ne D i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive D i.1))⟩

noncomputable def longInvolution {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    FixedPointFreeInvolution {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)} :=
  ⟨taggedActiveLongMate D t,
    (fun i h => perfectMatchingMate_ne
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i.1))⟩

end Ising2DLambda.KacWard
