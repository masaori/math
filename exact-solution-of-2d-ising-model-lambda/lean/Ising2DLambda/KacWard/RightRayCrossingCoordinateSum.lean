import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Ising2DLambda.KacWard.RightRayVerticalCrossingCount
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning

namespace Ising2DLambda.KacWard

/-- The ray count of an actual lifted edge sequence is its coordinate sum. -/
theorem rightRayVerticalCrossingCount_eq_coordinateSum {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (r c : ℤ) :
    rightRayVerticalCrossingCount γ hγ r c =
      rightRayCrossingCount (m + 1)
        (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1)
        (fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2) r c := by
  unfold rightRayVerticalCrossingCount rightRayCrossingCount
  rw [Finset.card_filter]
  rw [← Fin.sum_univ_eq_sum_range]
  apply Finset.sum_congr rfl
  intro j hj
  have h0 : Fin.ofNat (m + 2) j.val = j.castSucc := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : j.val < m + 2)]
  have h1 : Fin.ofNat (m + 2) (j.val + 1) = j.succ := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : j.val + 1 < m + 2)]
  have hstep := planeLift_succ γ j
  have hunit := orientedEdgeLatticeStep_unit (γ j)
  have hvertical :
      ((planeLift γ j.castSucc).1 = r ∧ (planeLift γ j.succ).1 = r + 1 ∨
       (planeLift γ j.castSucc).1 = r + 1 ∧ (planeLift γ j.succ).1 = r) →
      (planeLift γ j.castSucc).2 = (planeLift γ j.succ).2 := by
    intro hcross
    rcases hunit with hu | hu | hu | hu <;>
      rw [hstep, hu] at hcross ⊢ <;>
      simp only [Prod.snd_add, Prod.fst_add] at hcross ⊢ <;>
      simp at hcross ⊢ <;> omega
  simp only [crossesRowLevel, h0, h1]
  by_cases hcross :
      ((planeLift γ j.castSucc).1 = r ∧ (planeLift γ j.succ).1 = r + 1 ∨
       (planeLift γ j.castSucc).1 = r + 1 ∧ (planeLift γ j.succ).1 = r)
  · have hv := hvertical hcross
    simp [hcross, hv, and_comm]
  · simp [hcross, and_comm]

end Ising2DLambda.KacWard
