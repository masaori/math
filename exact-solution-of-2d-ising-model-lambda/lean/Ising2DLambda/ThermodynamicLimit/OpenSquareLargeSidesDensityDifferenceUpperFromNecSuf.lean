/-
「基準辺の平方以上の二つの辺の密度の差の一様な上からの評価（q は 1 以下）」の具体版を、
必要十分版 `difference_upper_bound_from_upper_and_lower_necSuf` の特殊化として導く。
上端と下端の読み出しは具体版と同じで、本体（加法単調性・結合則・交換則・逆元・単位元・推移律）だけを
必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceUpper
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceUpper

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one_from_necSuf
    (a L M : ℕ) [NeZero a] [NeZero L] [NeZero M]
    (haL : a < L) (haM : a < M) (hsqL : a ^ 2 ≤ L) (hsqM : a ^ 2 ≤ M)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (openScaledFreeEntropy L q + -(openScaledFreeEntropy M q))
      ((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q)) +
        ((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))) := by
  have hup := rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one a L haL hsqL hq0 hq1
  have hlow := rationalLogOrderLE_openSquareLargeSideDensity_lower_vs_baseSide_of_le_one a M haM hsqM hq0 hq1
  exact NecSuf.ThermodynamicLimit.difference_upper_bound_from_upper_and_lower_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    add_neg_cancel neg_add_cancel
    _ _ _ _ _ _ hup hlow

end Ising2DLambda.ThermodynamicLimit
