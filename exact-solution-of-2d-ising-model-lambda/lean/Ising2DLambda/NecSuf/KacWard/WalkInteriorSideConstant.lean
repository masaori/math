import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite nonempty list is constant when consecutive entries agree. -/
theorem finite_adjacent_side_constant {m : ℕ} {α : Type*} (sideAt : Fin (m + 1) → α)
    (hadjacent : ∀ j : Fin m,
      sideAt ⟨j.val, by omega⟩ = sideAt ⟨j.val + 1, by omega⟩) :
    ∃ side : α, ∀ j, sideAt j = side := by
  refine ⟨sideAt 0, ?_⟩
  intro j
  have hchain (k : ℕ) (hk : k < m + 1) :
      sideAt ⟨k, hk⟩ = sideAt 0 := by
    induction k with
    | zero => rfl
    | succ k ih =>
        have hprev : k < m := by omega
        have hstep := hadjacent ⟨k, hprev⟩
        exact hstep.symm.trans (ih (by omega))
  exact hchain j.val j.isLt

end Ising2DLambda.NecSuf.KacWard
