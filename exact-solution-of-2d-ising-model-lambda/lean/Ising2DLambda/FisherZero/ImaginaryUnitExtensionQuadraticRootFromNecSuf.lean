import Ising2DLambda.FisherZero.ImaginaryUnitExtensionQuadraticRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionQuadraticRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版で使う平方根補題を必要十分版の仮定へ渡す。 -/
theorem imaginaryUnitExtension_quadraticRoot_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (omega e p q : Qbar) (homega : omega * omega = -1)
    (he0 : e ≠ 0)
    (he : e ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (hp : p ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (hq : q ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar))) :
    ∃ r x y : Qbar, x ∈ F ∧ y ∈ F ∧ r = x + y * omega ∧
      e * (r * r) + p * r + q = 0 := by
  have hnot : omega ∉ F := imaginaryUnit_not_mem_orderedSubfield F C hC omega homega
  have hlin := quadraticLinearValues_eq_adjoin F (-1) omega
    (F.neg_mem F.one_mem) homega hnot
  exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_quadraticRoot F
    (Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (by norm_num) omega
    (fun A B hA hB =>
      imaginaryUnitExtension_squareRoot F C hC hpositive A B omega hA hB homega)
    e p q homega he0 he hp hq (by
      intro z hz
      have hz' : z ∈ quadraticLinearValues F omega := by
        rw [hlin]
        exact hz
      exact hz')

end Ising2DLambda.FisherZero
