/-
章「Onsager 閉形式への接続」の
「平行階段の横断座標は両端の水準の間に収まる」
（`claim_parallel_staircase_transverse_width_bound`）の具体版。

人手証明と同じく積の符号による二場合と各段階の範囲を読み、整数横断座標を
`-L |w_h w_v|` 以上 `0` 以下に評価する。住処は ℤ と ℕ だけである。
-/
import Ising2DLambda.KacWard.WindingParallelStaircase
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded
import Ising2DLambda.NecSuf.KacWard.ParallelStaircaseTransverseWidth
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private lemma windingParallelStaircase_transverse_between
    (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s ≤ L * wh.natAbs + L * wv.natAbs) :
    -(L : ℤ) * |wh * wv| ≤
        windingTransverseCoordinate wh wv (windingParallelStaircase L wh wv s) ∧
      windingTransverseCoordinate wh wv (windingParallelStaircase L wh wv s) ≤ 0 := by
  rcases lt_trichotomy wh 0 with hwh | hwh | hwh
  · rcases lt_trichotomy wv 0 with hwv | hwv | hwv
    · have horder : 0 < wh * wv := mul_pos_of_neg_of_neg hwh hwv
      have hwhabs : (wh.natAbs : ℤ) = -wh := by
        rw [← Int.natAbs_neg]
        exact Int.natAbs_of_nonneg (by omega)
      have hwvabs : (wv.natAbs : ℤ) = -wv := by
        rw [← Int.natAbs_neg]
        exact Int.natAbs_of_nonneg (by omega)
      by_cases hphase : s ≤ L * wh.natAbs
      · have hphase' : (s : ℤ) ≤ (L : ℤ) * (wh.natAbs : ℤ) := by exact_mod_cast hphase
        have hlow := mul_le_mul_of_nonpos_left hphase' (le_of_lt hwv)
        have hupp : wv * (s : ℤ) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg
          (le_of_lt hwv) (Int.natCast_nonneg s)
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
          twoPhaseStaircase, hphase, windingTransverseCoordinate,
          Int.sign_eq_neg_one_iff_neg.mpr hwh, abs_of_pos horder]
        constructor <;> nlinarith [hlow, hupp]
      · have hphaseNat : L * wh.natAbs ≤ s := Nat.le_of_not_ge hphase
        have hrNat : s - L * wh.natAbs ≤ L * wv.natAbs := by omega
        have hr : ((s - L * wh.natAbs : ℕ) : ℤ) ≤ (L : ℤ) * (wv.natAbs : ℤ) := by
          exact_mod_cast hrNat
        have hincUpper := mul_le_mul_of_nonneg_left hr (by omega : 0 ≤ -wh)
        have hincNonneg : 0 ≤ (-wh) * ((s - L * wh.natAbs : ℕ) : ℤ) :=
          mul_nonneg (by omega) (Int.natCast_nonneg _)
        have hcoord : windingTransverseCoordinate wh wv
            (windingParallelStaircase L wh wv s) =
            -(L : ℤ) * (wh * wv) + (-wh) * ((s - L * wh.natAbs : ℕ) : ℤ) := by
          simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
            twoPhaseStaircase, hphase, windingTransverseCoordinate,
            Int.sign_eq_neg_one_iff_neg.mpr hwh,
            Int.sign_eq_neg_one_iff_neg.mpr hwv, hwhabs]
          ring
        rw [hcoord, abs_of_pos horder]
        constructor <;> nlinarith
    · subst wv
      constructor <;>
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, twoPhaseStaircase,
          windingTransverseCoordinate] <;> split_ifs <;> simp
    · have hprodneg : wh * wv < 0 := mul_neg_of_neg_of_pos hwh hwv
      have horder : ¬0 < wh * wv := not_lt_of_ge (le_of_lt hprodneg)
      have hwhabs : (wh.natAbs : ℤ) = -wh := by
        rw [← Int.natAbs_neg]
        exact Int.natAbs_of_nonneg (by omega)
      have hwvabs : (wv.natAbs : ℤ) = wv := Int.natAbs_of_nonneg (le_of_lt hwv)
      by_cases hphase : s ≤ L * wv.natAbs
      · have hphase' : (s : ℤ) ≤ (L : ℤ) * (wv.natAbs : ℤ) := by exact_mod_cast hphase
        have hlow := mul_le_mul_of_nonpos_left hphase' (le_of_lt hwh)
        have hupp : wh * (s : ℤ) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg
          (le_of_lt hwh) (Int.natCast_nonneg s)
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
          twoPhaseStaircase, hphase, windingTransverseCoordinate,
          Int.sign_eq_one_iff_pos.mpr hwv, abs_of_neg hprodneg]
        constructor <;> nlinarith [hlow, hupp]
      · have hphaseNat : L * wv.natAbs ≤ s := Nat.le_of_not_ge hphase
        have hrNat : s - L * wv.natAbs ≤ L * wh.natAbs := by omega
        have hr : ((s - L * wv.natAbs : ℕ) : ℤ) ≤ (L : ℤ) * (wh.natAbs : ℤ) := by
          exact_mod_cast hrNat
        have hincUpper := mul_le_mul_of_nonneg_left hr (by omega : 0 ≤ wv)
        have hincNonneg : 0 ≤ wv * ((s - L * wv.natAbs : ℕ) : ℤ) :=
          mul_nonneg (by omega) (Int.natCast_nonneg _)
        have hcoord : windingTransverseCoordinate wh wv
            (windingParallelStaircase L wh wv s) =
            (L : ℤ) * (wh * wv) + wv * ((s - L * wv.natAbs : ℕ) : ℤ) := by
          simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
            twoPhaseStaircase, hphase, windingTransverseCoordinate,
            Int.sign_eq_neg_one_iff_neg.mpr hwh,
            Int.sign_eq_one_iff_pos.mpr hwv, hwvabs]
          ring
        rw [hcoord, abs_of_neg hprodneg]
        constructor <;> nlinarith
  · subst wh
    constructor <;>
      simp [windingParallelStaircase, orderedTwoPhaseStaircase, twoPhaseStaircase,
        windingTransverseCoordinate] <;> split_ifs <;> simp
  · rcases lt_trichotomy wv 0 with hwv | hwv | hwv
    · have hprodneg : wh * wv < 0 := mul_neg_of_pos_of_neg hwh hwv
      have horder : ¬0 < wh * wv := not_lt_of_ge (le_of_lt hprodneg)
      have hwhabs : (wh.natAbs : ℤ) = wh := Int.natAbs_of_nonneg (le_of_lt hwh)
      have hwvabs : (wv.natAbs : ℤ) = -wv := by
        rw [← Int.natAbs_neg]
        exact Int.natAbs_of_nonneg (by omega)
      by_cases hphase : s ≤ L * wv.natAbs
      · have hphase' : (s : ℤ) ≤ (L : ℤ) * (wv.natAbs : ℤ) := by exact_mod_cast hphase
        have hlow := mul_le_mul_of_nonneg_left hphase' (le_of_lt hwh)
        have hupp : wh * (s : ℤ) ≥ 0 := mul_nonneg (le_of_lt hwh) (Int.natCast_nonneg s)
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
          twoPhaseStaircase, hphase, windingTransverseCoordinate,
          Int.sign_eq_neg_one_iff_neg.mpr hwv, abs_of_neg hprodneg]
        constructor <;> nlinarith [hlow, hupp]
      · have hphaseNat : L * wv.natAbs ≤ s := Nat.le_of_not_ge hphase
        have hrNat : s - L * wv.natAbs ≤ L * wh.natAbs := by omega
        have hr : ((s - L * wv.natAbs : ℕ) : ℤ) ≤ (L : ℤ) * (wh.natAbs : ℤ) := by
          exact_mod_cast hrNat
        have hincUpper := mul_le_mul_of_nonneg_left hr (by omega : 0 ≤ -wv)
        have hincNonneg : 0 ≤ (-wv) * ((s - L * wv.natAbs : ℕ) : ℤ) :=
          mul_nonneg (by omega) (Int.natCast_nonneg _)
        have hcoord : windingTransverseCoordinate wh wv
            (windingParallelStaircase L wh wv s) =
            (L : ℤ) * (wh * wv) + (-wv) * ((s - L * wv.natAbs : ℕ) : ℤ) := by
          simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
            twoPhaseStaircase, hphase, windingTransverseCoordinate,
            Int.sign_eq_one_iff_pos.mpr hwh,
            Int.sign_eq_neg_one_iff_neg.mpr hwv, hwvabs]
          ring
        rw [hcoord, abs_of_neg hprodneg]
        constructor <;> nlinarith
    · subst wv
      constructor <;>
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, twoPhaseStaircase,
          windingTransverseCoordinate] <;> split_ifs <;> simp
    · have horder : 0 < wh * wv := mul_pos hwh hwv
      have hwhabs : (wh.natAbs : ℤ) = wh := Int.natAbs_of_nonneg (le_of_lt hwh)
      have hwvabs : (wv.natAbs : ℤ) = wv := Int.natAbs_of_nonneg (le_of_lt hwv)
      by_cases hphase : s ≤ L * wh.natAbs
      · have hphase' : (s : ℤ) ≤ (L : ℤ) * (wh.natAbs : ℤ) := by exact_mod_cast hphase
        have hlow := mul_le_mul_of_nonneg_left hphase' (le_of_lt hwv)
        have hupp : 0 ≤ wv * (s : ℤ) := mul_nonneg (le_of_lt hwv) (Int.natCast_nonneg s)
        simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
          twoPhaseStaircase, hphase, windingTransverseCoordinate,
          Int.sign_eq_one_iff_pos.mpr hwh, abs_of_pos horder]
        constructor <;> nlinarith [hlow, hupp]
      · have hphaseNat : L * wh.natAbs ≤ s := Nat.le_of_not_ge hphase
        have hrNat : s - L * wh.natAbs ≤ L * wv.natAbs := by omega
        have hr : ((s - L * wh.natAbs : ℕ) : ℤ) ≤ (L : ℤ) * (wv.natAbs : ℤ) := by
          exact_mod_cast hrNat
        have hincUpper := mul_le_mul_of_nonneg_left hr (by omega : 0 ≤ wh)
        have hincNonneg : 0 ≤ wh * ((s - L * wh.natAbs : ℕ) : ℤ) :=
          mul_nonneg (by omega) (Int.natCast_nonneg _)
        have hcoord : windingTransverseCoordinate wh wv
            (windingParallelStaircase L wh wv s) =
            -(L : ℤ) * (wh * wv) + wh * ((s - L * wh.natAbs : ℕ) : ℤ) := by
          simp [windingParallelStaircase, orderedTwoPhaseStaircase, horder,
            twoPhaseStaircase, hphase, windingTransverseCoordinate,
            Int.sign_eq_one_iff_pos.mpr hwh,
            Int.sign_eq_one_iff_pos.mpr hwv, hwhabs]
          ring
        rw [hcoord, abs_of_pos horder]
        constructor <;> nlinarith

