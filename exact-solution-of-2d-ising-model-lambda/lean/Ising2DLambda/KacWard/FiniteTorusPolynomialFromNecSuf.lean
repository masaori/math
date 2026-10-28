import Ising2DLambda.KacWard.FiniteTorusPolynomial
import Ising2DLambda.NecSuf.KacWard.FiniteTorusPolynomial

namespace Ising2DLambda.KacWard

open Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial

/-- The concrete polynomial identity follows from the finite-sum argument. -/
theorem finiteTorusPolynomial_from_necSuf (L : ℕ) [NeZero L] :
    (∑ spin : Fin 2 × Fin 2,
      signedEvenSubgraphPolynomial L spin.1 spin.2) =
        2 * partitionPolynomial L := by
  apply Ising2DLambda.NecSuf.KacWard.finiteTorusPolynomial
    (fun spin sector => signedEvenSubgraphCoefficient spin.1 spin.2 sector)
    (fun spin => signedEvenSubgraphPolynomial L spin.1 spin.2)
    (sectorGeneratingPolynomial L) (partitionPolynomial L)
  · intro spin
    exact signedEvenSubgraphPolynomial_eq_sectorSum L spin.1 spin.2
  · intro sector
    exact coefficient_sum sector
  · exact partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial L

end Ising2DLambda.KacWard
