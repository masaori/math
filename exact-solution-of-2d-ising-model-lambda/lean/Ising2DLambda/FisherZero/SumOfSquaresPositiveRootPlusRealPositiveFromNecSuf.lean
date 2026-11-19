import Ising2DLambda.FisherZero.SumOfSquaresPositiveRootPlusRealPositive
import Ising2DLambda.NecSuf.FisherZero.SumOfSquaresPositiveRootPlusRealPositive

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の正錐へ当てた導出版。 -/
theorem sumOfSquares_positiveRoot_plusReal_positive_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (a b c : Qbar) (ha : a ∈ F) (hb : b ∈ F) (hc : c ∈ C)
    (hb0 : b ≠ 0) (hc2 : c * c = a * a + b * b) : c + a ∈ C := by
  exact Ising2DLambda.NecSuf.FisherZero.sumOfSquares_positiveRoot_plusReal_positive C
    hC.add_mem hC.mul_mem
    (by intro h; exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩)
    a b c hc
    (mul_self_mem_of_isSubfieldPositiveCone F C hC b hb hb0)
    hc2 (hC.trichotomy (c + a) (F.add_mem (hC.subset c hc) ha)).1

end Ising2DLambda.FisherZero
