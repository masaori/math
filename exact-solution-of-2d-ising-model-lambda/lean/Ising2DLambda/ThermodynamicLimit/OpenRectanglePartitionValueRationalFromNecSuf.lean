/-
必要十分版 `NecSuf.FreeEntropy.sum_pow_pos` から、具体版
`openPartitionValueRat_pos`（`claim_open_rectangle_value_at_rational_is_positive`）を導く。

  ι := 開境界長方形の配位の集合 OpenConfig a b
  f := 開境界長方形の破れボンド数 openBrokenBondCount a b
  K := ℚ

必要十分版は周期境界の `claim_value_at_rational_is_positive` と同じもの（有限で空でない添字型と、
順序半環の正の元の自然数冪の和が正であること）であり、開境界であること・長方形の形・多項式であることは
本質でない。残るのは代入を和へ配ること（`openPartitionValueRat_eq_sum`）だけである。

住処: ℚ と ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectanglePartitionValueRational
import Ising2DLambda.NecSuf.FreeEntropy.ValuePositive

namespace Ising2DLambda.ThermodynamicLimit

variable (a b : ℕ)

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem openPartitionValueRat_pos_from_necSuf {q : ℚ} (hq : 0 < q) :
    0 < openPartitionValueRat a b q := by
  rw [openPartitionValueRat_eq_sum]
  exact NecSuf.FreeEntropy.sum_pow_pos (openBrokenBondCount a b) hq

end Ising2DLambda.ThermodynamicLimit
