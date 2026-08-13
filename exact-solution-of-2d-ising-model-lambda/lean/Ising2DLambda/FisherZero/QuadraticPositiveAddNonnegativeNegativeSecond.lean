/-
「非負係数条件と負の第二係数条件の和」の具体版。
本文と同じく和の第二係数の符号で分け、負の場合は二つの平方比較をつなぐ。
-/
import Ising2DLambda.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegative_negativeSecond
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  by_cases hB : 0 ≤ (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2
  · apply Or.inl
    have hApos : 0 < (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 :=
      add_pos_of_nonneg_of_pos hxi.1 heta.1
    refine ⟨le_of_lt hApos, hB, ?_⟩
    intro hPair
    have hA0 : (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 = 0 :=
      congrArg Prod.fst hPair
    exact (ne_of_gt hApos) hA0
  · apply Or.inr
    apply Or.inl
    have hBneg : (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 < 0 :=
      lt_of_not_ge hB
    have hbpB : (quadraticRepresentation s eta).2 ≤
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 := by
      simpa [add_comm] using
        add_le_add_right hxi.2.1 (quadraticRepresentation s eta).2
    have hBBp := mul_le_mul_of_nonpos_right hbpB (le_of_lt hBneg)
    have hBpBp := mul_le_mul_of_nonpos_left hbpB (le_of_lt heta.2.1)
    have hBsq :
        ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) *
          ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) ≤
            (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 :=
      le_trans hBBp hBpBp
    have hApA : (quadraticRepresentation s eta).1 ≤
        (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 := by
      simpa [add_comm] using
        add_le_add_right hxi.1 (quadraticRepresentation s eta).1
    have hAnonneg : 0 ≤
        (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 :=
      le_trans (le_of_lt heta.1) hApA
    have hAsq :
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 ≤
          ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) *
            ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) :=
      mul_le_mul hApA hApA (le_of_lt heta.1) hAnonneg
    refine ⟨add_pos_of_nonneg_of_pos hxi.1 heta.1, hBneg, ?_⟩
    calc
      2 * ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) *
          ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) ≤
          2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 := by
        simpa [mul_assoc] using
          mul_le_mul_of_nonneg_left hBsq (show (0 : ℚ) ≤ 2 by norm_num)
      _ < (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 := heta.2.2
      _ ≤ ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) *
          ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) := hAsq

end Ising2DLambda.FisherZero
