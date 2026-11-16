/-
`claim_dispersion_product_real_log_sum` の式鎖の最初の三行。
脱出理由は正の実数の実対数である。
-/
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit

/-- 零でない実数の絶対値の対数を、その平方の対数へ移す。 -/
theorem realLog_abs_eq_half_realLog_sq (T : ℝ) (hT : T ≠ 0) :
    realLog ⟨|T|, abs_pos.mpr hT⟩ =
      (1 / 2 : ℝ) * realLog ⟨T ^ 2, sq_pos_of_ne_zero hT⟩ := by
  have hpos : 0 < |T| := abs_pos.mpr hT
  have hmul := realLog_mul ⟨|T|, hpos⟩ ⟨|T|, hpos⟩
  have hsq : |T| * |T| = T ^ 2 := by rw [← pow_two, sq_abs]
  have hlog :
      realLog ⟨T ^ 2, sq_pos_of_ne_zero hT⟩ =
        realLog ⟨|T|, hpos⟩ + realLog ⟨|T|, hpos⟩ := by
    calc
      realLog ⟨T ^ 2, sq_pos_of_ne_zero hT⟩ =
          realLog ⟨|T| * |T|, mul_pos hpos hpos⟩ := by
            exact realLog_congr _ _ hsq.symm
      _ = realLog ⟨|T|, hpos⟩ + realLog ⟨|T|, hpos⟩ := hmul
  linarith

end Ising2DLambda.RealEscape
