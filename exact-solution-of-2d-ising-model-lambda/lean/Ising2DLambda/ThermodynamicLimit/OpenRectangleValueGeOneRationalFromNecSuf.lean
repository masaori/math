/- 必要十分版を開境界長方形の配位・破れボンド数・有理数体へ特殊化する。
添字型は `OpenConfig a b`、指数は `openBrokenBondCount a b`、選ぶ項は `openAllPlusConfig a b`
（`openAllPlusConfig_openBrokenBondCount_eq_zero`）、係数の住処は `ℚ`。
必要十分版は周期境界の正の有理点での値の下界 1 と同じ `one_le_sum_pow_of_exponent_zero_necSuf`
（`NecSuf/ThermodynamicLimit/PartitionValueGeOneRational.lean`）をそのまま共有する
（指数 0 の項が一つ選べることと係数の住処が順序半環であることしか使わない。境界条件にも体にも依らない）。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueGeOneRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueGeOneRational

namespace Ising2DLambda.ThermodynamicLimit

theorem one_le_openPartitionValueRat_from_necSuf (a b : ℕ) {q : ℚ} (hq : 0 < q) :
    1 ≤ openPartitionValueRat a b q := by
  rw [openPartitionValueRat_eq_sum]
  exact NecSuf.ThermodynamicLimit.one_le_sum_pow_of_exponent_zero_necSuf
    (openAllPlusConfig a b) (openBrokenBondCount a b)
    (openAllPlusConfig_openBrokenBondCount_eq_zero a b) hq

end Ising2DLambda.ThermodynamicLimit
