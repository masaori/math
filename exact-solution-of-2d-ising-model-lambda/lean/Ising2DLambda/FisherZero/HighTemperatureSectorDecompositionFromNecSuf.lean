/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem highTemperatureSectorDecomposition_from_necSuf (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      highTemperatureSectorPolynomial L (0, 0) +
      highTemperatureSectorPolynomial L (0, 1) +
      highTemperatureSectorPolynomial L (1, 0) +
      highTemperatureSectorPolynomial L (1, 1) := by
  classical
  rw [highTemperaturePolynomial]
  have h := Ising2DLambda.NecSuf.FisherZero.sum_eq_sum_label_fibers_necSuf
    ((univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L))
    (torusHomologySector L)
    (fun A =>
      ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
        ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card)
  simpa only [highTemperatureSectorPolynomial, IsInTorusHomologySector,
    Finset.filter_filter, and_assoc, Fintype.sum_prod_type, Fin.sum_univ_two,
    add_assoc] using h

end Ising2DLambda.FisherZero
