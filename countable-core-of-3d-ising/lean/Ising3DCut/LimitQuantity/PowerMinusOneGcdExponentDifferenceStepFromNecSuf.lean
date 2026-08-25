import Ising3DCut.LimitQuantity.PowerMinusOneGcdExponentDifferenceStep
import Ising3DCut.NecSuf.PowerMinusOneGcdExponentDifferenceStep

namespace Ising3DCut.LimitQuantity

/-- 必要十分版へ冪差の分解を渡すと、具体版の一段還元が得られる。 -/
theorem powerMinusOne_gcd_exponent_difference_step_viaNecSuf (c : ℤ) (d n : ℕ) :
    Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) = Int.gcd (c ^ d - 1) (c ^ n - 1) := by
  apply Ising3DCut.NecSuf.gcd_eq_of_decomposition
  exact powerMinusOne_gcd_decompose c d n

/-- `m>n` の形も、指数の加法分解だけを具体側で与えて必要十分版から導く。 -/
theorem powerMinusOne_gcd_exponent_difference_step_of_lt_viaNecSuf
    (c : ℤ) (m n : ℕ) (h : n < m) :
    Int.gcd (c ^ m - 1) (c ^ n - 1) = Int.gcd (c ^ (m - n) - 1) (c ^ n - 1) := by
  have hm : m - n + n = m := Nat.sub_add_cancel (le_of_lt h)
  have hs := powerMinusOne_gcd_exponent_difference_step_viaNecSuf c (m - n) n
  rw [hm] at hs
  exact hs

end Ising3DCut.LimitQuantity
