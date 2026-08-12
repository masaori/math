/-
具体版が必要十分版の特殊化であることの導出。
人手証明の四段を、必要十分版が受け取る四つの等式へそのまま渡す。住処は Z[x] である。
-/
import Ising2DLambda.FisherZero.MixedBoundaryDualityIdentity
import Ising2DLambda.NecSuf.FisherZero.MixedBoundaryDualityIdentity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- `claim_mixed_boundary_duality_identity` の具体版を必要十分版から導く。 -/
theorem mixedBoundaryDualityIdentity_from_necSuf (L : ℕ) [NeZero L] :
    highTemperatureSectorPolynomial L (0, 0) +
          highTemperatureSectorPolynomial L (0, 1) +
          highTemperatureSectorPolynomial L (1, 0) +
          highTemperatureSectorPolynomial L (1, 1) =
      2 ^ (L ^ 2 + 1) * sectorGeneratingPolynomial L (0, 0) := by
  apply Ising2DLambda.NecSuf.FisherZero.four_step_equality_chain_necSuf
      (first := highTemperaturePolynomial L)
      (second := 2 ^ (L ^ 2) * partitionPolynomial L)
      (third := 2 ^ (L ^ 2) * (2 * sectorGeneratingPolynomial L (0, 0)))
  · exact (highTemperatureSectorDecomposition L).symm
  · exact (highTemperaturePolynomial_identity L).symm
  · rw [partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial]
  · rw [← mul_assoc, ← pow_succ]

end Ising2DLambda.FisherZero
