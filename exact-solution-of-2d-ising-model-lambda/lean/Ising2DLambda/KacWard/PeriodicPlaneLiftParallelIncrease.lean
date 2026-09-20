/-
章「Onsager 閉形式への接続」の
「周期並進は平行座標を正の定数だけ増やす」
（`claim_periodic_plane_lift_parallel_period_increase`）の具体版。

人手証明と同じく、整数の商と余りで周期延長した持ち上げを一周期ずらし、
巻き付きに平行な整数座標で読む。住処は ℤ だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftParallelIncrease
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_winding_parallel_coordinate`。巻き付きベクトルに平行な整数座標。 -/
def windingParallelCoordinate (wv wh : ℤ) : (ℤ × ℤ) →+ ℤ where
  toFun p := wv * p.1 + wh * p.2
  map_zero' := by simp
  map_add' := by
    intro p p'
    dsimp
    ring

/-- 一周期の平面並進ベクトルの平行座標。 -/
lemma windingParallelCoordinate_windingShift
    (L : ℕ) (wv wh : ℤ) :
    windingParallelCoordinate wv wh (windingShift L wv wh) =
      (L : ℤ) * (wv ^ 2 + wh ^ 2) := by
  simp [windingParallelCoordinate, windingShift]
  ring

/-- `claim_periodic_plane_lift_parallel_period_increase` の座標等式。 -/
theorem periodicPlaneLift_parallelCoordinate_add_period
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
  simp only [periodicPlaneLift, periodicLiftCore, hquot, hrem]
  rw [periodic_lift_coordinate_next_period_necSuf]
  rw [windingParallelCoordinate_windingShift]

/-- 非零巻き付きと正の格子幅の下で、一周期の平行座標の増分は正である。 -/
theorem windingParallelCoordinate_windingShift_pos
    (L : ℕ) (hL : 0 < L) (wv wh : ℤ) (hwind : wv ≠ 0 ∨ wh ≠ 0) :
    1 ≤ (L : ℤ) * (wv ^ 2 + wh ^ 2) := by
  have hwvSq : 0 ≤ wv ^ 2 := sq_nonneg wv
  have hwhSq : 0 ≤ wh ^ 2 := sq_nonneg wh
  have hsum : 1 ≤ wv ^ 2 + wh ^ 2 := by
    rcases hwind with hwv | hwh
    · have hwvPos : 0 < wv ^ 2 := sq_pos_of_ne_zero hwv
      have : 1 ≤ wv ^ 2 := by omega
      omega
    · have hwhPos : 0 < wh ^ 2 := sq_pos_of_ne_zero hwh
      have : 1 ≤ wh ^ 2 := by omega
      omega
  have hLz : 1 ≤ (L : ℤ) := by omega
  nlinarith

end Ising2DLambda.KacWard
