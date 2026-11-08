import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite ray with even incidence has the adjacent-row difference given by its horizontal cut. -/
theorem finiteRayHeight_vertical
    (top bottom horizontal upper lower : ℤ → ZMod 2)
    (htop : ∀ c, top (c - 1) = top c + upper c)
    (hbottom : ∀ c, bottom (c - 1) = bottom c + lower c)
    (heven : ∀ c, horizontal c + horizontal (c - 1) + upper c + lower c = 0)
    (hcutoff : ∃ M, top M = 0 ∧ bottom M = 0 ∧ horizontal M = 0)
    (c : ℤ) : top c + bottom c = horizontal c := by
  have hneg (x : ZMod 2) : -x = x := by
    have htwo : (2 : ZMod 2) = 0 := by decide
    have hself : x + x = 0 := by
      calc
        x + x = 2 * x := by ring
        _ = 0 := by simp [htwo]
    exact (neg_eq_iff_add_eq_zero).2 hself
  have hmove (a b v w : ZMod 2) (h : a + b + v + w = 0) : v + w + b = a := by
    have h' : a + (b + v + w) = 0 := by simpa only [add_assoc] using h
    have ha : a = -(b + v + w) := eq_neg_of_add_eq_zero_left h'
    rw [hneg] at ha
    simpa only [add_comm, add_left_comm, add_assoc] using ha.symm
  let H : ℤ → ZMod 2 := fun d => top d + bottom d + horizontal d
  have hstep (d : ℤ) : H (d - 1) = H d := by
    have hp := hmove (horizontal d) (horizontal (d - 1)) (upper d) (lower d) (heven d)
    dsimp [H]
    rw [htop d, hbottom d]
    calc
      _ = top d + bottom d + (upper d + lower d + horizontal (d - 1)) := by abel
      _ = _ := by rw [hp]
  have hconstant (d : ℤ) : H d = H 0 := by
    induction d using Int.induction_on with
    | zero => rfl
    | succ d ih =>
        calc
          H (d + 1) = H d := by simpa only [add_sub_cancel_right] using (hstep (d + 1)).symm
          _ = H 0 := ih
    | pred d ih => exact (hstep (-(d : ℤ))).trans ih
  obtain ⟨M, ht, hb, hh⟩ := hcutoff
  have hM : H M = 0 := by simp [H, ht, hb, hh]
  have hc : H c = 0 := (hconstant c).trans ((hconstant M).symm.trans hM)
  dsimp [H] at hc
  have hp := hmove (horizontal c) (top c + bottom c) 0 0
    (by simpa only [add_zero, zero_add, add_comm] using hc)
  simpa only [zero_add, add_zero] using hp

end Ising2DLambda.NecSuf.KacWard
