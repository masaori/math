import Ising2DLambda.KacWard.TaggedDifferenceTwoStepOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation

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

theorem taggedActive_orbits_disjoint {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    Disjoint (finitePermutationOrbit (taggedActiveTwoStep D t) i)
      (finitePermutationOrbit (taggedActiveTwoStep D t)
        (taggedActiveShortMate D t i)) := by
  let τ := shortInvolution D t
  let υ := longInvolution D t
  have hstep : matchingPairStep τ υ = taggedActiveTwoStep D t := by
    apply Equiv.ext
    intro j
    rfl
  have hmate : τ.val i = taggedActiveShortMate D t i := rfl
  simpa only [hstep, hmate] using matchingPairStep_orbits_disjoint τ υ i

end Ising2DLambda.KacWard
