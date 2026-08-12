/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.LowTemperaturePolynomial
import Ising2DLambda.NecSuf.FisherZero.LowTemperaturePolynomial

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem partitionPolynomial_eq_two_mul_lowTemperaturePolynomial_from_necSuf
    (L : ℕ) [NeZero L] :
    partitionPolynomial L = 2 * lowTemperaturePolynomial L := by
  classical
  rw [partitionPolynomial, lowTemperaturePolynomial]
  have h := Ising2DLambda.NecSuf.FisherZero.sum_eq_two_nsmul_sum_image_necSuf
    (univ : Finset (Config L)) (brokenEdgeSet L)
    (fun B : Finset (Edge L) => (Polynomial.X : Polynomial ℤ) ^ B.card)
    (fun B hB => brokenEdgeSet_fiber_card_two L B hB)
  simpa [attainableBrokenEdgeSets, brokenEdgeSet_card, Finset.mul_sum] using h

end Ising2DLambda.FisherZero
