/-
「非負有理数の平方の大小から大小」の具体版。
人手証明と同じく、反対向きの広義不等式を仮定し、非負元を掛ける二段と
推移律で平方の大小を反転させ、狭義順序の非反射性と矛盾させる。
-/
import Mathlib

namespace Ising2DLambda.FisherZero

/-- `claim_rational_square_lt_implies_lt` の具体版。 -/
theorem rationalSquareLtImpliesLt
    (p q : ℚ) (hp : 0 ≤ p) (hq : 0 ≤ q)
    (hSquare : p * p < q * q) : p < q := by
  by_contra hNotLt
  have hqp : q ≤ p := le_of_not_gt hNotLt
  have hqq_le_pq : q * q ≤ p * q :=
    mul_le_mul_of_nonneg_right hqp hq
  have hpq_le_pp : p * q ≤ p * p :=
    mul_le_mul_of_nonneg_left hqp hp
  have hqq_le_pp : q * q ≤ p * p :=
    le_trans hqq_le_pq hpq_le_pp
  have hSelf : p * p < p * p :=
    lt_of_lt_of_le hSquare hqq_le_pp
  exact (lt_irrefl (p * p)) hSelf

end Ising2DLambda.FisherZero
