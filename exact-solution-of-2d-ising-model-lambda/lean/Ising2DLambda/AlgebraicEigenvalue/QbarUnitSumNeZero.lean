/-
「単位元を正の個数だけ足した有限和は零でない」の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                      このファイル
  単位元の有限和は自然数の像に等しい            `qbarUnitSumEqRational`
  正の自然数は有理数として零でない              `Nat.cast_ne_zero`
  部分体 ℚ の相等は ℚ̄ の相等の制限である       `map_ne_zero`

mathlib の有限和の非零性に関する既製定理へは委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarUnitSumEqRational

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 単位元 1 の n 個の有限和は、n ≥ 1 ならば零でない
（`claim_qbar_unit_sum_ne_zero`）。 -/
theorem qbarUnitSumNeZero (n : ℕ) (hn : 1 ≤ n) :
    (∑ _i ∈ Finset.range n, (1 : Qbar)) ≠ 0 := by
  calc
    (∑ _i ∈ Finset.range n, (1 : Qbar))
        = algebraMap ℚ Qbar (n : ℚ) := qbarUnitSumEqRational n
    _ ≠ 0 := by
      exact (map_ne_zero (algebraMap ℚ Qbar)).2 (by
        exact_mod_cast (Nat.ne_of_gt hn))

end Ising2DLambda.AlgebraicEigenvalue
