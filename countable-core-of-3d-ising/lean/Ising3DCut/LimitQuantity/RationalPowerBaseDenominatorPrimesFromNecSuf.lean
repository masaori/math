/-
必要十分版 `NecSuf.base_value_nonnegative_of_positive_multiple` から、具体版の
分母制約を導く。具体側に残るのは、素指数が商を差・冪を整数倍へ写すこと、
自然数の素指数が非負であること、および既約分母を割る素数では素指数が負に
なることだけである。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenominatorPrimes
import Ising3DCut.NecSuf.RationalPowerBaseDenominatorPrimes

namespace Ising3DCut.LimitQuantity

/-- `rational_power_base_den_not_dvd_of_not_dvd` を必要十分版から導いた版。 -/
theorem rational_power_base_den_not_dvd_of_not_dvd_viaNecSuf
    (p P b E N : ℕ) (hp : p.Prime) (hP : 0 < P) (hb : 0 < b) (hN : 0 < N)
    (hpNotDvd : ¬ p ∣ b) (c : ℚ) (hc : 0 < c)
    (hrep : (P : ℚ) / (b : ℚ) ^ E = c ^ N) :
    ¬ p ∣ c.den := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hvalue : 0 ≤ padicValRat p ((P : ℚ) / (b : ℚ) ^ E) :=
    padicValRat_nat_div_pow_nonneg p P b E hp hP hb hpNotDvd
  have hc0 : c ≠ 0 := hc.ne'
  have hvaluation :
      padicValRat p ((P : ℚ) / (b : ℚ) ^ E) =
        (N : ℤ) * padicValRat p c := by
    rw [hrep, padicValRat.pow]
    try exact hc0
  have hbase : 0 ≤ padicValRat p c :=
    Ising3DCut.NecSuf.base_value_nonnegative_of_positive_multiple
      _ _ N hvalue hN hvaluation
  exact not_dvd_den_of_padicValRat_nonneg p hp c hc hbase

end Ising3DCut.LimitQuantity
