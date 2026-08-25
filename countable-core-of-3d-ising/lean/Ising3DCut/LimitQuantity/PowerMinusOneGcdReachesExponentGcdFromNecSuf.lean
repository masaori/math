import Ising3DCut.LimitQuantity.PowerMinusOneGcdExponentDifferenceStep
import Ising3DCut.LimitQuantity.PowerMinusOneGcdReachesExponentGcd
import Ising3DCut.NecSuf.PowerMinusOneGcdReachesExponentGcd

namespace Ising3DCut.LimitQuantity

/-- 一段還元を必要十分版へ渡すと、具体版の到達定理が同じ強い帰納法から得られる。 -/
theorem powerMinusOne_gcd_reaches_exponent_gcd_viaNecSuf
    (c : ℤ) (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    Int.gcd (c ^ m - 1) (c ^ n - 1) =
      Int.gcd (c ^ Nat.gcd m n - 1) (c ^ Nat.gcd m n - 1) := by
  apply Ising3DCut.NecSuf.reduction_reaches_index_gcd
    (fun k : ℕ ↦ c ^ k - 1) Int.gcd Int.gcd_comm
  intro d k
  exact powerMinusOne_gcd_exponent_difference_step c d k
  exact hm
  exact hn

end Ising3DCut.LimitQuantity
