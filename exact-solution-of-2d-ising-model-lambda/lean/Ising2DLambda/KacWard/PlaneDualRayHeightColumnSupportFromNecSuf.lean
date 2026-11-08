import Ising2DLambda.KacWard.PlaneDualRayHeightColumnSupport
import Ising2DLambda.NecSuf.KacWard.PlaneDualRayHeightColumnSupport

namespace Ising2DLambda.KacWard

/-- The grid height specializes the binary finite-column principle. -/
theorem planeDualRayHeight_column_support_from_necSuf (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0) :
    ∃ cols : Finset ℤ, ∀ r c : ℤ,
      planeDualRayHeight edges r c = 1 → c ∈ cols := by
  by_cases hne : edges.Nonempty
  · obtain ⟨emin, _, hmin⟩ :=
      Finset.exists_min_image edges (fun e => e.2.2) hne
    obtain ⟨emax, _, hmax⟩ :=
      Finset.exists_max_image edges (fun e => e.2.2) hne
    refine ⟨Finset.Icc emin.2.2 emax.2.2, ?_⟩
    exact Ising2DLambda.NecSuf.KacWard.binaryHeight_column_support
      (planeDualRayHeight edges) emin.2.2 emax.2.2
      (fun r c hc => planeDualRayHeight_zero_left edges heven r c emin.2.2
        (fun e he => hmin e he) hc)
      (fun r c hc => planeDualRayHeight_zero_right edges r c emax.2.2
        (fun e he => hmax e he) hc)
  · refine ⟨∅, ?_⟩
    intro r c hheight
    have hempty : edges = ∅ := Finset.not_nonempty_iff_eq_empty.mp hne
    simp [hempty, planeDualRayHeight] at hheight

end Ising2DLambda.KacWard
