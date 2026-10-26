import Ising2DLambda.KacWard.ProjectedCycleSupportUnion
import Ising2DLambda.NecSuf.KacWard.ProjectedCycleSupportUnion

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
attribute [local instance] Classical.propDecidable

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
  let A := Ising2DLambda.NecSuf.KacWard.activeVertices D
    (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
      PerfectMatching (OrientedEdge L)) (shortUnderlyingPairs t)
  let τ := shortInvolution D t
  let υ := longInvolution D t
  have hp (j : {a : OrientedEdge L // a ∈ A}) : (υ.val j).val.1 = j.val.1 := by
    change (perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) j.val).1 = j.val.1
    rw [referenceLongMate_eq_reversal]
    rfl
  have hcover : projectedCycleSupportUnion D t =
      Set.range (fun j : {a : OrientedEdge L // a ∈ A} => j.val.1) := by
    simpa [projectedCycleSupportUnion, reversal] using
      (Ising2DLambda.NecSuf.KacWard.projectedCycleSupportUnion_eq_range
        τ υ (fun j : {a : OrientedEdge L // a ∈ A} => j.val.1) hp)
  rw [hcover]
  ext e
  constructor
  · rintro ⟨j, rfl⟩
    exact (taggedComplement_iff_active_from_necSuf z s D t ht hterm j.val).2 j.property
  · intro he
    let a : OrientedEdge L := (e, false)
    have ha : a ∈ A :=
      (taggedComplement_iff_active_from_necSuf z s D t ht hterm a).1 (by simpa [a] using he)
    exact ⟨⟨a, ha⟩, rfl⟩

end Ising2DLambda.KacWard
