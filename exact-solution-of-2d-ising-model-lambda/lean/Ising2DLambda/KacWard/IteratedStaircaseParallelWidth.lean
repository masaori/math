/-
章「Onsager 閉形式への接続」の「反復横断階段の平行座標は基点から幅以内に収まる」
（`claim_iterated_staircase_parallel_width_bound`）の具体版。

人手証明と同じく、周期方向の平行座標が零であることを計算し、横断階段の二つの区間を
それぞれ端点 `0` と `wh * wv` の間に評価する。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease
import Ising2DLambda.NecSuf.KacWard.IteratedStaircaseParallelWidth
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private lemma signedPrefix_between (a b : ℤ) (n : ℕ) (hn : n ≤ a.natAbs) :
    min 0 (a * b) ≤ b * ((n : ℤ) * Int.sign a) ∧
      b * ((n : ℤ) * Int.sign a) ≤ max 0 (a * b) := by
  by_cases ha : a = 0
  · subst a
    simp
  rcases lt_or_gt_of_ne ha with haNeg | haPos
  · have hnz : (n : ℤ) ≤ -a := by
      have : (n : ℤ) ≤ (a.natAbs : ℤ) := by exact_mod_cast hn
      simpa [Int.natCast_natAbs, abs_of_neg haNeg] using this
    rw [Int.sign_eq_neg_one_iff_neg.mpr haNeg]
    simp only [mul_neg, mul_one]
    by_cases hb : b < 0
    · have hprod : 0 ≤ a * b := mul_nonneg_of_nonpos_of_nonpos (le_of_lt haNeg) (le_of_lt hb)
      rw [min_eq_left hprod, max_eq_right hprod]
      constructor
      · have hbn : b * (n : ℤ) ≤ 0 :=
          mul_nonpos_of_nonpos_of_nonneg (le_of_lt hb) (by positivity)
        simpa using neg_nonneg.mpr hbn
      · have := mul_le_mul_of_nonpos_left (show a ≤ -(n : ℤ) by omega) (le_of_lt hb)
        nlinarith
    · have hbNonneg : 0 ≤ b := by omega
      have hprod : a * b ≤ 0 := mul_nonpos_of_nonpos_of_nonneg (le_of_lt haNeg) hbNonneg
      rw [min_eq_right hprod, max_eq_left hprod]
      constructor
      · have := mul_le_mul_of_nonneg_left (show a ≤ -(n : ℤ) by omega) hbNonneg
        nlinarith
      · have hbn : 0 ≤ b * (n : ℤ) := mul_nonneg hbNonneg (by positivity)
        simpa using neg_nonpos.mpr hbn
  · have hnz : (n : ℤ) ≤ a := by
      have : (n : ℤ) ≤ (a.natAbs : ℤ) := by exact_mod_cast hn
      simpa [Int.natAbs_of_nonneg (le_of_lt haPos)] using this
    rw [Int.sign_eq_one_iff_pos.mpr haPos]
    simp only [mul_one]
    by_cases hb : b < 0
    · have hprod : a * b ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (le_of_lt haPos) (le_of_lt hb)
      rw [min_eq_right hprod, max_eq_left hprod]
      constructor
      · have := mul_le_mul_of_nonpos_left hnz (le_of_lt hb)
        nlinarith
      · exact mul_nonpos_of_nonpos_of_nonneg (le_of_lt hb) (by positivity)
    · have hbNonneg : 0 ≤ b := by omega
      have hprod : 0 ≤ a * b := mul_nonneg (le_of_lt haPos) hbNonneg
      rw [min_eq_left hprod, max_eq_right hprod]
      constructor
      · exact mul_nonneg hbNonneg (by positivity)
      · have := mul_le_mul_of_nonneg_left hnz hbNonneg
        nlinarith

private lemma windingTransverseStaircase_parallel_between
    (wh wv : ℤ) (r : ℕ) (hr : r < wh.natAbs + wv.natAbs) :
    min 0 (wh * wv) ≤
        windingParallelCoordinate wv wh (windingTransverseStaircase wh wv r) ∧
      windingParallelCoordinate wv wh (windingTransverseStaircase wh wv r) ≤
        max 0 (wh * wv) := by
  by_cases hphase : r ≤ wh.natAbs
  · simpa [windingTransverseStaircase, twoPhaseStaircase, hphase,
      windingParallelCoordinate, mul_comm] using signedPrefix_between wh wv r hphase
  · have hrest : r - wh.natAbs ≤ wv.natAbs := by omega
    have hpref := signedPrefix_between wv wh (r - wh.natAbs) hrest
    have hcoord :
        windingParallelCoordinate wv wh (windingTransverseStaircase wh wv r) =
          wh * wv - wh * (((r - wh.natAbs : ℕ) : ℤ) * Int.sign wv) := by
      simp [windingTransverseStaircase, twoPhaseStaircase, hphase,
        windingParallelCoordinate]
      rw [show |wh| * Int.sign wh = wh by
        simpa [mul_comm] using Int.sign_mul_abs wh]
      ring
    rw [hcoord]
    rw [mul_comm wv wh] at hpref
    by_cases hprod : 0 ≤ wh * wv
    · rw [min_eq_left hprod, max_eq_right hprod] at hpref ⊢
      omega
    · have hprod' : wh * wv ≤ 0 := by omega
      rw [min_eq_right hprod', max_eq_left hprod'] at hpref ⊢
      omega

/-- `claim_iterated_staircase_parallel_width_bound`。 -/
theorem iteratedTransverseStaircase_parallel_width_bound
    (wh wv : ℤ) (base : ℤ × ℤ) (hwind : (wh, wv) ≠ (0, 0)) (s : ℕ) :
    min 0 (wh * wv) ≤
        windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s) -
          windingParallelCoordinate wv wh base ∧
      windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s) -
          windingParallelCoordinate wv wh base ≤ max 0 (wh * wv) := by
  have hn : 0 < wh.natAbs + wv.natAbs := by
    by_contra hnot
    have hsum : wh.natAbs + wv.natAbs = 0 := by omega
    have hparts := Nat.add_eq_zero_iff.mp hsum
    exact hwind (Prod.ext (Int.natAbs_eq_zero.mp hparts.1) (Int.natAbs_eq_zero.mp hparts.2))
  have hperiod : windingParallelCoordinate wv wh (wh, -wv) = 0 := by
    simp [windingParallelCoordinate]
    ring
  exact iteratedStaircase_coordinate_between_necSuf
    (wh.natAbs + wv.natAbs) (windingTransverseStaircase wh wv) (wh, -wv) base
    (windingParallelCoordinate wv wh) (min 0 (wh * wv)) (max 0 (wh * wv))
    hn hperiod (windingTransverseStaircase_parallel_between wh wv) s

end Ising2DLambda.KacWard
