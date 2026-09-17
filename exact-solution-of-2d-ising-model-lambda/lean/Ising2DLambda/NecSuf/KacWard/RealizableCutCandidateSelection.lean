import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

def RecoveredCandidateSet {C : Type} [Fintype C] [DecidableEq C]
    (recovered : C → Prop) [DecidablePred recovered] : Finset C :=
  Finset.univ.filter recovered

/--
The essential selection step needs only the pointwise equivalence between
geometric realizability and the recovered finite predicate.
-/
theorem realizable_iff_mem_recoveredCandidateSet
    {C : Type} [Fintype C] [DecidableEq C]
    (realizable recovered : C → Prop)
    [DecidablePred recovered]
    (hrecover : ∀ candidate, realizable candidate ↔ recovered candidate)
    (candidate : C) :
    realizable candidate ↔
      candidate ∈ RecoveredCandidateSet recovered := by
  rw [RecoveredCandidateSet, Finset.mem_filter]
  simp only [Finset.mem_univ, true_and]
  exact hrecover candidate

end Ising2DLambda.NecSuf.KacWard
