import Ising2DLambda.FisherZero.QuadraticLinearValuesAdjoin
import Ising2DLambda.NecSuf.FisherZero.QuadraticLinearValuesAdjoin

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版から同じ一次式表示を得る。 -/
theorem quadraticLinearValues_eq_adjoin_from_necSuf (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) (hbF : b ∉ F) :
    quadraticLinearValues F b =
      (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) : Set Qbar) := by
  let S : Subfield Qbar := {
    carrier := quadraticLinearValues F b
    zero_mem' := (quadraticLinearValues_ringClosed F a b ha hb).1
    one_mem' := (quadraticLinearValues_ringClosed F a b ha hb).2.1
    add_mem' := by intros x y hx hy; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.1 x y hx hy
    neg_mem' := by intros x hx; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.2.1 x hx
    mul_mem' := by intros x y hx hy; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.2.2 x y hx hy
    inv_mem' := by
      intro y hy
      by_cases hy0 : y = 0
      · simpa [hy0] using (quadraticLinearValues_ringClosed F a b ha hb).1
      · exact quadraticLinearValues_inv_mem F a b ha hb hbF y hy hy0
  }
  exact Ising2DLambda.NecSuf.FisherZero.quadraticLinearValues_eq_adjoin_necSuf
    F S b rfl

end Ising2DLambda.FisherZero
