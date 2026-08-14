/-
具体版が必要十分版の特殊化として得られることを明示する。

有限添字型を配位、選ぶ一項を全て正の配位、指数写像を破れボンド数、値の半環を ℝ
に特殊化し、残る「代入を有限和へ配る」段だけを具体版から使う。
-/
import Ising2DLambda.ThermodynamicLimit.PartitionValuePositive
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 具体版の定理を必要十分版から導いたもの。 -/
theorem partitionPolynomial_eval_real_pos_from_necSuf {t : ℝ} (ht : 0 < t) :
    0 < Polynomial.aeval t (partitionPolynomial L) := by
  rw [eval_partitionPolynomial_real L t]
  exact NecSuf.ThermodynamicLimit.sum_pow_pos_by_separating_term_necSuf
    (allPlusConfig L) (brokenBondCount L) ht

end Ising2DLambda.ThermodynamicLimit
