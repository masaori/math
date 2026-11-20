import Ising2DLambda.FisherZero.ImaginaryUnitExtensionZeroCoefficientSquareRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionZeroCoefficientSquareRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の三分法を、代数的数の部分体の正錐から与える。 -/
theorem imaginaryUnitExtension_zeroCoefficient_squareRoot_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (a omega : Qbar) (ha : a ∈ F) (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a := by
  exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_zeroCoefficient_squareRoot
    F C (fun z hz => (hC.trichotomy z hz).1)
    hpositive
    a omega ha homega

end Ising2DLambda.FisherZero
