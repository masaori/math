import Ising2DLambda.FisherZero.ImaginaryUnitExtensionNonzeroCoefficientSquareRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionNonzeroCoefficientSquareRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を正錐付き代数的数の部分体に適用する。 -/
theorem imaginaryUnitExtension_nonzeroCoefficient_squareRoot_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w ≠ 0 ∧ w * w = z)
    (a b c omega : Qbar) (ha : a ∈ F) (hb : b ∈ F)
    (hc : c ∈ C) (hb0 : b ≠ 0)
    (hc2 : c * c = a * a + b * b) (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  have hca := sumOfSquares_positiveRoot_plusReal_positive F C hC a b c ha hb hc hb0 hc2
  have hone := one_mem_of_isSubfieldPositiveCone F C hC
  have htwo : (2 : Qbar) ∈ C := by
    convert hC.add_mem 1 1 hone hone using 1 <;> norm_num
  obtain ⟨d, hdF, hd0, hd2⟩ := hpositive (c + a) hca
  obtain ⟨t, htF, ht0, ht2⟩ := hpositive 2 htwo
  exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_nonzeroCoefficient_squareRoot
    F a b c omega d t hb hdF htF hd0 ht0 hc2 hd2 ht2 homega

end Ising2DLambda.FisherZero
