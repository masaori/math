/-
「開境界長方形の値は 1 以上である」の具体版が必要十分版の特殊化として得られることを明示する。

有限添字型を開境界配位、選ぶ一項を全て正の定数配位 τ_+、指数写像を破れボンド数、
値の半環を ℝ に特殊化し、残る「代入を有限和へ配る」段だけを具体版から使う。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueAtLeastOne
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleValueAtLeastOne

namespace Ising2DLambda.ThermodynamicLimit

variable (a b : ℕ)

/-- 具体版の定理を必要十分版から導いたもの。 -/
theorem one_le_openPartitionValue_from_necSuf {t : ℝ} (ht : 0 < t) :
    1 ≤ openPartitionValue a b t := by
  rw [openPartitionValue_eq_sum]
  exact NecSuf.ThermodynamicLimit.one_le_sum_pow_by_separating_zero_exponent_term_necSuf
    (openAllPlusConfig a b) (openBrokenBondCount a b)
    (openAllPlusConfig_openBrokenBondCount_eq_zero a b) ht

end Ising2DLambda.ThermodynamicLimit
