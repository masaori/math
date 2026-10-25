import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

variable {J : Type*} [Fintype J]

theorem taggedDifference_active_iff_short (D R : PerfectMatching J)
    (T : Set (Set J))
    (hLong : ∀ p ∈ D.val, p ∉ T → p ∈ R.val) (i : J) :
    (∃ q ∈ taggedEdges D T ∆ taggedEdges R ∅, i ∈ q.1) ↔
      ({i, perfectMatchingMate D i} : Set J) ∈ T := by
  classical
  let d := taggedPairAt D T i
  let r := taggedPairAt R ∅ i
  have hlocal := taggedDifference_local_degree D R T hLong i
  have hincident := taggedDifference_incident_iff D R T i
  change d = r ∨ (d ≠ r ∧ d.2 = true ∧ r.2 = false) at hlocal
  constructor
  · rintro ⟨q, hq, hi⟩
    have hq' : d ≠ r ∧ (q = d ∨ q = r) :=
      (hincident q).mp ⟨hq, hi⟩
    rcases hlocal with heq | hdiff
    · exact False.elim (hq'.1 heq)
    · simpa [d, taggedPairAt] using hdiff.2.1
  · intro hshort
    have hne : d ≠ r := by
      rcases hlocal with heq | hdiff
      · have hd : d.2 = true := by simpa [d, taggedPairAt] using hshort
        have hr : r.2 = false := by simp [r, taggedPairAt]
        rw [heq, hr] at hd
        cases hd
      · exact hdiff.1
    exact ⟨d, (hincident d).mpr ⟨hne, Or.inl rfl⟩⟩

end Ising2DLambda.NecSuf.KacWard
