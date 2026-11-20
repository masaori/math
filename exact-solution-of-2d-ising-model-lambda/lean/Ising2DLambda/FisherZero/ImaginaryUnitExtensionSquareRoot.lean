import Ising2DLambda.FisherZero.ImaginaryUnitExtensionZeroCoefficientSquareRoot
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionNonzeroCoefficientSquareRoot
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 虚係数の零・非零を分け、非零の場合は平方和の根の符号を正錐で選ぶ。 -/
theorem imaginaryUnitExtension_squareRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (a b omega : Qbar) (ha : a ∈ F) (hb : b ∈ F)
    (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  by_cases hb0 : b = 0
  · obtain ⟨u, v, hu, hv, hroot⟩ :=
      imaginaryUnitExtension_zeroCoefficient_squareRoot F C hC hpositive a omega ha homega
    exact ⟨u, v, hu, hv, by simpa [hb0] using hroot⟩
  · have hsum : a * a + b * b ∈ C := by
      by_cases ha0 : a = 0
      · simpa [ha0] using mul_self_mem_of_isSubfieldPositiveCone F C hC b hb hb0
      · exact hC.add_mem _ _
          (mul_self_mem_of_isSubfieldPositiveCone F C hC a ha ha0)
          (mul_self_mem_of_isSubfieldPositiveCone F C hC b hb hb0)
    have hpositiveNonzero : ∀ z : Qbar, z ∈ C →
        ∃ w : Qbar, w ∈ F ∧ w ≠ 0 ∧ w * w = z := by
      intro z hz
      obtain ⟨w, hwF, hw2⟩ := hpositive z hz
      have hw0 : w ≠ 0 := by
        intro hw
        have hz0 : z = 0 := by simpa [hw] using hw2.symm
        exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, hz0 ▸ hz⟩
      exact ⟨w, hwF, hw0, hw2⟩
    obtain ⟨c, hcF, hc2⟩ := hpositive (a * a + b * b) hsum
    have hc0 : c ≠ 0 := by
      intro hzero
      have hsum0 : a * a + b * b = 0 := by simpa [hzero] using hc2.symm
      exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, hsum0 ▸ hsum⟩
    rcases (hC.trichotomy c hcF).1 with hz | hp | hn
    · exact False.elim (hc0 hz)
    · exact imaginaryUnitExtension_nonzeroCoefficient_squareRoot
        F C hC hpositiveNonzero a b c omega ha hb hp hb0 hc2 homega
    · exact imaginaryUnitExtension_nonzeroCoefficient_squareRoot
        F C hC hpositiveNonzero a b (-c) omega ha hb hn hb0
        (by simpa only [neg_mul_neg] using hc2) homega

end Ising2DLambda.FisherZero
