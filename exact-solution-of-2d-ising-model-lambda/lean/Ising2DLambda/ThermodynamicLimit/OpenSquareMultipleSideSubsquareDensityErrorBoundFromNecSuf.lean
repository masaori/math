/-
「倍数辺の部分正方形による密度の挟み込みの誤差評価（q は 1 以下）」の具体版を、
必要十分版 `twoSided_bounds_enlarge_coefficients_necSuf` の特殊化として導く。
準備の第一〜第四（部分正方形比較の読み替え・ℚ の係数比較・符号・有理数倍の比較）は具体版と同じで、
本体（加法単調性と推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideSubsquareDensityErrorBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareMultipleSideSubsquareDensityErrorBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one_from_necSuf
    (a k L : ℕ) [NeZero a] [NeZero k] [NeZero L] (h1 : k * a < L) (h2 : L ≤ k * a + a)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 : ℚ) / (L : ℚ)) • toRational (logRat q) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q)
        (openScaledFreeEntropy L q) ∧
      rationalLogOrderLE (openScaledFreeEntropy L q)
        (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q) := by
  have hL : (0 : ℚ) < (L : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne L)
  have hL2 : (0 : ℚ) < (L : ℚ) ^ 2 := by positivity
  -- 準備の第一
  obtain ⟨hlow, hup⟩ :=
    rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one (k * a) L h1 hq0 hq1
  -- 準備の第二
  have hc1 : (((k * a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (2 : ℚ) / (L : ℚ) := by
    have hn : ((k * a + L : ℕ) : ℚ) ≤ ((L + L : ℕ) : ℚ) := by
      exact_mod_cast Nat.add_le_add_right h1.le L
    calc (((k * a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((L + L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 : ℚ) / (L : ℚ) := by
        push_cast; field_simp; norm_num
  have hc2 : (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (2 * (a : ℚ)) / (L : ℚ) := by
    have hn : ((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) ≤ ((2 * a * L : ℕ) : ℚ) := by
      exact_mod_cast sq_sub_multiple_sq_le_two_mul_nat a k L h1.le h2
    calc (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((2 * a * L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 * (a : ℚ)) / (L : ℚ) := by
        push_cast; field_simp
  have hc3 : (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (4 * (a : ℚ)) / (L : ℚ) := by
    calc (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        = 2 * ((((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))) := by
          push_cast; ring
      _ ≤ 2 * ((2 * (a : ℚ)) / (L : ℚ)) := by
          exact mul_le_mul_of_nonneg_left hc2 (by norm_num)
      _ = (4 * (a : ℚ)) / (L : ℚ) := by ring
  -- 準備の第三・第四
  have hm1 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos hc1
    (rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1)
  have hm2 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc2
    rationalLogOrderLE_zero_toRational_generator_two
  have hm3 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc3
    (rationalLogOrderLE_zero_toRational_logRat_one_add hq0)
  -- 本体は必要十分版へ
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_enlarge_coefficients_necSuf rationalLogOrderLE
    (fun h h' => rationalLogOrderLE_trans h h') (fun z h => rationalLogOrderLE_add_right h z)
    _ _ _ _ _ _ _ _ hlow hup hm1 hm2 hm3

end Ising2DLambda.ThermodynamicLimit
