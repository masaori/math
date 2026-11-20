/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
差・積・逆元の閉性は `Subfield` から、`ω ∉ F` は `claim_imaginary_unit_outside_ordered_subfield` から渡す。 -/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionUniqueRepresentation
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionUniqueRepresentation
import Ising2DLambda.FisherZero.ImaginaryUnitOutsideOrderedSubfieldFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_imaginary_unit_extension_unique_representation` を必要十分版から得る。 -/
theorem imaginaryUnitExtension_unique_representation_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1)
    (a a' b b' : Qbar) (ha : a ∈ F) (ha' : a' ∈ F) (hb : b ∈ F) (hb' : b' ∈ F)
    (h : a + b * omega = a' + b' * omega) :
    a = a' ∧ b = b' :=
  Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_unique_representation_necSuf
    (F : Set Qbar) (fun _ _ hx hy => F.sub_mem hx hy) (fun _ _ hx hy => F.mul_mem hx hy)
    (fun _ hx => F.inv_mem hx) omega
    (imaginaryUnit_not_mem_orderedSubfield_from_necSuf F C hC omega homega)
    a a' b b' ha ha' hb hb' h

end Ising2DLambda.FisherZero
