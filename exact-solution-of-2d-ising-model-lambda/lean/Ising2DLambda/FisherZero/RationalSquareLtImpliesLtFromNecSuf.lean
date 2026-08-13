import Ising2DLambda.FisherZero.RationalSquareLtImpliesLt
import Ising2DLambda.NecSuf.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.FisherZero

/-- `claim_rational_square_lt_implies_lt` の具体版を必要十分版から導く。 -/
theorem rationalSquareLtImpliesLt_from_necSuf
    (p q : ℚ) (hp : 0 ≤ p) (hq : 0 ≤ q)
    (hSquare : p * p < q * q) : p < q := by
  apply Ising2DLambda.NecSuf.FisherZero.rational_square_lt_implies_lt_necSuf
      (zero := (0 : ℚ)) (mul := (· * ·)) (le := (· ≤ ·)) (lt := (· < ·))
      (p := p) (q := q) hp hq hSquare
  · intro _ hqp
    exact mul_le_mul_of_nonneg_right hqp hq
  · intro _ hqp
    exact mul_le_mul_of_nonneg_left hqp hp
  · exact le_trans
  · exact lt_of_lt_of_le
  · exact lt_irrefl (p * p)
  · exact lt_of_not_ge

end Ising2DLambda.FisherZero
