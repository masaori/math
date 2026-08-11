/-
「零でない代数的数を正の個数だけ足した有限和は零でない」の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                      このファイル
  同じ元の有限和は単位元の有限和との積          `qbarRepeatedSumFactorization`
  単位元を正の個数だけ足した有限和は零でない    `qbarUnitSumNeZero`
  零元でない方で割って他方が零元と分かる        `qbarNoZeroDivisors`
  a = 0 が仮定 a ≠ 0 に反する                  `ha`

mathlib の有限和の非零性に関する既製定理へは委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarUnitSumNeZero
import Ising2DLambda.AlgebraicEigenvalue.QbarRepeatedSumFactorization
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 零でない代数的数 a の n 個（n ≥ 1）の有限和は零でない
（`claim_qbar_repeated_sum_ne_zero`）。 -/
theorem qbarRepeatedSumNeZero {a : Qbar} (ha : a ≠ 0) (n : ℕ) (hn : 1 ≤ n) :
    (∑ _i ∈ Finset.range n, a) ≠ 0 := by
  intro hsum_zero
  have hprod_zero : (∑ _i ∈ Finset.range n, (1 : Qbar)) * a = 0 :=
    (qbarRepeatedSumFactorization a n).symm.trans hsum_zero
  have hunit_ne_zero : (∑ _i ∈ Finset.range n, (1 : Qbar)) ≠ 0 :=
    qbarUnitSumNeZero n hn
  exact ha (qbarNoZeroDivisors hunit_ne_zero hprod_zero)

end Ising2DLambda.AlgebraicEigenvalue
