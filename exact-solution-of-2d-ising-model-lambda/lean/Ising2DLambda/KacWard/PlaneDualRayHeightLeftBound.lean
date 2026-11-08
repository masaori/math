import Ising2DLambda.KacWard.PlaneDualRayHeightVertical
import Ising2DLambda.KacWard.PlaneDualRayHeightRowSupport
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Even vertex degrees force the ray height to vanish to the left of every selected edge. -/
theorem planeDualRayHeight_zero_left (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c M : ℤ) (hmin : ∀ e ∈ edges, M ≤ e.2.2) (hc : c < M) :
    planeDualRayHeight edges r c = 0 := by
  have hhorizontal (s : ℤ) : (false, (s, c)) ∉ edges := by
    intro hs
    have := hmin (false, (s, c)) hs
    simp only at this
    omega
  have hstep (s : ℤ) :
      planeDualRayHeight edges s c = planeDualRayHeight edges (s - 1) c := by
    have h := planeDualRayHeight_vertical edges heven s c
    simp only [if_neg (hhorizontal s)] at h
    have hneg : -(planeDualRayHeight edges (s - 1) c) =
        planeDualRayHeight edges (s - 1) c := by
      have htwo : (2 : ZMod 2) = 0 := by decide
      have hself : planeDualRayHeight edges (s - 1) c +
          planeDualRayHeight edges (s - 1) c = 0 := by
        calc
          _ = 2 * planeDualRayHeight edges (s - 1) c := by ring
          _ = 0 := by simp [htwo]
      exact (neg_eq_iff_add_eq_zero).2 hself
    exact (eq_neg_of_add_eq_zero_left h).trans hneg
  have hconstant (s : ℤ) :
      planeDualRayHeight edges s c = planeDualRayHeight edges 0 c := by
    induction s using Int.induction_on with
    | zero => rfl
    | succ s ih =>
        calc
          planeDualRayHeight edges (s + 1) c = planeDualRayHeight edges s c := by
            simpa only [add_sub_cancel_right] using hstep (s + 1)
          _ = planeDualRayHeight edges 0 c := ih
    | pred s ih => exact (hstep (-(s : ℤ))).symm.trans ih
  by_cases hne : edges.Nonempty
  · obtain ⟨e, he, hmax⟩ := Finset.exists_max_image edges (fun e => e.2.1) hne
    let s : ℤ := e.2.1 + 1
    have habsent : ∀ d : ℤ, (true, (s, d)) ∉ edges := by
      intro d hedges
      have := hmax (true, (s, d)) hedges
      dsimp [s] at *
      omega
    have hzero := planeDualRayHeight_zero_of_row_absent edges s c habsent
    exact (hconstant r).trans ((hconstant s).symm.trans hzero)
  · have hempty : edges = ∅ := Finset.not_nonempty_iff_eq_empty.mp hne
    simp [hempty, planeDualRayHeight]

end Ising2DLambda.KacWard
