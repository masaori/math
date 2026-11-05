import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurningFromWalk
import Ising2DLambda.NecSuf.KacWard.OneSidedThreePeriodTurning

namespace Ising2DLambda.KacWard

/-- 必要十分版へ実際の閉歩道の三周期を代入した導出版。 -/
theorem oneSidedThreePeriodTurningFromWalk_zero_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hpm : ∀ c : ℕ, c = 1 ∨ c = 2 ∨ c = 3 →
      let T := oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ 1 c
      T = 4 ∨ T = -4) :
    (∑ j : ZMod (m + 1),
      directionPairTurning
        (directionNumber (γ ⟨j.val, ZMod.val_lt j⟩))
        (directionNumber (γ ⟨(j + 1).val, ZMod.val_lt (j + 1)⟩))) = 0 := by
  let T : ℕ → ℤ := fun c =>
    oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ 1 c
  let b : ℤ := ∑ j : ZMod (m + 1),
    directionPairTurning
      (directionNumber (γ ⟨j.val, ZMod.val_lt j⟩))
      (directionNumber (γ ⟨(j + 1).val, ZMod.val_lt (j + 1)⟩))
  have h12 : T 2 - T 1 = b :=
    oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 1
      (by omega) (by omega)
  have h23 : T 3 - T 2 = b :=
    oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 2
      (by omega) (by omega)
  exact Ising2DLambda.NecSuf.KacWard.threePeriod_difference_zero_necSuf T b 4 (-4)
    (by norm_num) h12 h23
    (hpm 1 (by omega)) (hpm 2 (by omega)) (hpm 3 (by omega))

end Ising2DLambda.KacWard
