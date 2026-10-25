import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- Only a fixed point free involution is needed to pair each point once. -/
theorem reversalPairs_isPerfectMatching {J : Type*} (τ : J → J)
    (hne : ∀ j, τ j ≠ j) (hinv : Function.Involutive τ) :
    IsPerfectMatching {p : Set J | ∃ j : J, p = {j, τ j}} := by
  constructor
  · intro p hp
    obtain ⟨j, rfl⟩ := hp
    exact ⟨j, τ j, (hne j).symm, rfl⟩
  · intro j
    refine ⟨{j, τ j}, ⟨⟨j, rfl⟩, by simp⟩, ?_⟩
    intro p hp
    obtain ⟨k, rfl⟩ := hp.1
    have hj : j = k ∨ j = τ k := by
      simpa only [Set.mem_insert_iff, Set.mem_singleton_iff] using hp.2
    rcases hj with rfl | h
    · rfl
    · have hk : k = τ j := by
        calc
          k = τ (τ k) := (hinv k).symm
          _ = τ j := congrArg τ h.symm
      rw [hk, hinv]
      exact Set.pair_comm (τ j) j

end Ising2DLambda.NecSuf.KacWard
