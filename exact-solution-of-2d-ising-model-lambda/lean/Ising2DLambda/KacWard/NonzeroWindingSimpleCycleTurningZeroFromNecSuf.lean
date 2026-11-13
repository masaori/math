/-
「非零巻き付きの頂点単純な閉路の循環総回転数は零である」の導出版。
必要十分版 `nonzero_winding_cycle_turning_zero_necSuf` を、加法群 ℤ、二値 `4`・`-4`、
辺列を実際の閉歩道の一側閉包の射影の回転数（周期数 `c` の `oneSidedClosureProjectedTurning`）として特殊化し、
具体版と同じ結論を得る。周期数差と正負四は具体版と同じ補題から得る。
-/
import Ising2DLambda.KacWard.NonzeroWindingSimpleCycleTurningZero
import Ising2DLambda.NecSuf.KacWard.NonzeroWindingSimpleCycleTurningZero

namespace Ising2DLambda.KacWard

theorem nonzeroWindingSimpleCycle_cyclicTotalTurning_zero_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    cyclicTotalTurning γ hγ = 0 := by
  obtain ⟨k₀, hpm⟩ := oneSidedClosureProjection_cyclicTurning γ hγ hcontact hwind
  let T : ℕ → ℤ := fun c =>
    oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ 1 c
  -- 回転数の関数: 元の辺列（none）と周期数 c の閉包（some c）
  let turn : Option ℕ → ℤ := fun w => w.elim (cyclicTotalTurning γ hγ) T
  have hT (c : ℕ) (hc : 0 < c) : T c = 4 ∨ T c = -4 := by
    have hp := hpm 1 c (by omega) hc
    dsimp only at hp
    obtain ⟨hΓ, hfour⟩ := hp
    rw [cyclicTotalTurning_eq_cyclicAdjacentSum _
      (fun j : ℕ => projectedUnitStep L
        (oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ) (verticalDirectedWindingNumber γ)
          (horizontalDirectedWindingNumber γ) k₀ 1 c j)
        (oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ) (verticalDirectedWindingNumber γ)
            (horizontalDirectedWindingNumber γ) k₀ 1 c (j + 1) -
          oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ) (verticalDirectedWindingNumber γ)
            (horizontalDirectedWindingNumber γ) k₀ 1 c j)) hΓ] at hfour
    exact hfour
  have hdiff (c : ℕ) (hc : 0 < c) : T (c + 1) = T c + cyclicTotalTurning γ hγ := by
    have h := oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 c (by omega) hc
    rw [← cyclicTotalTurning_eq_sum_zmod_directionPairTurning γ hγ] at h
    change T (c + 1) - T c = _ at h
    omega
  exact Ising2DLambda.NecSuf.KacWard.nonzero_winding_cycle_turning_zero_necSuf
    turn none some 4 (-4) (by norm_num) hdiff hT

end Ising2DLambda.KacWard
