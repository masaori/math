/-
「非負有理数の平方の大小から大小」の必要十分版。
人手証明で使う二つの乗法単調性、二つの推移、非反射性、全順序の最後の一歩だけを
個別の仮定として受け取り、同じ背理法を通す。型には順序構造も乗法構造も要求しない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 人手証明の二段の不等式鎖と背理法に必要な性質だけを要求する。 -/
theorem rational_square_lt_implies_lt_necSuf
    {A : Type}
    (zero : A) (mul : A → A → A) (le lt : A → A → Prop)
    (p q : A)
    (hp : le zero p) (hq : le zero q)
    (hSquare : lt (mul p p) (mul q q))
    (hMulRight : le zero q → le q p → le (mul q q) (mul p q))
    (hMulLeft : le zero p → le q p → le (mul p q) (mul p p))
    (hLeTrans : le (mul q q) (mul p q) → le (mul p q) (mul p p) →
      le (mul q q) (mul p p))
    (hLtLeTrans : lt (mul p p) (mul q q) → le (mul q q) (mul p p) →
      lt (mul p p) (mul p p))
    (hLtIrrefl : ¬ lt (mul p p) (mul p p))
    (hLtOfNotGe : (¬ le q p) → lt p q) :
    lt p q := by
  by_contra hNotLt
  have hqp : le q p := by
    by_contra hNotGe
    exact hNotLt (hLtOfNotGe hNotGe)
  have hqq_le_pq : le (mul q q) (mul p q) := hMulRight hq hqp
  have hpq_le_pp : le (mul p q) (mul p p) := hMulLeft hp hqp
  have hqq_le_pp : le (mul q q) (mul p p) := hLeTrans hqq_le_pq hpq_le_pp
  have hSelf : lt (mul p p) (mul p p) := hLtLeTrans hSquare hqq_le_pp
  exact hLtIrrefl hSelf

end Ising2DLambda.NecSuf.FisherZero
