import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegree

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正錐の和の閉性と非零平方の正性から、虚数単位は部分体の外にある。 -/
theorem imaginaryUnit_not_mem_orderedSubfield
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) : omega ∉ F := by
  have hzero : (0 : Qbar) ∉ C := by
    intro h
    exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h⟩
  have hone : (1 : Qbar) ∈ C := by
    simpa using mul_self_mem_of_isSubfieldPositiveCone F C hC 1 F.one_mem (by norm_num)
  have hminus : (-1 : Qbar) ∉ C := by
    intro h
    have hsum : (1 : Qbar) + -1 ∈ C := hC.add_mem 1 (-1) hone h
    have hsum0 : (1 : Qbar) + -1 = 0 := by ring
    exact hzero (hsum0 ▸ hsum)
  intro hmem
  have hne : omega ≠ 0 := by
    intro hz
    norm_num [hz] at homega
  have hsquare : omega * omega ∈ C :=
    mul_self_mem_of_isSubfieldPositiveCone F C hC omega hmem hne
  exact hminus (homega ▸ hsquare)

end Ising2DLambda.FisherZero
