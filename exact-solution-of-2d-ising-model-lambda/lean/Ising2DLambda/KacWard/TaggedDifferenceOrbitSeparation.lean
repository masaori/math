import Ising2DLambda.KacWard.TaggedDifferenceTwoStepOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation

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

/-- The short mate restricted to the active edges of the concrete tagged difference. -/
noncomputable def concreteShortInvolution {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
  ⟨taggedConcreteShortMate D t,
    (fun i h => perfectMatchingMate_ne D i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive D i.1))⟩

/-- The reference mate restricted to the same concretely active edges. -/
noncomputable def concreteLongInvolution {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
  ⟨taggedConcreteLongMate D t,
    (fun i h => perfectMatchingMate_ne
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i.1))⟩

/-- The two-step permutation used by the concrete alternating components. -/
theorem concreteMatchingPairStep_eq_twoStep {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    matchingPairStep (concreteShortInvolution D t) (concreteLongInvolution D t) =
      taggedConcreteTwoStep D t := by
  apply Equiv.ext
  intro i
  rfl

/-- The concrete alternating cycle through an active oriented edge. -/
noncomputable def concreteAlternatingComponent {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    Set {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
  matchingPairComponent (concreteShortInvolution D t) (concreteLongInvolution D t) i

/-- The successor permutation around the concrete alternating cycles. -/
noncomputable def concreteAlternatingSuccessor {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Equiv.Perm {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
  matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t)

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
