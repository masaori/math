import Ising2DLambda.KacWard.ProjectedCycleSupportUnion
import Ising2DLambda.NecSuf.KacWard.ProjectedCycleSupportUnion
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceCycleCover
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
attribute [local instance] Classical.propDecidable

private theorem projectedCycleSupportUnion_eq_range_concrete {J E : Type*}
    [Fintype J] [LinearOrder J] (τ υ : FixedPointFreeInvolution J)
    (p : J → E) (hp : ∀ j, p (υ.val j) = p j) :
    {e | ∃ i j : J, j ∈ matchingPairComponent τ υ i ∧
      j ∈ matchingPairColor τ υ ∧ p j = e} = Set.range p := by
  classical
  have hcover := NecSuf.KacWard.alternatingCycle_cover τ.val υ.val τ.property.2 υ.property.2
  have hself : ∀ i, i ∈ matchingPairComponent τ υ i := by
    intro i
    simpa [Ising2DLambda.AlgebraicEigenvalue.matchingPairComponent,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponent,
      Ising2DLambda.AlgebraicEigenvalue.finitePermutationOrbit,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit,
      Ising2DLambda.AlgebraicEigenvalue.finiteMapIterate,
      Ising2DLambda.AlgebraicEigenvalue.matchingPairStep,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionPairStep] using hcover.1 i
  have hmate : ∀ i, υ.val i ∈ matchingPairComponent τ υ i := by
    intro i
    simpa [Ising2DLambda.AlgebraicEigenvalue.matchingPairComponent,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairComponent,
      Ising2DLambda.AlgebraicEigenvalue.finitePermutationOrbit,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.permutationOrbit,
      Ising2DLambda.AlgebraicEigenvalue.finiteMapIterate,
      Ising2DLambda.AlgebraicEigenvalue.matchingPairStep,
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionPairStep] using (hcover.2.2 i).2
  exact NecSuf.KacWard.projectedCycleSupportUnion_eq_range υ.val
    (matchingPairComponent τ υ) (matchingPairColor τ υ) p
    hself hmate (matchingPairSecondColor_alternates τ υ) hp

/-- The abstract coverage theorem specializes to the actual tagged matching. -/
theorem projectedCycleSupportUnion_eq_complement_from_necSuf {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    projectedCycleSupportUnion D t = ↑(taggedComplementEdges D t) := by
  classical
  let A := concreteTaggedActiveVertices D t
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  have hp (j : {a : OrientedEdge L // a ∈ A}) : (υ.val j).val.1 = j.val.1 := by
    change (perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) j.val).1 = j.val.1
    rw [referenceLongMate_eq_reversal]
    rfl
  have hcover : projectedCycleSupportUnion D t =
      Set.range (fun j : {a : OrientedEdge L // a ∈ A} => j.val.1) := by
    simpa [projectedCycleSupportUnion, concreteAlternatingComponent, reversal] using
      (projectedCycleSupportUnion_eq_range_concrete
        τ υ (fun j : {a : OrientedEdge L // a ∈ A} => j.val.1) hp)
  rw [hcover]
  ext e
  constructor
  · rintro ⟨j, rfl⟩
    have hj : j.val ∈ taggedActiveByLabels D t := by
      rw [taggedActiveByLabels_eq_concreteTaggedActiveVertices]
      exact j.property
    exact (taggedComplement_iff_active_concrete z s D t ht hterm j.val).2 hj
  · intro he
    let a : OrientedEdge L := (e, false)
    have ha : a ∈ A := by
      dsimp [A]
      rw [← taggedActiveByLabels_eq_concreteTaggedActiveVertices D t]
      exact (taggedComplement_iff_active_concrete z s D t ht hterm a).1
        (by simpa [a] using he)
    exact ⟨⟨a, ha⟩, rfl⟩

end Ising2DLambda.KacWard
