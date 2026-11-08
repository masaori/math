import Ising2DLambda.KacWard.PlaneDualRayHeightLeftBound
import Ising2DLambda.NecSuf.KacWard.PlaneDualRayHeightLeftBound

namespace Ising2DLambda.KacWard

/-- The finite lattice height is an instance of the finite-row height principle. -/
theorem planeDualRayHeight_zero_left_from_necSuf (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c M : ℤ) (hmin : ∀ e ∈ edges, M ≤ e.2.2) (hc : c < M) :
    planeDualRayHeight edges r c = 0 := by
  have hstep (s : ℤ) :
      planeDualRayHeight edges s c = planeDualRayHeight edges (s - 1) c := by
    have hnot : (false, (s, c)) ∉ edges := by
      intro hs
      have := hmin (false, (s, c)) hs
      simp only at this
      omega
    have h := planeDualRayHeight_vertical edges heven s c
    simp only [if_neg hnot] at h
    have htwo : (2 : ZMod 2) = 0 := by decide
    have hself : planeDualRayHeight edges (s - 1) c +
        planeDualRayHeight edges (s - 1) c = 0 := by
      calc
        _ = 2 * planeDualRayHeight edges (s - 1) c := by ring
        _ = 0 := by simp [htwo]
    exact (eq_neg_of_add_eq_zero_left h).trans
      ((neg_eq_iff_add_eq_zero).2 hself)
  exact Ising2DLambda.NecSuf.KacWard.finiteRowHeight_zero
    (fun s => planeDualRayHeight edges s c)
    (edges.image (fun e => e.2.1)) hstep
    (fun s hs => planeDualRayHeight_row_support edges s c hs) r

end Ising2DLambda.KacWard
