import Ising2DLambda.KacWard.TaggedDifferenceTwoStepOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

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
    (i : {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t}) :
    Disjoint (finitePermutationOrbit (taggedConcreteTwoStep D t) i)
      (finitePermutationOrbit (taggedConcreteTwoStep D t)
        (taggedConcreteShortMate D t i)) := by
  -- 本文の第一段: 基準完全マッチング `𝒟₀`（`claim_reference_long_matching`）と `D` の相手写像の
  -- 活動点への制限は、`claim_perfect_matching_involution` により不動点のない対合である。
  let D₀ : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let τ : FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
    ⟨taggedConcreteShortMate D t,
      (fun i h => perfectMatchingMate_ne D i.1 (congrArg Subtype.val h)),
      (fun i => Subtype.ext (perfectMatchingMate_involutive D i.1))⟩
  let υ : FixedPointFreeInvolution {i : OrientedEdge L // i ∈ concreteTaggedActiveVertices D t} :=
    ⟨taggedConcreteLongMate D t,
      (fun i h => perfectMatchingMate_ne D₀ i.1 (congrArg Subtype.val h)),
      (fun i => Subtype.ext (perfectMatchingMate_involutive D₀ i.1))⟩
  -- 本文の第二段: 二対合の合成は二歩 `F_𝒜`（`claim_tagged_difference_two_step_orbit`）であり、
  -- `claim_matching_pair_orbit_separation` を適用する。
  have hstep : matchingPairStep τ υ = taggedConcreteTwoStep D t := by
    apply Equiv.ext
    intro j
    rfl
  have hmate : τ.val i = taggedConcreteShortMate D t i := rfl
  simpa only [hstep, hmate] using matchingPairStep_orbits_disjoint τ υ i

end Ising2DLambda.KacWard
