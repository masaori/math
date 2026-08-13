/-
「非負係数条件と負の第二係数条件の和」の必要十分版。
二次体を外し、線形順序環上の二つの係数対について同じ場合分けと平方比較を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_negativeSecond_necSuf
    {A : Type} [Ring A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b a' b' : A)
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hap : 0 < a') (hbp : b' < 0) (hSq : 2 * b' * b' < a' * a') :
    (0 ≤ a + a' ∧ 0 ≤ b + b' ∧ (a + a', b + b') ≠ (0, 0)) ∨
      (0 < a + a' ∧ b + b' < 0 ∧
        2 * (b + b') * (b + b') < (a + a') * (a + a')) := by
  by_cases hB : 0 ≤ b + b'
  · apply Or.inl
    have hApos : 0 < a + a' := add_pos_of_nonneg_of_pos ha hap
    refine ⟨le_of_lt hApos, hB, ?_⟩
    intro hPair
    have hA0 : a + a' = 0 := congrArg Prod.fst hPair
    exact (ne_of_gt hApos) hA0
  · apply Or.inr
    have hBneg : b + b' < 0 := lt_of_not_ge hB
    have hbpB : b' ≤ b + b' := by
      simpa [add_comm] using add_le_add_right hb b'
    have hBBp : (b + b') * (b + b') ≤ b' * (b + b') :=
      mul_le_mul_of_nonpos_right hbpB (le_of_lt hBneg)
    have hBpBp : b' * (b + b') ≤ b' * b' :=
      mul_le_mul_of_nonpos_left hbpB (le_of_lt hbp)
    have hBsq : (b + b') * (b + b') ≤ b' * b' := le_trans hBBp hBpBp
    have hApA : a' ≤ a + a' := by
      simpa [add_comm] using add_le_add_right ha a'
    have hAnonneg : 0 ≤ a + a' := le_trans (le_of_lt hap) hApA
    have hAsq : a' * a' ≤ (a + a') * (a + a') :=
      mul_le_mul hApA hApA (le_of_lt hap) hAnonneg
    refine ⟨add_pos_of_nonneg_of_pos ha hap, hBneg, ?_⟩
    calc
      2 * (b + b') * (b + b') ≤ 2 * b' * b' := by
        simpa [mul_assoc] using mul_le_mul_of_nonneg_left hBsq (show (0 : A) ≤ 2 by norm_num)
      _ < a' * a' := hSq
      _ ≤ (a + a') * (a + a') := hAsq

end Ising2DLambda.NecSuf.FisherZero
