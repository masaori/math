/-
「倍数辺の密度と基準辺の密度の差の評価（q は 1 以下）」の具体版を、
必要十分版 `twoSided_bounds_enlarge_lower_coefficient_necSuf` の特殊化として導く。
準備の第一〜第三（ℚ の係数比較・符号・有理数倍の比較）は具体版と同じで、
本体（加法単調性と推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideDensityVsBaseSide
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareMultipleSideDensityVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one_from_necSuf
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 : ℚ) / (a : ℚ)) • toRational (logRat q) + openScaledFreeEntropy a q)
        (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q) (openScaledFreeEntropy a q) := by
  obtain ⟨hlow, hup⟩ := rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one a k hq0 hq1
  have hm := rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos
    (blockTiling_lower_coefficient_le_two_div a k)
    (rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1)
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_enlarge_lower_coefficient_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    _ _ _ _ _ hlow hup hm

end Ising2DLambda.ThermodynamicLimit
