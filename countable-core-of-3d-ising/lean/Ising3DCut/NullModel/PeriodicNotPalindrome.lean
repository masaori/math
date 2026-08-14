/-
人手証明の主張「奇数周期では多重度は回文でない」
（ラベル `claim_periodic_not_palindrome`）の具体版。

人手証明とこのファイルの対応:

  Ω^per_L(0) ≥ 1                      `one_le_periodicMultiplicity_zero`（前主張）
  #E^per_L - 0 = #E^per_L             `Nat.sub_zero` による書き換え
  Ω^per_L(#E^per_L) = 0（L は奇数）    `periodicMultiplicity_full_eq_zero`（前主張）
  1 以上の自然数と 0 は等しくない       等しいと仮定して 1 ≤ 0 の矛盾を得る

住処: `Nat`、有限型の元の個数のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OddPeriodicCycle

namespace Ising3DCut.NullModel

/-- `claim_periodic_not_palindrome` の具体版。奇数周期では
Ω^per_L(0) ≠ Ω^per_L(#E^per_L - 0)、すなわち回文性は m = 0 ですでに崩れる。 -/
theorem periodicMultiplicity_not_palindrome {L : ℕ} (hodd : Odd L) :
    periodicMultiplicity L 0 ≠
      periodicMultiplicity L (Fintype.card (PeriodicEdge L) - 0) := by
  rw [Nat.sub_zero]
  intro heq
  have h1 : 1 ≤ periodicMultiplicity L 0 := one_le_periodicMultiplicity_zero L
  rw [heq, periodicMultiplicity_full_eq_zero hodd] at h1
  exact Nat.not_succ_le_zero 0 h1

end Ising3DCut.NullModel
