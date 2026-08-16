/-
「核は非負である」の具体版を、必要十分版 `zero_le_core_of_signs_necSuf` の特殊化として導く。
`Λ_ℚ` の推移律・加法単調性・非負有理数倍の順序保存・逆元の順序反転、`smul_zero`・`neg_zero`、
および埋め込んだ対数の三つの符号を必要十分版の仮定へ渡す。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCoreNonneg
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCoreNonneg

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one_from_necSuf
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE 0 (openSquareDensityDifferenceBoundCore q) :=
  NecSuf.ThermodynamicLimit.zero_le_core_of_signs_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    (fun hc h => rationalLogOrderLE_ratSmul_of_nonneg hc h)
    (fun h => rationalLogOrderLE_neg_le_neg h)
    (fun c => smul_zero c) neg_zero
    _ _ _
    rationalLogOrderLE_zero_toRational_generator_two
    (rationalLogOrderLE_zero_toRational_logRat_one_add hq0)
    (rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1)

end Ising2DLambda.ThermodynamicLimit
