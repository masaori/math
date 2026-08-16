/-
「基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（q は 1 以下）」の具体版を、
必要十分版 `lower_bound_shrink_first_and_last_terms_necSuf` の特殊化として導く。
準備の第一〜第四（自然数の除法・ℚ の係数・符号・有理数倍の比較）と分配則は具体版と同じで、
本体（加法単調性・交換則・推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSideDensityLowerVsBaseSide
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareLargeSideDensityLowerVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareLargeSideDensity_lower_vs_baseSide_of_le_one_from_necSuf
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) (hsq : a ^ 2 ≤ L)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (((4 : ℚ) / (a : ℚ)) • toRational (logRat q) +
        openScaledFreeEntropy a q +
        -(((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))))
      (openScaledFreeEntropy L q) := by
  have ha1 : 1 ≤ a := Nat.pos_of_ne_zero (NeZero.ne a)
  obtain ⟨k, hk1, hkL, hLk⟩ := exists_multiple_side_below_of_lt a L ha1 haL
  haveI : NeZero k := ⟨by omega⟩
  set C : RationalLogOrderGroup :=
    toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) with hC
  set v : RationalLogOrderGroup := toRational (logRat q) with hv
  have haq : (0 : ℚ) < (a : ℚ) := by exact_mod_cast ha1
  have haLq : (a : ℚ) ≤ (L : ℚ) := by exact_mod_cast haL.le
  have hsqq : ((a : ℚ) ^ 2) ≤ (L : ℚ) := by exact_mod_cast hsq
  have hcL : (2 : ℚ) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) :=
    div_le_div_of_nonneg_left (by norm_num) haq haLq
  have hc2 : (2 * (a : ℚ)) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) := by
    calc (2 * (a : ℚ)) / (L : ℚ) ≤ (2 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (2 : ℚ) / (a : ℚ) := by field_simp
  have hneg : -((2 : ℚ) / (a : ℚ)) ≤ -((2 * (a : ℚ)) / (L : ℚ)) := neg_le_neg hc2
  have hv0 : rationalLogOrderLE v 0 := rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1
  have hC0 : rationalLogOrderLE 0 C := rationalLogOrderLE_zero_openSquareUpperBoundConstant hq0
  have hA : rationalLogOrderLE (((2 : ℚ) / (a : ℚ)) • v) (((2 : ℚ) / (L : ℚ)) • v) :=
    rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos hcL hv0
  have hB' := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hneg hC0
  have hB : rationalLogOrderLE (-(((2 : ℚ) / (a : ℚ)) • C)) (-(((2 * (a : ℚ)) / (L : ℚ)) • C)) := by
    rwa [neg_smul, neg_smul] at hB'
  have hlow := rationalLogOrderLE_openSquareNonMultipleSideDensity_lower_vs_baseSide_of_le_one
    a k L hkL hLk hq0 hq1
  have hsplit : ((4 : ℚ) / (a : ℚ)) • v = ((2 : ℚ) / (a : ℚ)) • v + ((2 : ℚ) / (a : ℚ)) • v := by
    rw [← add_smul]; congr 1; ring
  exact NecSuf.ThermodynamicLimit.lower_bound_shrink_first_and_last_terms_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    _ _ _ _ _ _ _ _ hlow hA hB hsplit

end Ising2DLambda.ThermodynamicLimit
