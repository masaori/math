/-
人手証明「有限台指数ベクトルの和は正の有理数の積へ移る」と
「対数順序群の順序は加法について単調である」の具体版。

前者は両辺へ対数を取り、対数の加法性と単射性を使う。後者は前者で和を積へ移し、
正の有理数を右から掛ける単調性へ落とす。住処は ℕ・ℤ・ℚ・Λ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.LogOrderGroupOrder
import Ising2DLambda.FreeEntropy.RationalLogInjective

namespace Ising2DLambda.FreeEntropy

/-- `claim_rational_of_log_additive`。指数ベクトルの和は正の有理数の積へ移る。 -/
theorem rationalOfLog_add (l n : LogOrderGroup) :
    rationalOfLog (l + n) = rationalOfLog l * rationalOfLog n := by
  apply logRat_injective_of_pos (rationalOfLog_pos (l + n))
    (mul_pos (rationalOfLog_pos l) (rationalOfLog_pos n))
  calc
    logRat (rationalOfLog (l + n)) = l + n := logRat_rationalOfLog (l + n)
    _ = logRat (rationalOfLog l) + logRat (rationalOfLog n) := by
      rw [logRat_rationalOfLog, logRat_rationalOfLog]
    _ = logRat (rationalOfLog l * rationalOfLog n) :=
      (logRat_mul (rationalOfLog_pos l) (rationalOfLog_pos n)).symm

/-- `claim_log_order_group_add_monotone`。引き戻した順序は加法について単調である。 -/
theorem logOrderLE_add_right {l m : LogOrderGroup} (h : logOrderLE l m) (n : LogOrderGroup) :
    logOrderLE (l + n) (m + n) := by
  unfold logOrderLE at h ⊢
  rw [rationalOfLog_add, rationalOfLog_add]
  exact mul_le_mul_of_nonneg_right h (le_of_lt (rationalOfLog_pos n))

end Ising2DLambda.FreeEntropy
