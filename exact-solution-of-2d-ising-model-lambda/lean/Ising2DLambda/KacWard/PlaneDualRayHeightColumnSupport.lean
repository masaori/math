import Ising2DLambda.KacWard.PlaneDualRayHeightLeftBound
import Ising2DLambda.KacWard.PlaneDualRayHeightRightBound
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Columns containing a height-one cell lie in a finite integer interval. -/
theorem planeDualRayHeight_column_support (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0) :
    ∃ cols : Finset ℤ, ∀ r c : ℤ,
      planeDualRayHeight edges r c = 1 → c ∈ cols := by
  by_cases hne : edges.Nonempty
  · obtain ⟨emin, hmem_min, hmin⟩ :=
      Finset.exists_min_image edges (fun e => e.2.2) hne
    obtain ⟨emax, hmem_max, hmax⟩ :=
      Finset.exists_max_image edges (fun e => e.2.2) hne
    refine ⟨Finset.Icc emin.2.2 emax.2.2, ?_⟩
    intro r c hheight
    have hleft : emin.2.2 ≤ c := by
      by_contra hc
      have hz := planeDualRayHeight_zero_left edges heven r c emin.2.2
        (fun e he => hmin e he) (by omega)
      have : (0 : ZMod 2) = 1 := hz.symm.trans hheight
      norm_num at this
    have hright : c < emax.2.2 := by
      by_contra hc
      have hz := planeDualRayHeight_zero_right edges r c emax.2.2
        (fun e he => hmax e he) (by omega)
      have : (0 : ZMod 2) = 1 := hz.symm.trans hheight
      norm_num at this
    exact Finset.mem_Icc.mpr ⟨hleft, le_of_lt hright⟩
  · refine ⟨∅, ?_⟩
    intro r c hheight
    have hempty : edges = ∅ := Finset.not_nonempty_iff_eq_empty.mp hne
    simp [hempty, planeDualRayHeight] at hheight

end Ising2DLambda.KacWard
