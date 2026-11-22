/-
具体版が必要十分版の特殊化として得られることの導出。
平行座標を加法準同型として必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftParallelIncrease

namespace Ising2DLambda.KacWard

/-- `claim_periodic_plane_lift_parallel_period_increase` の座標等式を必要十分版から導く。 -/
theorem periodicPlaneLift_parallelCoordinate_add_period_from_necSuf
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh k : ℤ) :
    windingParallelCoordinate wv wh (periodicPlaneLift m base L wv wh (k + m)) =
      windingParallelCoordinate wv wh (periodicPlaneLift m base L wv wh k) +
        (L : ℤ) * (wv ^ 2 + wh ^ 2) := by
  have hm0 : (m : ℤ) ≠ 0 := by omega
  have hquot : (k + (m : ℤ)) / (m : ℤ) = k / (m : ℤ) + 1 := by
    calc
      (k + (m : ℤ)) / (m : ℤ) = k / (m : ℤ) + (m : ℤ) / (m : ℤ) :=
        Int.add_ediv_of_dvd_right dvd_rfl
      _ = k / (m : ℤ) + 1 := by rw [Int.ediv_self hm0]
  have hrem : (k + (m : ℤ)) % (m : ℤ) = k % (m : ℤ) := by
    exact Int.add_emod_right k (m : ℤ)
  rw [show (k + m : ℤ) = k + (m : ℤ) by rfl]
  simp only [periodicPlaneLift, hquot, hrem]
  rw [Ising2DLambda.NecSuf.KacWard.periodic_lift_coordinate_next_period_necSuf]
  rw [windingParallelCoordinate_windingShift]

end Ising2DLambda.KacWard
