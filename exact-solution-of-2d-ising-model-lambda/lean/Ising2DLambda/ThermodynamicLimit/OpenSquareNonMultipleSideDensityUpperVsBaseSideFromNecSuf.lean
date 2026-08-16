/-
「倍数でない辺の密度の基準辺の密度による上からの評価（q は 1 以下）」の具体版を、
必要十分版 `upper_bound_enlarge_last_term_necSuf` の特殊化として導く。
準備の第一〜第三（ℚ の係数比較・符号・有理数倍の比較と推移律）は具体版と同じで、
本体（加法単調性・交換則・推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareNonMultipleSideDensityUpperVsBaseSide
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareNonMultipleSideDensityUpperVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareNonMultipleSideDensity_upper_vs_baseSide_of_le_one_from_necSuf
    (a k L : ℕ) [NeZero a] [NeZero k] [NeZero L] (h1 : k * a < L) (h2 : L ≤ k * a + a)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
        ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)) +
        openScaledFreeEntropy a q) := by
  obtain ⟨_, hup⟩ :=
    rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one a k L h1 h2 hq0 hq1
  have hm := rationalLogOrderLE_ratSmul_le_ratSmul_of_le
    (multipleSide_square_ratio_le_one a k L h1)
    (rationalLogOrderLE_zero_openScaledFreeEntropy (k * a) hq0)
  rw [one_smul] at hm
  obtain ⟨_, hka⟩ := rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one a k hq0 hq1
  exact NecSuf.ThermodynamicLimit.upper_bound_enlarge_last_term_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    _ _ _ _ hup (rationalLogOrderLE_trans hm hka)

end Ising2DLambda.ThermodynamicLimit
