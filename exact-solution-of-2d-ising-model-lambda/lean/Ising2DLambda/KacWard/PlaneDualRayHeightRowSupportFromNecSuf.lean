import Ising2DLambda.KacWard.PlaneDualRayHeightRowSupport
import Ising2DLambda.NecSuf.KacWard.FiniteRayRowSupport
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The concrete row-support statement follows from the finite ray-sum principle. -/
theorem planeDualRayHeight_row_support_from_necSuf (edges : Finset GridEdge) (r c : ℤ)
    (hheight : planeDualRayHeight edges r c = 1) :
    r ∈ edges.image (fun e => e.2.1) := by
  have hsum :
      (∑ e ∈ edges,
        if e.1 = true ∧ e.2.1 = r then
          (if c < e.2.2 then (1 : ZMod 2) else 0) else 0) =
        planeDualRayHeight edges r c := by
    simp only [planeDualRayHeight]
    apply Finset.sum_congr rfl
    intro e _
    by_cases hb : e.1 = true <;>
      by_cases hr : e.2.1 = r <;>
      by_cases hc : c < e.2.2 <;>
      simp [hb, hr, hc]
  have hnonzero :
      (∑ e ∈ edges,
        if e.1 = true ∧ e.2.1 = r then
          (if c < e.2.2 then (1 : ZMod 2) else 0) else 0) ≠ 0 := by
    rw [hsum, hheight]
    norm_num
  exact Ising2DLambda.NecSuf.KacWard.finiteRay_row_support edges
    (fun e => e.2.1) (fun e => e.1) r
    (fun e => if c < e.2.2 then 1 else 0) hnonzero

end Ising2DLambda.KacWard
