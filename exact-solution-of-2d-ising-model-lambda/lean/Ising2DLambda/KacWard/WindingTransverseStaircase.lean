/-
章「Onsager 閉形式への接続」の「横断階段の各歩は横断水準を増やす単位歩である」
（`claim_winding_transverse_staircase_step_increase`）の具体版。

人手証明と同じ二場合で隣接差を求め、整数横断座標の増分を整数の絶対値へ戻す。
住処は ℤ と ℕ だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.NecSuf.KacWard.WindingTransverseStaircase
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_winding_transverse_staircase`。巻き付きベクトルを正に横切る整数格子の階段。 -/
def windingTransverseStaircase (wh wv : ℤ) : ℕ → ℤ × ℤ :=
  twoPhaseStaircase wh.natAbs (Int.sign wh, 0) (0, -Int.sign wv)

private lemma horizontalStep_transverseCoordinate_pos (wh wv : ℤ)
    (hH : 0 < wh.natAbs) :
    0 < windingTransverseCoordinate wh wv (Int.sign wh, 0) := by
  simp only [windingTransverseCoordinate, AddMonoidHom.coe_mk, ZeroHom.coe_mk,
    mul_zero, sub_zero]
  rw [mul_comm, Int.sign_mul_self]
  exact_mod_cast hH

private lemma verticalStep_transverseCoordinate_pos (wh wv : ℤ)
    (hV : 0 < wv.natAbs) :
    0 < windingTransverseCoordinate wh wv (0, -Int.sign wv) := by
  simp only [windingTransverseCoordinate, AddMonoidHom.coe_mk, ZeroHom.coe_mk,
    mul_zero, zero_sub, mul_neg, neg_neg]
  rw [mul_comm, Int.sign_mul_self]
  exact_mod_cast hV

/-- `claim_winding_transverse_staircase_step_increase`。
各隣接差は四つの単位格子ベクトルの一つであり、横断座標を真に増やす。 -/
theorem windingTransverseStaircase_step_increase (wh wv : ℤ) (s : ℕ)
    (hs : s < wh.natAbs + wv.natAbs) :
    let difference := windingTransverseStaircase wh wv (s + 1) -
      windingTransverseStaircase wh wv s
    (difference = (1, 0) ∨ difference = (-1, 0) ∨
      difference = (0, 1) ∨ difference = (0, -1)) ∧
    windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv s) <
      windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv (s + 1)) := by
  have hstep := twoPhaseStaircase_step_necSuf wh.natAbs wv.natAbs
    (Int.sign wh, 0) (0, -Int.sign wv) (windingTransverseCoordinate wh wv)
    (horizontalStep_transverseCoordinate_pos wh wv)
    (verticalStep_transverseCoordinate_pos wh wv) s hs
  dsimp [windingTransverseStaircase]
  constructor
  · by_cases hphase : s < wh.natAbs
    · rw [hstep.1, if_pos hphase]
      have hne : wh ≠ 0 := Int.natAbs_ne_zero.mp (by omega)
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · right; left
        rw [Int.sign_eq_neg_one_iff_neg.mpr hneg]
      · left
        rw [Int.sign_eq_one_iff_pos.mpr hpos]
    · rw [hstep.1, if_neg hphase]
      have hV : 0 < wv.natAbs := by omega
      have hne : wv ≠ 0 := Int.natAbs_ne_zero.mp (by omega)
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · right; right; left
        rw [Int.sign_eq_neg_one_iff_neg.mpr hneg]
        norm_num
      · right; right; right
        rw [Int.sign_eq_one_iff_pos.mpr hpos]
  · exact hstep.2

/-- 横断座標が各歩で真に増えるので、横断階段の頂点はすべて相異なる。 -/
theorem windingTransverseStaircase_injOn (wh wv : ℤ) :
    Set.InjOn (windingTransverseStaircase wh wv)
      (Set.Iic (wh.natAbs + wv.natAbs)) := by
  exact twoPhaseStaircase_injOn_necSuf wh.natAbs wv.natAbs
    (Int.sign wh, 0) (0, -Int.sign wv) (windingTransverseCoordinate wh wv)
    (horizontalStep_transverseCoordinate_pos wh wv)
    (verticalStep_transverseCoordinate_pos wh wv)

end Ising2DLambda.KacWard
