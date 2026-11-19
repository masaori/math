import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegree
import Ising2DLambda.FisherZero.SumOfSquaresRootNonnegativeSign

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 非零の虚係数について、平方和の正の根と実係数の和は正錐に属する。 -/
theorem sumOfSquares_positiveRoot_plusReal_positive
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (a b c : Qbar) (ha : a ∈ F) (hb : b ∈ F) (hc : c ∈ C)
    (hb0 : b ≠ 0) (hc2 : c * c = a * a + b * b) : c + a ∈ C := by
  have hzero : (0 : Qbar) ∉ C := by
    intro h
    exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩
  have hb2 : b * b ∈ C := mul_self_mem_of_isSubfieldPositiveCone F C hC b hb hb0
  have hsumF : c + a ∈ F := F.add_mem (hC.subset c hc) ha
  rcases (hC.trichotomy (c + a) hsumF).1 with hz | hp | hn
  · have hbzero : b * b = 0 := by
      have hca : c = -a := by linear_combination hz
      rw [hca] at hc2
      linear_combination -hc2
    exact False.elim (hzero (hbzero ▸ hb2))
  · exact hp
  · have hnega : -a ∈ C := by
      convert hC.add_mem _ _ hn hc using 1 <;> ring
    have hdiff : c - a ∈ C := by
      convert hC.add_mem _ _ hc hnega using 1 <;> ring
    have hnegB : -(b * b) ∈ C := by
      have hprod := hC.mul_mem _ _ hn hdiff
      convert hprod using 1
      linear_combination hc2
    have hbad : (0 : Qbar) ∈ C := by
      convert hC.add_mem _ _ hb2 hnegB using 1 <;> ring
    exact False.elim (hzero hbad)

end Ising2DLambda.FisherZero
