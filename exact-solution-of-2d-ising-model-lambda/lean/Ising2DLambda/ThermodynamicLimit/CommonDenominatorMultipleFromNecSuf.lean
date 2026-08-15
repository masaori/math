/- 必要十分版を具体的な Λ_ℚ・ι・整数倍へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.CommonDenominatorMultiple
import Ising2DLambda.NecSuf.ThermodynamicLimit.CommonDenominatorMultiple

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem commonDenominator_mul_from_necSuf (k N : ℕ) (l : RationalLogOrderGroup)
    (lN : LogOrderGroup) (h : IsCommonDenominator N l lN) :
    IsCommonDenominator (k * N) l (((k : ℤ)) • lN) := by
  unfold IsCommonDenominator at h ⊢
  exact NecSuf.ThermodynamicLimit.multiple_clears_necSuf
    (R := ℚ) (S := ℤ) toRational (fun n : ℕ => (n : ℚ)) (fun n : ℕ => (n : ℤ))
    (fun a b => by push_cast; ring)
    (fun n x => by rw [← toRational_intSmul, Int.cast_natCast])
    k N l lN h

end Ising2DLambda.ThermodynamicLimit
