/- 具体版が必要十分版の特殊化として得られることを明示する。 -/
import Ising2DLambda.ThermodynamicLimit.ScaledFreeEntropyDenominator
import Ising2DLambda.NecSuf.ThermodynamicLimit.ScaledFreeEntropyDenominator

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 分母消去の具体版を体上の加群の係数計算へ特殊化した導出版。 -/
theorem scaledFreeEntropy_clear_denominator_from_necSuf
    (L M : ℕ) [NeZero L] [NeZero M] (q r : ℚ) :
    ((((L : ℚ) ^ 2) * ((M : ℚ) ^ 2)) • scaledFreeEntropy L q =
      ((M : ℚ) ^ 2) • toRational (freeEntropy L q)) ∧
    ((((L : ℚ) ^ 2) * ((M : ℚ) ^ 2)) • scaledFreeEntropy M r =
      ((L : ℚ) ^ 2) • toRational (freeEntropy M r)) := by
  have hL : (L : ℚ) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  have hM : (M : ℚ) ≠ 0 := by exact_mod_cast (NeZero.ne M)
  simpa [scaledFreeEntropy] using
    (NecSuf.ThermodynamicLimit.two_scaled_denominators_cancel_necSuf
      ((L : ℚ) ^ 2) ((M : ℚ) ^ 2)
      (pow_ne_zero 2 hL) (pow_ne_zero 2 hM)
      (toRational (freeEntropy L q)) (toRational (freeEntropy M r)))

end Ising2DLambda.ThermodynamicLimit
