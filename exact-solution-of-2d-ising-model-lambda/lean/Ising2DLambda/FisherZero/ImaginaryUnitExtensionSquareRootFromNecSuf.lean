import Ising2DLambda.FisherZero.ImaginaryUnitExtensionSquareRoot
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionSquareRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体的な正錐から、必要十分版の平方和の証人を供給する。 -/
theorem imaginaryUnitExtension_squareRoot_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (a b omega : Qbar) (ha : a ∈ F) (hb : b ∈ F)
    (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  apply Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_squareRoot
    F C (fun z hz => (hC.trichotomy z hz).1) hpositive
  · intro x y hx hy hy0
    have hsum : x * x + y * y ∈ C := by
      by_cases hx0 : x = 0
      · simpa [hx0] using mul_self_mem_of_isSubfieldPositiveCone F C hC y hy hy0
      · exact hC.add_mem _ _
          (mul_self_mem_of_isSubfieldPositiveCone F C hC x hx hx0)
          (mul_self_mem_of_isSubfieldPositiveCone F C hC y hy hy0)
    obtain ⟨c, hcF, hc2⟩ := hpositive (x * x + y * y) hsum
    have hc0 : c ≠ 0 := by
      intro hzero
      have hsum0 : x * x + y * y = 0 := by simpa [hzero] using hc2.symm
      exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, hsum0 ▸ hsum⟩
    rcases (hC.trichotomy c hcF).1 with hz | hp | hn
    · exact False.elim (hc0 hz)
    · have hca := sumOfSquares_positiveRoot_plusReal_positive
        F C hC x y c hx hy hp hy0 hc2
      obtain ⟨d, hdF, hd2⟩ := hpositive (c + x) hca
      have hd0 : d ≠ 0 := by
        intro hzero
        have hca0 : c + x = 0 := by simpa [hzero] using hd2.symm
        exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, hca0 ▸ hca⟩
      exact ⟨c, d, hdF, hd0, hc2, hd2⟩
    · have hc2' : (-c) * (-c) = x * x + y * y := by
        simpa only [neg_mul_neg] using hc2
      have hca := sumOfSquares_positiveRoot_plusReal_positive
        F C hC x y (-c) hx hy hn hy0 hc2'
      obtain ⟨d, hdF, hd2⟩ := hpositive (-c + x) hca
      have hd0 : d ≠ 0 := by
        intro hzero
        have hca0 : -c + x = 0 := by simpa [hzero] using hd2.symm
        exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, hca0 ▸ hca⟩
      exact ⟨-c, d, hdF, hd0, hc2', hd2⟩
  · have hone : (1 : Qbar) ∈ C := one_mem_of_isSubfieldPositiveCone F C hC
    have htwo : (2 : Qbar) ∈ C := by
      convert hC.add_mem 1 1 hone hone using 1 <;> norm_num
    obtain ⟨t, htF, ht2⟩ := hpositive 2 htwo
    have ht0 : t ≠ 0 := by
      intro ht
      norm_num [ht] at ht2
    exact ⟨t, htF, ht0, ht2⟩
  · exact ha
  · exact hb
  · exact homega

end Ising2DLambda.FisherZero
