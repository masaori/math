/-
必要十分版 `NecSuf.coprime_of_common_prime_dvd_left` から、具体版の
「点数乗表示の底の既約分母は有理点の分子と互いに素である」を導く。
具体側に残るのは、合同式から共通素因子が底の分子を割ることを示す段だけである。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenominatorCoprime
import Ising3DCut.NecSuf.RationalPowerBaseDenominatorCoprime

namespace Ising3DCut.LimitQuantity

/-- `rational_power_base_denominator_coprime_to_numerator` を必要十分版から導いた版。 -/
theorem rational_power_base_denominator_coprime_to_numerator_viaNecSuf
    (Ω0 u v a N : ℕ) (hN : 0 < N) (huv : Nat.Coprime u v)
    (hcong : (Ω0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (a : ℤ)]) :
    Nat.Coprime a v := by
  apply Ising3DCut.NecSuf.coprime_of_common_prime_dvd_left u v a huv
  intro p hp hpa hpv
  have hpuN : p ∣ u ^ N :=
    dvd_pow_numerator_of_dvd_denominator Ω0 u v a N p hN hpa hpv hcong
  exact hp.dvd_of_dvd_pow hpuN

end Ising3DCut.LimitQuantity
