import Ising2DLambda.NecSuf.KacWard.ClosedWalkPasses

namespace Ising2DLambda.NecSuf.KacWard

/-- Equality at every adjacent pair of a nonempty cyclic list propagates from its first entry. -/
theorem cyclic_coefficient_propagation {m : ℕ} {A : Type*} (f : Fin (m + 1) → A)
    (hstep : ∀ k, f k = f (cyclicSuccessor k)) : ∀ k, f k = f 0 := by
  intro k
  induction k using Fin.induction with
  | zero => rfl
  | succ k ih =>
      have hs : cyclicSuccessor k.castSucc = k.succ := by
        apply Fin.ext
        simp [cyclicSuccessor, k.isLt]
      calc
        f k.succ = f k.castSucc := by simpa only [hs] using (hstep k.castSucc).symm
        _ = f 0 := ih

end Ising2DLambda.NecSuf.KacWard
