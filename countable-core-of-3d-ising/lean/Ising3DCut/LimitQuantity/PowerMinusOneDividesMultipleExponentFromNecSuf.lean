/- 必要十分版から整数上の具体版を導く。 -/
import Ising3DCut.LimitQuantity.PowerMinusOneDividesMultipleExponent
import Ising3DCut.NecSuf.PowerMinusOneDividesMultipleExponent

namespace Ising3DCut.LimitQuantity

theorem powerMinusOne_dvd_multiple_exponent_viaNecSuf (c : ℤ) (n k : ℕ) :
    (c ^ n - 1) ∣ (c ^ (n * k) - 1) :=
  Ising3DCut.NecSuf.powerMinusOne_dvd_multiple_exponent c n k

end Ising3DCut.LimitQuantity
