import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurningFromWalk
import Ising2DLambda.KacWard.ThreeTermPmFourDifferenceZero

namespace Ising2DLambda.KacWard

/-- 実際の閉歩道の三つの一側閉包の回転和が正負四なら、元の周期方向の回転和は零。 -/
theorem oneSidedThreePeriodTurningFromWalk_zero {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hfirst : oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 1 = 4 ∨
      oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 1 = -4)
    (hsecond : oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 2 = 4 ∨
      oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 2 = -4)
    (hthird : oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 3 = 4 ∨
      oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
      k₀ 1 3 = -4) :
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
  have h12 : T 2 - T 1 = b := by
    exact oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 1
      (by omega) (by omega)
  have h23 : T 3 - T 2 = b := by
    exact oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 2
      (by omega) (by omega)
  change T 2 = 4 ∨ T 2 = -4 at hsecond
  change T 3 = 4 ∨ T 3 = -4 at hthird
  have hthree := threeTermPmFour_difference_zero (T 1 - b) b
    (by simpa only [sub_add_cancel] using hfirst)
    (by rcases hsecond with h | h <;> [left; right] <;> omega)
    (by rcases hthird with h | h <;> [left; right] <;> omega)
  exact hthree.1

end Ising2DLambda.KacWard
