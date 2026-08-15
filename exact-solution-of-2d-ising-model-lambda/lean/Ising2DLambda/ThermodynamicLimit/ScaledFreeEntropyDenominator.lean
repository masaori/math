/-
人手証明「有限系の密度の分母は整数倍で払える」
（`claim_scaled_free_entropy_denominator_clearing`）の具体版。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroup
import Mathlib

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 二つの有限系の密度へ共通の正整数倍 `L^2 M^2` を掛けると、分母が消える。 -/
theorem scaledFreeEntropy_clear_denominator
    (L M : ℕ) [NeZero L] [NeZero M] (q r : ℚ) :
    ((((L : ℚ) ^ 2) * ((M : ℚ) ^ 2)) • scaledFreeEntropy L q =
      ((M : ℚ) ^ 2) • toRational (freeEntropy L q)) ∧
    ((((L : ℚ) ^ 2) * ((M : ℚ) ^ 2)) • scaledFreeEntropy M r =
      ((L : ℚ) ^ 2) • toRational (freeEntropy M r)) := by
  have hL : (L : ℚ) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  have hM : (M : ℚ) ≠ 0 := by exact_mod_cast (NeZero.ne M)
  constructor
  · rw [scaledFreeEntropy, smul_smul]
    congr 1
    field_simp [hL]
  · rw [scaledFreeEntropy, smul_smul]
    congr 1
    field_simp [hM]

end Ising2DLambda.ThermodynamicLimit
