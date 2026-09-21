/-
章「Onsager 閉形式への接続」の「反復横断階段は非零の周期並進と交わらない」
（`claim_period_translates_of_iterated_staircase_disjoint`）の具体版。

人手証明と同じく、反復階段の平行座標幅と周期並進の平行座標増分を比較する。
住処は ℤ だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease
import Ising2DLambda.NecSuf.KacWard.PeriodTranslatesOfIteratedStaircase
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private lemma signed_prefix_between (a b : ℤ) (n : ℕ) (hn : n ≤ a.natAbs) :
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
    (wh wv : ℤ) (r : ℕ) (hr : r ≤ wh.natAbs + wv.natAbs) :
    min 0 (wh * wv) ≤
        windingParallelCoordinate wv wh (windingTransverseStaircase wh wv r) ∧
      windingParallelCoordinate wv wh (windingTransverseStaircase wh wv r) ≤
        max 0 (wh * wv) := by
  by_cases hphase : r ≤ wh.natAbs
  · simpa [windingTransverseStaircase, twoPhaseStaircase, hphase,
      windingParallelCoordinate, mul_comm] using signed_prefix_between wh wv r hphase
  · have hrest : r - wh.natAbs ≤ wv.natAbs := by omega
    have hpref := signed_prefix_between wv wh (r - wh.natAbs) hrest
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

private lemma iteratedTransverseStaircase_parallel_pair_width
    (wh wv : ℤ) (base : ℤ × ℤ) (hwind : (wh, wv) ≠ (0, 0)) (s s' : ℕ) :
    |windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s) -
      windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s')| ≤
      |wh * wv| := by
  have hn : 0 < wh.natAbs + wv.natAbs := by
    by_contra hnot
    have hsum : wh.natAbs + wv.natAbs = 0 := by omega
    have hparts := Nat.add_eq_zero_iff.mp hsum
    exact hwind (Prod.ext (Int.natAbs_eq_zero.mp hparts.1) (Int.natAbs_eq_zero.mp hparts.2))
  have hoffset : ∀ u : ℕ,
      windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base u) -
          windingParallelCoordinate wv wh base =
        windingParallelCoordinate wv wh
          (windingTransverseStaircase wh wv (u % (wh.natAbs + wv.natAbs))) := by
    intro u
    simp [iteratedTransverseStaircase, iteratedStaircase,
      windingParallelCoordinate]
    ring
  have hsBounds := windingTransverseStaircase_parallel_between wh wv
    (s % (wh.natAbs + wv.natAbs)) (Nat.le_of_lt (Nat.mod_lt s hn))
  have hs'Bounds := windingTransverseStaircase_parallel_between wh wv
    (s' % (wh.natAbs + wv.natAbs)) (Nat.le_of_lt (Nat.mod_lt s' hn))
  rw [← hoffset s] at hsBounds
  rw [← hoffset s'] at hs'Bounds
  by_cases hprod : 0 ≤ wh * wv
  · rw [min_eq_left hprod, max_eq_right hprod] at hsBounds hs'Bounds
    rw [abs_of_nonneg hprod, abs_le]
    omega
  · have hprod' : wh * wv < 0 := by omega
    rw [min_eq_right (le_of_lt hprod'), max_eq_left (le_of_lt hprod')] at hsBounds hs'Bounds
    rw [abs_of_neg hprod', abs_le]
    omega

/-- `claim_period_translates_of_iterated_staircase_disjoint`。 -/
theorem iteratedTransverseStaircase_ne_period_translate
    (L : ℕ) (hL : 0 < L) (wv wh : ℤ) (hwind : (wh, wv) ≠ (0, 0))
    (base : ℤ × ℤ) (t s s' : ℕ) (_ht : 1 ≤ t)
    (_hs : s ≤ t * (wh.natAbs + wv.natAbs))
    (_hs' : s' ≤ t * (wh.natAbs + wv.natAbs))
    (z : ℤ) (hz : z ≠ 0) :
    iteratedTransverseStaircase wh wv base s ≠
      iteratedTransverseStaircase wh wv base s' + z • windingShift L wv wh := by
  have hwind' : wv ≠ 0 ∨ wh ≠ 0 := by
    by_cases hwv : wv = 0
    · right
      intro hwh
      exact hwind (Prod.ext hwh hwv)
    · exact Or.inl hwv
  have hsumNonneg : 0 ≤ wv ^ 2 + wh ^ 2 := by positivity
  have hsumDominates : |wh * wv| < wv ^ 2 + wh ^ 2 := by
    rw [abs_mul]
    have ha : 0 ≤ |wh| := abs_nonneg wh
    have hb : 0 ≤ |wv| := abs_nonneg wv
    have hsqWh : wh ^ 2 = |wh| ^ 2 := by rw [sq_abs]
    have hsqWv : wv ^ 2 = |wv| ^ 2 := by rw [sq_abs]
    rw [hsqWh, hsqWv]
    rcases hwind' with hwv | hwh
    · have hbPos : 1 ≤ |wv| := Int.one_le_abs hwv
      nlinarith [sq_nonneg (|wh| - |wv|), mul_nonneg ha hb]
    · have haPos : 1 ≤ |wh| := Int.one_le_abs hwh
      nlinarith [sq_nonneg (|wh| - |wv|), mul_nonneg ha hb]
  have hperiod : |wh * wv| < (L : ℤ) * (wv ^ 2 + wh ^ 2) := by
    have hLz : 1 ≤ (L : ℤ) := by omega
    have hmul : wv ^ 2 + wh ^ 2 ≤ (L : ℤ) * (wv ^ 2 + wh ^ 2) := by nlinarith
    exact lt_of_lt_of_le hsumDominates hmul
  exact bounded_family_avoids_nonzero_integer_translates_necSuf
    (iteratedTransverseStaircase wh wv base)
    (fun z point => point + z • windingShift L wv wh)
    (windingParallelCoordinate wv wh)
    |wh * wv| ((L : ℤ) * (wv ^ 2 + wh ^ 2))
    (fun i j => iteratedTransverseStaircase_parallel_pair_width wh wv base hwind i j)
    (by
      intro z point
      rw [map_add, map_zsmul, windingParallelCoordinate_windingShift]
      ring)
    hperiod s s' z hz

end Ising2DLambda.KacWard
