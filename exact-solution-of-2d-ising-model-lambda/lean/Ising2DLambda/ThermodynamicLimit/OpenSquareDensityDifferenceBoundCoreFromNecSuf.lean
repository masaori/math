/-
「差の一様な評価に現れる量は核の基準辺分の一倍である」の具体版を、
必要十分版 `one_div_smul_core_eq_scaled_terms_necSuf` の特殊化として導く。
`Λ_ℚ` の分配則 `smul_add`・結合則 `mul_smul`、および準備の第一（素数ごとの五段
`ratSmul_neg_eq_neg_ratSmul`）を必要十分版の三つの仮定へ渡す。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCore
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCore

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem one_div_smul_openSquareDensityDifferenceBoundCore_from_necSuf (a : ℕ) [NeZero a] (q : ℚ) :
    ((1 : ℚ) / (a : ℚ)) • openSquareDensityDifferenceBoundCore q =
      ((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q))) +
      ((2 : ℚ) / (a : ℚ)) •
        (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) :=
  NecSuf.ThermodynamicLimit.one_div_smul_core_eq_scaled_terms_necSuf
    (fun r x y => smul_add r x y) (fun r s x => mul_smul r s x)
    (fun r x => ratSmul_neg_eq_neg_ratSmul r x) a _ _ _

end Ising2DLambda.ThermodynamicLimit
