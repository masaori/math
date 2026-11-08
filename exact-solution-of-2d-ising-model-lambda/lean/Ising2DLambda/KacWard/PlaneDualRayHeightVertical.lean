import Ising2DLambda.KacWard.PlaneDualRayHeight
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

set_option maxHeartbeats 2000000

private theorem zmod_two_neg (x : ZMod 2) : -x = x := by
  have htwo : (2 : ZMod 2) = 0 := by decide
  have hself : x + x = 0 := by
    calc
      x + x = 2 * x := by ring
      _ = 0 := by simp [htwo]
  exact (neg_eq_iff_add_eq_zero).2 hself

private theorem parity_move (a b v w : ZMod 2)
    (h : a + b + v + w = 0) : v + w + b = a := by
  have h' : a + (b + v + w) = 0 := by simpa only [add_assoc] using h
  have ha : a = -(b + v + w) := eq_neg_of_add_eq_zero_left h'
  rw [zmod_two_neg] at ha
  simpa only [add_comm, add_left_comm, add_assoc] using ha.symm

/-- The parity of a finite ray changes across a row by the intervening horizontal edge. -/
theorem planeDualRayHeight_vertical (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c : ℤ) :
    planeDualRayHeight edges r c + planeDualRayHeight edges (r - 1) c =
      if (false, (r, c)) ∈ edges then 1 else 0 := by
  let H : ℤ → ZMod 2 := fun d =>
    planeDualRayHeight edges r d + planeDualRayHeight edges (r - 1) d +
      if (false, (r, d)) ∈ edges then 1 else 0
  have hstep (d : ℤ) : H (d - 1) = H d := by
    have hr := planeDualRayHeight_horizontal edges r d
    have hr' := planeDualRayHeight_horizontal edges (r - 1) d
    have hv := heven r d
    dsimp [H]
    rw [hr, hr']
    have hp := parity_move
      (if (false, (r, d)) ∈ edges then (1 : ZMod 2) else 0)
      (if (false, (r, d - 1)) ∈ edges then (1 : ZMod 2) else 0)
      (if (true, (r, d)) ∈ edges then (1 : ZMod 2) else 0)
      (if (true, (r - 1, d)) ∈ edges then (1 : ZMod 2) else 0) hv
    calc
      _ = planeDualRayHeight edges r d + planeDualRayHeight edges (r - 1) d +
          ((if (true, (r, d)) ∈ edges then (1 : ZMod 2) else 0) +
            (if (true, (r - 1, d)) ∈ edges then 1 else 0) +
            (if (false, (r, d - 1)) ∈ edges then 1 else 0)) := by abel
      _ = _ := by rw [hp]
  have hconstant (d : ℤ) : H d = H 0 := by
    induction d using Int.induction_on with
    | zero => rfl
    | succ d ih =>
        calc
          H (d + 1) = H d := by simpa only [add_sub_cancel_right] using (hstep (d + 1)).symm
          _ = H 0 := ih
    | pred d ih => exact (hstep (-(d : ℤ))).trans ih
  by_cases hne : edges.Nonempty
  · obtain ⟨e, he, hmax⟩ := Finset.exists_max_image edges (fun e => e.2.2) hne
    let M : ℤ := e.2.2 + 1
    have hnone (x : GridEdge) (hx : x ∈ edges) : ¬ M ≤ x.2.2 := by
      have h := hmax x hx
      dsimp [M]
      omega
    have hrzero : planeDualRayHeight edges r M = 0 := by
      simp only [planeDualRayHeight]
      apply Finset.sum_eq_zero
      intro x hx
      have hnot : ¬ M < x.2.2 := by
        have := hmax x hx
        dsimp [M]
        omega
      simp [hnot]
    have hr'zero : planeDualRayHeight edges (r - 1) M = 0 := by
      simp only [planeDualRayHeight]
      apply Finset.sum_eq_zero
      intro x hx
      have hnot : ¬ M < x.2.2 := by
        have := hmax x hx
        dsimp [M]
        omega
      simp [hnot]
    have hhorizontal : (false, (r, M)) ∉ edges := by
      intro hx
      exact hnone _ hx (le_refl M)
    have hM : H M = 0 := by simp [H, hrzero, hr'zero, hhorizontal]
    have hc : H c = 0 := (hconstant c).trans ((hconstant M).symm.trans hM)
    dsimp [H] at hc
    have h := parity_move
      (if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0)
      (planeDualRayHeight edges r c + planeDualRayHeight edges (r - 1) c) 0 0
      (by simpa only [add_zero, zero_add, add_comm] using hc)
    simpa only [zero_add, add_zero] using h
  · have hempty : edges = ∅ := Finset.not_nonempty_iff_eq_empty.mp hne
    simp [hempty, planeDualRayHeight]

end Ising2DLambda.KacWard
