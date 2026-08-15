/- 必要十分版を具体的な Λ・Λ_ℚ・ι へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.CommonDenominator
import Ising2DLambda.NecSuf.ThermodynamicLimit.CommonDenominator

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem commonDenominator_order_independent_from_necSuf (N N' : ℕ) (hN : 1 ≤ N) (hN' : 1 ≤ N')
    (l m : RationalLogOrderGroup) (lN mN lN' mN' : LogOrderGroup)
    (hl : IsCommonDenominator N l lN) (hm : IsCommonDenominator N m mN)
    (hl' : IsCommonDenominator N' l lN') (hm' : IsCommonDenominator N' m mN') :
    logOrderLE lN mN ↔ logOrderLE lN' mN' :=
  NecSuf.ThermodynamicLimit.cross_multiple_order_independent_necSuf
    (fun n a => ((n : ℤ)) • a) (fun n b => ((n : ℚ)) • b) toRational logOrderLE
    toRational_injective
    (fun n a => by rw [← toRational_intSmul, Int.cast_natCast])
    (fun n n' b => by rw [smul_smul, smul_smul, mul_comm])
    (fun n hn a a' => logOrderLE_natSmul_iff n hn a a')
    N N' hN hN' l m lN mN lN' mN' hl hm hl' hm'

end Ising2DLambda.ThermodynamicLimit
