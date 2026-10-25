import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree
import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceActiveVertices

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

theorem taggedDifference_active_iff_short {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L) :
    let R : PerfectMatching (OrientedEdge L) :=
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (∃ q ∈ Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
      Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅, e ∈ q.1) ↔
        ({e, perfectMatchingMate D e} : Set (OrientedEdge L)) ∈ shortUnderlyingPairs t := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D (shortUnderlyingPairs t) e
  let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ e
  have hlocal := taggedDifference_local_degree z s D t hterm e
  have hincident := taggedDifference_incident_iff D t e
  change d = r ∨ (d ≠ r ∧ d.2 = true ∧ r.2 = false) at hlocal
  constructor
  · rintro ⟨q, hq, he⟩
    have hq' : d ≠ r ∧ (q = d ∨ q = r) :=
      (hincident q).mp ⟨hq, he⟩
    rcases hlocal with heq | hdiff
    · exact False.elim (hq'.1 heq)
    · simpa [d, Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hdiff.2.1
  · intro hshort
    have hne : d ≠ r := by
      rcases hlocal with heq | hdiff
      · have hd : d.2 = true := by
          simpa [d, Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hshort
        have hr : r.2 = false := by
          simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
        rw [heq, hr] at hd
        cases hd
      · exact hdiff.1
    exact ⟨d, (hincident d).mpr ⟨hne, Or.inl rfl⟩⟩

end Ising2DLambda.KacWard
