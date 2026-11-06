import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinctFromWalk
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 一側閉包の二つの横断階段は、周期部分との接合点を除いて交わらない。 -/
theorem oneSidedStaircasesFromWalk_avoid_periodicLift {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hmax : ∀ i : ℕ,
      windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤
        windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ k₀))
    (t c : ℕ) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    (∀ i < c * (m + 1), ∀ j < b,
      periodicPlaneLiftFromWalk γ (k₀ + i) ≠
        iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j) ∧
    (∀ i < c * (m + 1), ∀ j, 0 < j → j ≤ b →
      periodicPlaneLiftFromWalk γ (k₀ + i) ≠
        iteratedTransverseStaircase wh wv S j) := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  let κ := windingTransverseCoordinate wh wv
  have hκbase : κ (S + c • windingShift L wv wh) = κ S := by
    simp [κ, windingTransverseCoordinate, Prod.smul_mk, windingShift]
    ring
  constructor
  · intro i hi j hj heq
    change periodicPlaneLiftFromWalk γ (k₀ + i) =
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j at heq
    by_cases hj0 : j = 0
    · subst j
      have hbase : iteratedTransverseStaircase wh wv
          (S + c • windingShift L wv wh) 0 =
          periodicPlaneLiftFromWalk γ (k₀ + (c * (m + 1) : ℕ)) := by
        have hzero : iteratedTransverseStaircase wh wv
            (S + c • windingShift L wv wh) 0 = S + c • windingShift L wv wh := by
          simp [iteratedTransverseStaircase, iteratedStaircase,
            windingTransverseStaircase, twoPhaseStaircase]
        rw [hzero]
        simpa [periodicPlaneLiftFromWalk, S, Nat.cast_mul, mul_comm] using
          (periodicPlaneLift_translate (m + 1) L (by omega)
            (planeLiftIntegerBase γ) wv wh k₀ (c : ℤ)).symm
      rw [hbase] at heq
      have hinj := periodicPlaneLiftFromWalk_injective γ hγ hcontact hwind heq
      omega
    · have hstep := (iteratedTransverseStaircase_lower_bound wh wv
        (S + c • windingShift L wv wh) hwind).2.2.1 j
      change κ (S + c • windingShift L wv wh) + (j : ℤ) ≤
        κ (iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) j) at hstep
      have htop := hmax i
      change κ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤ κ S at htop
      rw [heq] at htop
      rw [hκbase] at hstep
      omega
  · intro i hi j hj _ heq
    change periodicPlaneLiftFromWalk γ (k₀ + i) =
      iteratedTransverseStaircase wh wv S j at heq
    have hstep := (iteratedTransverseStaircase_lower_bound wh wv S hwind).2.2.1 j
    change κ S + (j : ℤ) ≤ κ (iteratedTransverseStaircase wh wv S j) at hstep
    have htop := hmax i
    change κ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤ κ S at htop
    rw [heq] at htop
    omega

end Ising2DLambda.KacWard
