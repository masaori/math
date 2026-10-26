import Ising2DLambda.KacWard.ProjectedCycleDistinctEdges
import Ising2DLambda.KacWard.TaggedComplementActiveVertices
import Ising2DLambda.KacWard.TaggedDifferenceCycleCover
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceCycleCover

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
attribute [local instance] Classical.propDecidable

/-- Union of the supports of the first-colour projected alternating cycles. -/
noncomputable def projectedCycleSupportUnion {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) : Set (Edge L) :=
  {e | ∃ i j : {a : OrientedEdge L // a ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)},
      j ∈ matchingPairComponent (shortInvolution D t) (longInvolution D t) i ∧
      j ∈ matchingPairColor (shortInvolution D t) (longInvolution D t) ∧
      (reversal j.val).1 = e}

/-- Every selected unoriented edge appears in exactly the support union of the
    projected cycles; no nonselected edge appears there. -/
theorem projectedCycleSupportUnion_eq_complement {L : ℕ} (z : Qbar)
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
  ext e
  constructor
  · rintro ⟨i, j, hjcycle, hjcolor, hjedge⟩
    have hbase : j.val.1 = e := by simpa only [reversal] using hjedge
    have hactive : j.val.1 ∈ taggedComplementEdges D t :=
      (taggedComplement_iff_active_from_necSuf z s D t ht hterm j.val).2 j.property
    simpa [hbase] using hactive
  · intro he
    let a : OrientedEdge L := (e, false)
    have ha : a ∈ A :=
      (taggedComplement_iff_active_from_necSuf z s D t ht hterm a).1 (by simpa [a] using he)
    let i : {a : OrientedEdge L // a ∈ A} := ⟨a, ha⟩
    have hcover := Ising2DLambda.NecSuf.KacWard.alternatingCycle_cover τ υ
    by_cases hfirst : i ∈ matchingPairColor τ υ
    · exact ⟨i, i, hcover.1 i, hfirst, by simp [i, a, reversal]⟩
    · let j := υ.val i
      have hjcolor : j ∈ matchingPairColor τ υ :=
        (matchingPairSecondColor_alternates τ υ i).2 hfirst
      have hjcycle : j ∈ matchingPairComponent τ υ i :=
        (Ising2DLambda.NecSuf.KacWard.alternatingCycle_cover τ υ).2.2 i |>.2
      have hjedge : (reversal j.val).1 = e := by
        change (reversal (perfectMatchingMate
          (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
            PerfectMatching (OrientedEdge L)) i.val)).1 = e
        rw [referenceLongMate_eq_reversal, reversal_involutive]
      exact ⟨i, j, hjcycle, hjcolor, hjedge⟩

end Ising2DLambda.KacWard
