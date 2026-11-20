import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionZeroCoefficientSquareRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionNonzeroCoefficientSquareRoot

namespace Ising2DLambda.NecSuf.FisherZero

/-- 零の場合、正の平方和根がある非零の場合を合わせるのに必要な条件。 -/
theorem imaginaryUnitExtension_squareRoot
    {K : Type*} [Field K] (F : Subfield K) (C : Set K)
    (htri : ∀ a : K, a ∈ F → a = 0 ∨ a ∈ C ∨ -a ∈ C)
    (hpositive : ∀ z : K, z ∈ C →
      ∃ w : K, w ∈ F ∧ w * w = z)
    (hchoose : ∀ a b : K, a ∈ F → b ∈ F → b ≠ 0 →
      ∃ c d : K, d ∈ F ∧ d ≠ 0 ∧
        c * c = a * a + b * b ∧ d * d = c + a)
    (htwo : ∃ t : K, t ∈ F ∧ t ≠ 0 ∧ t * t = 2)
    (a b omega : K) (ha : a ∈ F) (hb : b ∈ F)
    (homega : omega * omega = -1) :
    ∃ u v : K, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  by_cases hb0 : b = 0
  · obtain ⟨u, v, hu, hv, hroot⟩ :=
      imaginaryUnitExtension_zeroCoefficient_squareRoot F C htri hpositive a omega ha homega
    exact ⟨u, v, hu, hv, by simpa [hb0] using hroot⟩
  · obtain ⟨c, d, hdF, hd0, hc2, hd2⟩ := hchoose a b ha hb hb0
    obtain ⟨t, htF, ht0, ht2⟩ := htwo
    exact imaginaryUnitExtension_nonzeroCoefficient_squareRoot F a b c omega d t
      hb hdF htF hd0 ht0 hc2 hd2 ht2 homega

end Ising2DLambda.NecSuf.FisherZero
