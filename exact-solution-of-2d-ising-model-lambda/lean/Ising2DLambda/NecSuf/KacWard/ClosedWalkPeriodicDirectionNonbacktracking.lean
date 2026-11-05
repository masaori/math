import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限列の隣接条件と閉じ目の条件を剰余類添字へ移す。 -/
theorem finiteWord_periodic_direction_nonbacktracking {α : Type*} {m : ℕ}
    (γ : Fin (m + 1) → α) (d : α → ZMod 4)
    (hseq : ∀ k : Fin m, d (γ k.succ) ≠ d (γ k.castSucc) + 2)
    (hclose : d (γ 0) ≠ d (γ (Fin.last m)) + 2) :
    let γz : ZMod (m + 1) → α := fun j => γ ⟨j.val, ZMod.val_lt j⟩
    ∀ j : ZMod (m + 1), d (γz (j + 1)) ≠ d (γz j) + 2 := by
  dsimp
  intro j hdir
  by_cases hm0 : m = 0
  · subst m
    have hsame : j + 1 = j := by
      apply ZMod.val_injective
      have h₁ := ZMod.val_lt (j + 1)
      have h₂ := ZMod.val_lt j
      omega
    rw [hsame] at hdir
    have hnot : ∀ x : ZMod 4, x ≠ x + 2 := by decide
    exact hnot _ hdir
  have hm : 0 < m := Nat.pos_of_ne_zero hm0
  have hone : (1 : ZMod (m + 1)).val = 1 := ZMod.val_one'' (by omega)
  have hj : j.val ≤ m := by have := ZMod.val_lt j; omega
  by_cases hlast : j.val = m
  · have hnext : (j + 1).val = 0 := by
      rw [ZMod.val_add, hone, hlast]
      simp
    apply hclose
    simpa [hnext, hlast, Fin.last] using hdir
  · have hjlt : j.val < m := by omega
    have hnext : (j + 1).val = j.val + 1 := by
      rw [ZMod.val_add, hone, Nat.mod_eq_of_lt (by omega : j.val + 1 < m + 1)]
    let k : Fin m := ⟨j.val, hjlt⟩
    apply hseq k
    simpa [hnext, k, Fin.succ, Fin.castSucc] using hdir

end Ising2DLambda.NecSuf.KacWard
