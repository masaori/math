import Mathlib.Data.Set.Insert

namespace Ising2DLambda.NecSuf.KacWard

/-- A pair supported by a fixed involution belongs to its family of reversal pairs. -/
theorem longPair_mem_reversalPairs {J : Type*} (τ : J → J) (p : J × J)
    (h : p.2 = τ p.1) :
    ({p.1, p.2} : Set J) ∈ {q : Set J | ∃ j : J, q = {j, τ j}} := by
  exact ⟨p.1, by rw [h]⟩

end Ising2DLambda.NecSuf.KacWard
