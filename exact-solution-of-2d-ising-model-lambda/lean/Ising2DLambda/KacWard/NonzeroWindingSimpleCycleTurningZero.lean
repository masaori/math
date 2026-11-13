/-
章「Onsager 閉形式への接続」の
「非零巻き付きの頂点単純な閉路の循環総回転数は零である」
（`claim_nonzero_winding_simple_cycle_turning_zero`）の具体版。

人手証明と同じ順に組む。一側閉包の基点 `k₀` と反復回数 `t = 1` を取り、
周期数 `c = 1, 2, 3` の一側閉包の射影 `Γ_c` を作る。整数 `a := t∘(Γ_1) - t∘(γ)`、`b := t∘(γ)` について
`a + c b = t∘(Γ_c)` を周期数差の等式（`claim_one_sided_closure_period_difference_turning` の具体版）で示し、
`t∘(Γ_c) ∈ {4, -4}`（`claim_one_sided_closure_projection_cyclic_turning` の具体版）と合わせて
三項の補題（`claim_three_term_pm_four_difference_zero` の具体版）へ渡す。

周期数差の具体版は、閉包の回転数を巡回隣接和 `oneSidedClosureProjectedTurning` で、
元の辺列の回転数を `ZMod (m + 1)` 上の方向対の回転数の和で述べている。両者を
循環総回転数 `cyclicTotalTurning` の定義へ戻す二つの補題を先に置く（定義どうしの対応）。
住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.OneSidedClosureProjectionCyclicTurning
import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurningFromWalk
import Ising2DLambda.KacWard.ThreeTermPmFourDifferenceZero
import Ising2DLambda.KacWard.StepTurningDirectionPair
import Ising2DLambda.KacWard.WalkBoundaryVertexTurnSum

open scoped BigOperators

namespace Ising2DLambda.KacWard

/-- 辺の列 `u` の最初の `n` 本を閉じた非後退辺列として読むと、その循環総回転数は
隣り合う二本（最後の辺から最初の辺へも）の方向対の回転数の和に等しい。
右辺は一側閉包の回転数 `oneSidedClosureProjectedTurning` の定義を展開した形である。 -/
theorem cyclicTotalTurning_eq_cyclicAdjacentSum {L : ℕ} [NeZero L]
    (n : ℕ) (u : ℕ → OrientedEdge L)
    (hΓ : closedNonbacktrackingWalk (fun j : Fin (n - 1 + 1) => u j.val)) :
    cyclicTotalTurning (fun j : Fin (n - 1 + 1) => u j.val) hΓ =
      (∑ s ∈ Finset.range (n - 1),
          directionPairTurning (directionNumber (u s)) (directionNumber (u (s + 1)))) +
        directionPairTurning (directionNumber (u (n - 1))) (directionNumber (u 0)) := by
  rw [cyclicTotalTurning_eq, edgeSequenceTotalTurning]
  congr 1
  · -- 最後以外の各歩: 非後退なので一歩の回転数は方向対の回転数
    rw [← Fin.sum_univ_eq_sum_range]
    refine Finset.sum_congr rfl (fun i _ => ?_)
    rw [stepTurning_eq_directionPairTurning _ _ (hΓ.1 i)]
    simp
  · -- 閉じ目の一歩
    rw [stepTurning_eq_directionPairTurning _ _ hΓ.2]
    simp

/-- 周期数差の具体版が述べる `ZMod (m + 1)` 上の方向対の回転数の和は、元の辺列の循環総回転数である。 -/
theorem cyclicTotalTurning_eq_sum_zmod_directionPairTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    cyclicTotalTurning γ hγ =
      ∑ j : ZMod (m + 1),
        directionPairTurning
          (directionNumber (γ ⟨j.val, ZMod.val_lt j⟩))
          (directionNumber (γ ⟨(j + 1).val, ZMod.val_lt (j + 1)⟩)) := by
  rw [cyclicTotalTurning_eq_sum_finRotate]
  -- `ZMod (m + 1)` は `Fin (m + 1)` で、`j + 1` は巡回の後続 `finRotate (m + 1) j` である
  change _ = ∑ j : Fin (m + 1),
    directionPairTurning (directionNumber (γ ⟨j.val, j.isLt⟩))
      (directionNumber (γ ⟨(j + 1).val, (j + 1).isLt⟩))
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [stepTurning_eq_directionPairTurning _ _
    (closedNonbacktrackingWalk_finRotate_successor γ hγ j), finRotate_apply]

/-- `claim_nonzero_winding_simple_cycle_turning_zero` の具体版。 -/
theorem nonzeroWindingSimpleCycle_cyclicTotalTurning_zero {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    cyclicTotalTurning γ hγ = 0 := by
  -- 一側閉包の基点 k₀ と、射影の循環総回転数が正負四であること
  obtain ⟨k₀, hpm⟩ := oneSidedClosureProjection_cyclicTurning γ hγ hcontact hwind
  -- 反復回数 t = 1、周期数 c の一側閉包の射影の循環総回転数 t∘(Γ_c)
  let T : ℕ → ℤ := fun c =>
    oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ 1 c
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
    -- 右辺は T c の定義を展開した形
    exact hfour
  -- 周期数差の等式（c = 1, 2）
  have hdiff (c : ℕ) (hc : 0 < c) : T (c + 1) - T c = cyclicTotalTurning γ hγ := by
    rw [cyclicTotalTurning_eq_sum_zmod_directionPairTurning]
    exact oneSidedClosureFromWalk_periodDifferenceTurning γ hγ hwind k₀ 1 c
      (by omega) hc
  -- 本文の a, b
  let b : ℤ := cyclicTotalTurning γ hγ
  let a : ℤ := T 1 - b
  have h1 : a + 1 * b = T 1 := by
    calc a + 1 * b = T 1 - b + b := by simp [a]   -- a, b の定義
      _ = T 1 := by ring                           -- ℤ の四則
  have h2 : a + 2 * b = T 2 := by
    calc a + 2 * b = T 1 + b := by simp only [a]; ring   -- a, b の定義と ℤ の四則
      _ = T 2 := by have h12 : T 2 - T 1 = b := hdiff 1 (by omega); omega   -- 周期数差 c = 1
  have h3 : a + 3 * b = T 3 := by
    calc a + 3 * b = T 2 + b := by rw [← h2]; ring       -- 上の a + 2b = T 2 と ℤ の四則
      _ = T 3 := by have h23 : T 3 - T 2 = b := hdiff 2 (by omega); omega   -- 周期数差 c = 2
  have hthree := threeTermPmFour_difference_zero a b
    (by rw [one_mul] at h1; rw [h1]; exact hT 1 (by omega))
    (by rw [h2]; exact hT 2 (by omega))
    (by rw [h3]; exact hT 3 (by omega))
  exact hthree.1

end Ising2DLambda.KacWard
