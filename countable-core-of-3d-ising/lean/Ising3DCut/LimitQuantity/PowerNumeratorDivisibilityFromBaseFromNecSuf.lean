/-
必要十分版 `Ising3DCut.NecSuf.dvd_mul_pow_sub_pow_of_dvd_mul_sub` から、
具体版と同じ結論（閾値の箱の点数乗についての整除）を導く。
具体版が要求している有理数の分子・自然数の引き算は、この抽象版の
特殊化（`R = ℤ`、`k = 2`、`y = 1`）に整数への移送を足したものである。
-/
import Ising3DCut.NecSuf.PowerNumeratorDivisibilityFromBase
import Ising3DCut.LimitQuantity.PowerNumeratorDivisibilityFromBase

namespace Ising3DCut.LimitQuantity

/-- 必要十分版からの導出。底についての箱に依存しない整除
`a ∣ 2 (c - 1)` から、点数乗についての整除 `a ∣ 2 (c^{L₀³} - 1)` を得る。 -/
theorem power_numerator_divisibility_of_base_divisibility_fromNecSuf
    {q c : ℚ} {L₀ : ℕ} (hc : 0 < c)
    (hbase : q.num.natAbs ∣ 2 * (c.num.natAbs - 1)) :
    (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) ^ (L₀ ^ 3) - 1) := by
  have hcnum : 1 ≤ c.num.natAbs := by
    have : 0 < c.num := Rat.num_pos.mpr hc
    omega
  have hint : (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) - 1) := by
    have hcast : ((2 * (c.num.natAbs - 1) : ℕ) : ℤ)
        = 2 * ((c.num.natAbs : ℤ) - 1) := by
      push_cast [Nat.cast_sub hcnum]
      ring
    exact hcast ▸ Int.natCast_dvd_natCast.mpr hbase
  simpa using
    NecSuf.dvd_mul_pow_sub_pow_of_dvd_mul_sub (R := ℤ) (L₀ ^ 3) hint

end Ising3DCut.LimitQuantity
