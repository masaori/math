import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceActiveVertices

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- The reference pair at a point is absent from the first matching's long
    pairs exactly when that point is active. No lattice structure is needed. -/
theorem referencePair_uncovered_iff_active (D R : PerfectMatching J)
    (T : Set (Set J))
    (hLong : ∀ p ∈ D.val, p ∉ T → p ∈ R.val) (i : J) :
    ¬ (({i, perfectMatchingMate R i} : Set J) ∈ D.val ∧
      ({i, perfectMatchingMate R i} : Set J) ∉ T) ↔
      i ∈ activeVertices D R T := by
  classical
  have hshort : i ∈ activeVertices D R T ↔
      ({i, perfectMatchingMate D i} : Set J) ∈ T :=
    (mem_activeVertices_iff_incident D R T i).trans
      (taggedDifference_active_iff_short D R T hLong i)
  rw [hshort]
  constructor
  · intro huncovered
    by_contra hnot
    have hD : ({i, perfectMatchingMate D i} : Set J) ∈ D.val :=
      (perfectMatchingMate_spec D i).2
    have hR : ({i, perfectMatchingMate D i} : Set J) ∈ R.val :=
      hLong _ hD hnot
    have hpair : ({i, perfectMatchingMate R i} : Set J) =
        ({i, perfectMatchingMate D i} : Set J) :=
      (R.property.2 i).unique
        ⟨(perfectMatchingMate_spec R i).2, by simp⟩ ⟨hR, by simp⟩
    apply huncovered
    rw [hpair]
    exact ⟨hD, hnot⟩
  · intro hshort huncovered
    have hD : ({i, perfectMatchingMate D i} : Set J) ∈ D.val :=
      (perfectMatchingMate_spec D i).2
    have hpair : ({i, perfectMatchingMate R i} : Set J) =
        ({i, perfectMatchingMate D i} : Set J) :=
      (D.property.2 i).unique
        ⟨huncovered.1, by simp⟩ ⟨hD, by simp⟩
    exact huncovered.2 (hpair ▸ hshort)

end Ising2DLambda.NecSuf.KacWard
