/-
「四境界条件の混合の双対恒等式」の具体版。
人手証明と同じく、高温展開の四セクター分解、高温展開の多項式恒等式、
低温展開の自明セクター表示、冪の指数法則を一段ずつ当てる。
住処は有限集合と Z[x] であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- `claim_mixed_boundary_duality_identity` の具体版。 -/
theorem mixedBoundaryDualityIdentity (L : ℕ) [NeZero L] :
    highTemperatureSectorPolynomial L (0, 0) +
          highTemperatureSectorPolynomial L (0, 1) +
          highTemperatureSectorPolynomial L (1, 0) +
          highTemperatureSectorPolynomial L (1, 1) =
      2 ^ (L ^ 2 + 1) * sectorGeneratingPolynomial L (0, 0) := by
  calc
    highTemperatureSectorPolynomial L (0, 0) +
          highTemperatureSectorPolynomial L (0, 1) +
          highTemperatureSectorPolynomial L (1, 0) +
          highTemperatureSectorPolynomial L (1, 1) =
        highTemperaturePolynomial L :=
      (highTemperatureSectorDecomposition L).symm
    _ = 2 ^ (L ^ 2) * partitionPolynomial L :=
      (highTemperaturePolynomial_identity L).symm
    _ = 2 ^ (L ^ 2) *
          (2 * sectorGeneratingPolynomial L (0, 0)) := by
      rw [partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial]
    _ = 2 ^ (L ^ 2 + 1) * sectorGeneratingPolynomial L (0, 0) := by
      rw [← mul_assoc, ← pow_succ]

end Ising2DLambda.FisherZero
