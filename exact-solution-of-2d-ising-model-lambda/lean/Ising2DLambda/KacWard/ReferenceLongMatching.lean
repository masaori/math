import Ising2DLambda.KacWard.Basic
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.NecSuf.KacWard.ReferenceLongMatching

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The reversal pairs retain the endpoint label even when the edge length is one. -/
def referenceLongPairs (L : ℕ) : Set (Set (OrientedEdge L)) :=
  {p | ∃ e : OrientedEdge L, p = {e, reversal e}}

theorem referenceLongMatching_isPerfectMatching (L : ℕ) :
    IsPerfectMatching (referenceLongPairs L) := by
  constructor
  · intro p hp
    obtain ⟨e, rfl⟩ := hp
    exact ⟨e, reversal e, (reversal_ne e).symm, rfl⟩
  · intro e
    refine ⟨{e, reversal e}, ⟨⟨e, rfl⟩, by simp⟩, ?_⟩
    intro p hp
    obtain ⟨f, rfl⟩ := hp.1
    have he : e = f ∨ e = reversal f := by
      simpa only [Set.mem_insert_iff, Set.mem_singleton_iff] using hp.2
    rcases he with rfl | h
    · rfl
    · have hf : f = reversal e := by
        calc
          f = reversal (reversal f) := (reversal_involutive f).symm
          _ = reversal e := congrArg reversal h.symm
      rw [hf, reversal_involutive]
      exact Set.pair_comm (reversal e) e

theorem referenceLongMatching_from_necSuf (L : ℕ) :
    IsPerfectMatching (referenceLongPairs L) := by
  exact Ising2DLambda.NecSuf.KacWard.reversalPairs_isPerfectMatching
    (reversal (L := L)) (reversal_ne (L := L)) (reversal_involutive (L := L))

end Ising2DLambda.KacWard