/-- `claim_parallel_staircase_transverse_width_bound` の幅の具体版。 -/
theorem windingParallelStaircase_transverse_width_bound
    (L : ℕ) (wh wv : ℤ) (Q : ℤ × ℤ) (s : ℕ)
    (hs : s ≤ L * wh.natAbs + L * wv.natAbs) :
    -(L : ℤ) * |wh * wv| ≤
        windingTransverseCoordinate wh wv (Q + windingParallelStaircase L wh wv s) -
          windingTransverseCoordinate wh wv Q ∧
      windingTransverseCoordinate wh wv (Q + windingParallelStaircase L wh wv s) -
          windingTransverseCoordinate wh wv Q ≤ 0 := by
  exact translatedPath_coordinate_between_necSuf
    (windingParallelStaircase L wh wv) Q (windingTransverseCoordinate wh wv)
    (L * wh.natAbs + L * wv.natAbs) (-(L : ℤ) * |wh * wv|) 0
    (fun r hr => windingParallelStaircase_transverse_between L wh wv r hr) s hs

/-- `claim_parallel_staircase_transverse_width_bound` の帯外条件の具体版。 -/
theorem windingParallelStaircase_above_band_avoids_periodicPlaneLift
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wh wv : ℤ) (Q : ℤ × ℤ) (Kmax : ℤ)
    (hbase : Kmax < windingTransverseCoordinate wh wv Q - (L : ℤ) * |wh * wv|)
    (hupper : ∀ k : ℤ, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (s : ℕ) (hs : s ≤ L * wh.natAbs + L * wv.natAbs) (k : ℤ) :
    Q + windingParallelStaircase L wh wv s ≠ periodicPlaneLift m base L wv wh k := by
  apply translatedPath_above_upper_avoids_family_necSuf
    (windingParallelStaircase L wh wv) (periodicPlaneLift m base L wv wh) Q
    (windingTransverseCoordinate wh wv) (L * wh.natAbs + L * wv.natAbs)
    (-(L : ℤ) * |wh * wv|) Kmax
  · intro r hr
    exact (windingParallelStaircase_transverse_between L wh wv r hr).1
  · simpa [sub_eq_add_neg, add_comm] using hbase
  · exact hupper
  · exact hs

end Ising2DLambda.KacWard
