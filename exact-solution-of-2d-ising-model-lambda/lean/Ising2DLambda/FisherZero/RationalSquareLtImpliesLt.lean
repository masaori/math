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
  have hNotGe : ¬ q ≤ p := by
    intro hqp
    -- 第一の鎖の右乗法の行。
    have hqq_le_pq : q * q ≤ p * q :=
      mul_le_mul_of_nonneg_right hqp hq
    -- 第一の鎖の左乗法の行。
    have hpq_le_pp : p * q ≤ p * p :=
      mul_le_mul_of_nonneg_left hqp hp
    -- 第二の鎖の広義不等式は第一の鎖の推移律で得る。
    have hqq_le_pp : q * q ≤ p * p :=
      le_trans hqq_le_pq hpq_le_pp
    -- 第二の鎖から本文末尾の自己への狭義不等式を得る。
    have hSelf : p * p < p * p :=
      lt_of_lt_of_le hSquare hqq_le_pp
    exact (lt_irrefl (p * p)) hSelf
  exact lt_of_not_ge hNotGe

end Ising2DLambda.FisherZero
