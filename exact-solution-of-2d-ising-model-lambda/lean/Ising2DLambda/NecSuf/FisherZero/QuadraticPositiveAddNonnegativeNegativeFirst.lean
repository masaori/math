/-
「非負係数条件と負の第一係数条件の和」の必要十分版。
二次体を外し、線形順序環上の二つの係数対について同じ場合分けと平方比較を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_negativeFirst_necSuf
    {A : Type} [Ring A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b a' b' : A)
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hap : a' < 0) (hbp : 0 < b') (hSq : a' * a' < 2 * b' * b') :
    (0 ≤ a + a' ∧ 0 ≤ b + b' ∧ (a + a', b + b') ≠ (0, 0)) ∨
      (a + a' < 0 ∧ 0 < b + b' ∧
        (a + a') * (a + a') < 2 * (b + b') * (b + b')) := by
  by_cases hA : 0 ≤ a + a'
  · apply Or.inl
    have hBpos : 0 < b + b' := add_pos_of_nonneg_of_pos hb hbp
    refine ⟨hA, le_of_lt hBpos, ?_⟩
    intro hPair
    have hB0 : b + b' = 0 := congrArg Prod.snd hPair
    exact (ne_of_gt hBpos) hB0
  · apply Or.inr
    have hAneg : a + a' < 0 := lt_of_not_ge hA
    have hapA : a' ≤ a + a' := by
      simpa [add_comm] using add_le_add_right ha a'
    have hAAp : (a + a') * (a + a') ≤ a' * (a + a') :=
      mul_le_mul_of_nonpos_right hapA (le_of_lt hAneg)
    have hApAp : a' * (a + a') ≤ a' * a' :=
      mul_le_mul_of_nonpos_left hapA (le_of_lt hap)
    have hAsq : (a + a') * (a + a') ≤ a' * a' := le_trans hAAp hApAp
    have hbpB : b' ≤ b + b' := by
      simpa [add_comm] using add_le_add_right hb b'
    have hBnonneg : 0 ≤ b + b' := le_trans (le_of_lt hbp) hbpB
    have hBsq : b' * b' ≤ (b + b') * (b + b') :=
      mul_le_mul hbpB hbpB (le_of_lt hbp) hBnonneg
    refine ⟨hAneg, add_pos_of_nonneg_of_pos hb hbp, ?_⟩
    calc
      (a + a') * (a + a') ≤ a' * a' := hAsq
      _ < 2 * b' * b' := hSq
      _ ≤ 2 * (b + b') * (b + b') := by
        simpa [mul_assoc] using mul_le_mul_of_nonneg_left hBsq (show (0 : A) ≤ 2 by norm_num)

end Ising2DLambda.NecSuf.FisherZero
