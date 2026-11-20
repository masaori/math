import Ising2DLambda.FisherZero.ImaginaryUnitOutsideOrderedSubfield
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitOutsideOrderedSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の正錐へ適用する。 -/
theorem imaginaryUnit_not_mem_orderedSubfield_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) : omega ∉ F := by
  apply Ising2DLambda.NecSuf.FisherZero.imaginaryUnit_not_mem_orderedSubfield
    F C
  · intro h
    exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩
  · exact one_mem_of_isSubfieldPositiveCone F C hC
  · exact hC.add_mem
  · intro x hx hx0
    exact mul_self_mem_of_isSubfieldPositiveCone F C hC x hx hx0
  · exact homega

end Ising2DLambda.FisherZero
