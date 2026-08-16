/-
「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（q は 1 以下）」の具体版を、
必要十分版 `difference_lower_bound_from_swapped_upper_necSuf` の特殊化として導く。
入れ替えた上端の読み出しと準備の等式（素数ごとの六段）は具体版と同じで、
本体（逆元の順序反転と読み替え）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceLower
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceLower

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareLargeSidesDensityDifference_lower_of_le_one_from_necSuf
    (a L M : ℕ) [NeZero a] [NeZero L] [NeZero M]
    (haL : a < L) (haM : a < M) (hsqL : a ^ 2 ≤ L) (hsqM : a ^ 2 ≤ M)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (-((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q)) +
        ((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))))
      (openScaledFreeEntropy L q + -(openScaledFreeEntropy M q)) := by
  have hswap :=
    rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one a M L haM haL hsqM hsqL hq0 hq1
  exact NecSuf.ThermodynamicLimit.difference_lower_bound_from_swapped_upper_necSuf rationalLogOrderLE
    (fun h => rationalLogOrderLE_neg_le_neg h) _ _ _ hswap
    (neg_add_neg_eq_add_neg_swap (openScaledFreeEntropy L q) (openScaledFreeEntropy M q))

end Ising2DLambda.ThermodynamicLimit
