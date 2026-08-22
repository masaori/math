/-
自由エントロピーの双対関係の証明が二度使う補助段。

$\sum_{a,b} H^{a,b}_L = 2^{L^2+1} G^{0,0}_L$ は、低温展開の自明セクター表示・高温展開の
多項式恒等式・セクター分解の三つを等式の推移でつないだだけのものであり、それ自体は
**双対性を含まない**（両辺とも同じ不定元での値である。本当の Kramers--Wannier 双対は、
点 $q$ と双対な点 $\mathrm{KW}(q)$ を結ぶ「セクター多項式の値の双対関係」の側にある）。
人手証明ではこの中間主張を置かず、三つを直接つないでいる。ここに残してあるのは、
Lean 側で同じ鎖を二度書かないための補助段としてである。
-/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- `claim_mixed_boundary_duality_identity` の具体版。 -/
theorem highTemperatureSectorSum_eq_twoPow_mul_trivialSector (L : ℕ) [NeZero L] :
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
