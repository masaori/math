/-
章「Onsager 閉形式への接続」の
「平行階段の各歩は平行座標を増やす単位歩である」
（`claim_winding_parallel_staircase_step_increase`）の具体版。

人手証明と同じ積の符号による二場合で歩の順序を選び、各差が単位格子ベクトルで
あることと整数平行座標の真の増加を示す。住処は ℤ と ℕ だけである。
-/
import Ising2DLambda.KacWard.WindingTransverseStaircase
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease
import Ising2DLambda.NecSuf.KacWard.WindingParallelStaircase
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_winding_parallel_staircase`。巻き付きベクトルに平行な正の整数格子階段。 -/
def windingParallelStaircase (L : ℕ) (wh wv : ℤ) : ℕ → ℤ × ℤ :=
  orderedTwoPhaseStaircase (0 < wh * wv)
    (L * wh.natAbs) (L * wv.natAbs)
    (0, Int.sign wh) (Int.sign wv, 0)

private lemma natAbs_pos_of_product_pos (L : ℕ) (w : ℤ)
    (h : 0 < L * w.natAbs) : 0 < w.natAbs := by
  by_contra hnot
  have hz : w.natAbs = 0 := Nat.eq_zero_of_not_pos hnot
  simp [hz] at h

private lemma horizontalStep_parallelCoordinate_pos (wh wv : ℤ)
    (hH : 0 < wh.natAbs) :
    0 < windingParallelCoordinate wv wh (0, Int.sign wh) := by
  simp only [windingParallelCoordinate, AddMonoidHom.coe_mk, ZeroHom.coe_mk,
    mul_zero, zero_add]
  rw [mul_comm, Int.sign_mul_self]
  exact_mod_cast hH

private lemma verticalStep_parallelCoordinate_pos (wh wv : ℤ)
    (hV : 0 < wv.natAbs) :
    0 < windingParallelCoordinate wv wh (Int.sign wv, 0) := by
  simp only [windingParallelCoordinate, AddMonoidHom.coe_mk, ZeroHom.coe_mk,
    mul_zero, add_zero]
  rw [mul_comm, Int.sign_mul_self]
  exact_mod_cast hV

private lemma horizontalStep_isUnit (wh : ℤ) (hwh : wh ≠ 0) :
    ((0 : ℤ), Int.sign wh) = (1, 0) ∨ ((0 : ℤ), Int.sign wh) = (-1, 0) ∨
      ((0 : ℤ), Int.sign wh) = (0, 1) ∨ ((0 : ℤ), Int.sign wh) = (0, -1) := by
  rcases lt_or_gt_of_ne hwh with hneg | hpos
  · right; right; right
    rw [Int.sign_eq_neg_one_iff_neg.mpr hneg]
  · right; right; left
    rw [Int.sign_eq_one_iff_pos.mpr hpos]

private lemma verticalStep_isUnit (wv : ℤ) (hwv : wv ≠ 0) :
    (Int.sign wv, (0 : ℤ)) = (1, 0) ∨ (Int.sign wv, (0 : ℤ)) = (-1, 0) ∨
      (Int.sign wv, (0 : ℤ)) = (0, 1) ∨ (Int.sign wv, (0 : ℤ)) = (0, -1) := by
  rcases lt_or_gt_of_ne hwv with hneg | hpos
  · right; left
    rw [Int.sign_eq_neg_one_iff_neg.mpr hneg]
  · left
    rw [Int.sign_eq_one_iff_pos.mpr hpos]

/-- `claim_winding_parallel_staircase_step_increase`。
各隣接差は四つの単位格子ベクトルの一つであり、平行座標を真に増やす。 -/
theorem windingParallelStaircase_step_increase (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs) :
    let difference := windingParallelStaircase L wh wv (s + 1) -
      windingParallelStaircase L wh wv s
    (difference = (1, 0) ∨ difference = (-1, 0) ∨
      difference = (0, 1) ∨ difference = (0, -1)) ∧
    windingParallelCoordinate wv wh (windingParallelStaircase L wh wv s) <
      windingParallelCoordinate wv wh (windingParallelStaircase L wh wv (s + 1)) := by
  have hfirst : 0 < L * wh.natAbs →
      0 < windingParallelCoordinate wv wh (0, Int.sign wh) := by
    intro h
    exact horizontalStep_parallelCoordinate_pos wh wv (natAbs_pos_of_product_pos L wh h)
  have hsecond : 0 < L * wv.natAbs →
      0 < windingParallelCoordinate wv wh (Int.sign wv, 0) := by
    intro h
    exact verticalStep_parallelCoordinate_pos wh wv (natAbs_pos_of_product_pos L wv h)
  have hstep := orderedTwoPhaseStaircase_step_necSuf
    (0 < wh * wv) (L * wh.natAbs) (L * wv.natAbs)
    (0, Int.sign wh) (Int.sign wv, 0) (windingParallelCoordinate wv wh)
    hfirst hsecond s hs
  dsimp [windingParallelStaircase]
  constructor
  · rw [hstep.1]
    by_cases horder : 0 < wh * wv
    · simp only [if_pos horder]
      by_cases hphase : s < L * wh.natAbs
      · rw [if_pos hphase]
        have hprod : 0 < L * wh.natAbs := by omega
        exact horizontalStep_isUnit wh
          (Int.natAbs_ne_zero.mp (Nat.ne_of_gt (natAbs_pos_of_product_pos L wh hprod)))
      · rw [if_neg hphase]
        have hprod : 0 < L * wv.natAbs := by omega
        exact verticalStep_isUnit wv
          (Int.natAbs_ne_zero.mp (Nat.ne_of_gt (natAbs_pos_of_product_pos L wv hprod)))
    · simp only [if_neg horder]
      by_cases hphase : s < L * wv.natAbs
      · rw [if_pos hphase]
        have hprod : 0 < L * wv.natAbs := by omega
        exact verticalStep_isUnit wv
          (Int.natAbs_ne_zero.mp (Nat.ne_of_gt (natAbs_pos_of_product_pos L wv hprod)))
      · rw [if_neg hphase]
        have hprod : 0 < L * wh.natAbs := by omega
        exact horizontalStep_isUnit wh
          (Int.natAbs_ne_zero.mp (Nat.ne_of_gt (natAbs_pos_of_product_pos L wh hprod)))
  · exact hstep.2

/-- 平行座標が各歩で真に増えるので、平行階段の頂点はすべて相異なる。 -/
theorem windingParallelStaircase_injOn (L : ℕ) (wh wv : ℤ) :
    Set.InjOn (windingParallelStaircase L wh wv)
      (Set.Iic (L * wh.natAbs + L * wv.natAbs)) := by
  apply orderedTwoPhaseStaircase_injOn_necSuf
    (0 < wh * wv) (L * wh.natAbs) (L * wv.natAbs)
    (0, Int.sign wh) (Int.sign wv, 0) (windingParallelCoordinate wv wh)
  · intro h
    exact horizontalStep_parallelCoordinate_pos wh wv (natAbs_pos_of_product_pos L wh h)
  · intro h
    exact verticalStep_parallelCoordinate_pos wh wv (natAbs_pos_of_product_pos L wv h)

end Ising2DLambda.KacWard
