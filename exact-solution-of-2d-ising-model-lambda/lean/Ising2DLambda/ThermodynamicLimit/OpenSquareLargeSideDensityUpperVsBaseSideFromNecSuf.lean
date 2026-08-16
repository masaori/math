/-
「基準辺の平方以上の辺の密度の基準辺の密度による一様な上からの評価（q は 1 以下）」の具体版を、
必要十分版 `upper_bound_enlarge_first_two_terms_necSuf` の特殊化として導く。
準備の第一〜第四（自然数の除法・ℚ の係数・符号・有理数倍の比較）は具体版と同じで、
本体（加法単調性・交換則・推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSideDensityUpperVsBaseSide
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareLargeSideDensityUpperVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one_from_necSuf
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) (hsq : a ^ 2 ≤ L)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
        ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q)) +
        openScaledFreeEntropy a q) := by
  have ha1 : 1 ≤ a := Nat.pos_of_ne_zero (NeZero.ne a)
  obtain ⟨k, hk1, hkL, hLk⟩ := exists_multiple_side_below_of_lt a L ha1 haL
  haveI : NeZero k := ⟨by omega⟩
  have haq : (0 : ℚ) < (a : ℚ) := by exact_mod_cast ha1
  have hsqq : ((a : ℚ) ^ 2) ≤ (L : ℚ) := by exact_mod_cast hsq
  have hc2 : (2 * (a : ℚ)) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) := by
    calc (2 * (a : ℚ)) / (L : ℚ) ≤ (2 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (2 : ℚ) / (a : ℚ) := by field_simp
  have hc4 : (4 * (a : ℚ)) / (L : ℚ) ≤ (4 : ℚ) / (a : ℚ) := by
    calc (4 * (a : ℚ)) / (L : ℚ) ≤ (4 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (4 : ℚ) / (a : ℚ) := by field_simp
  have hA := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc2
    rationalLogOrderLE_zero_toRational_generator_two
  have hB := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc4
    (rationalLogOrderLE_zero_toRational_logRat_one_add hq0)
  have hup := rationalLogOrderLE_openSquareNonMultipleSideDensity_upper_vs_baseSide_of_le_one
    a k L hkL hLk hq0 hq1
  exact NecSuf.ThermodynamicLimit.upper_bound_enlarge_first_two_terms_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    _ _ _ _ _ _ hup hA hB

end Ising2DLambda.ThermodynamicLimit
