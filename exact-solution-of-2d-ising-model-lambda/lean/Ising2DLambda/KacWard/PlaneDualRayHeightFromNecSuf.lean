import Ising2DLambda.KacWard.PlaneDualRayHeight
import Ising2DLambda.NecSuf.KacWard.PlaneDualRayHeight

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- The generic finite cut identity specializes to the vertical grid edges of one row. -/
theorem planeDualRayHeight_horizontal_from_necSuf
    (edges : Finset GridEdge) (r c : ℤ) :
    planeDualRayHeight edges r (c - 1) =
      planeDualRayHeight edges r c +
        if (true, (r, c)) ∈ edges then 1 else 0 := by
  let active : GridEdge → Prop := fun e => e.1 = true ∧ e.2.1 = r
  have h := finiteRayHeight_horizontal edges active (fun e => e.2.2) c
  simp only [finiteRayHeight, active, and_assoc] at h
  have hpred (e : GridEdge) :
      (e.1 = true ∧ e.2.1 = r ∧ e.2.2 = c) ↔ e = (true, (r, c)) := by
    rcases e with ⟨b, ⟨s, d⟩⟩
    simp
  simp_rw [hpred] at h
  have hsingle :
      (∑ e ∈ edges, if e = (true, (r, c)) then (1 : ZMod 2) else 0) =
        if (true, (r, c)) ∈ edges then 1 else 0 := by simp
  rw [hsingle] at h
  exact h

end Ising2DLambda.KacWard
