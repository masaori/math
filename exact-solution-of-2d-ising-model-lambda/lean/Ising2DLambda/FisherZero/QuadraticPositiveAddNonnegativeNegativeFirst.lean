/-
「非負係数条件と負の第一係数条件の和」の具体版。
本文と同じく和の第一係数の符号で分け、負の場合は二つの平方比較をつなぐ
（「非負係数条件と負の第二係数条件の和」の係数交換版）。
-/
import Ising2DLambda.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegative_negativeFirst
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  by_cases hA : 0 ≤ (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1
  · apply Or.inl
    have hBpos : 0 < (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 :=
      add_pos_of_nonneg_of_pos hxi.2.1 heta.2.1
    refine ⟨hA, le_of_lt hBpos, ?_⟩
    intro hPair
    have hB0 : (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 = 0 :=
      congrArg Prod.snd hPair
    exact (ne_of_gt hBpos) hB0
  · apply Or.inr
    apply Or.inr
    have hAneg : (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 < 0 :=
      lt_of_not_ge hA
    have hapA : (quadraticRepresentation s eta).1 ≤
        (quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1 := by
      simpa [add_comm] using
        add_le_add_right hxi.1 (quadraticRepresentation s eta).1
    have hAAp := mul_le_mul_of_nonpos_right hapA (le_of_lt hAneg)
    have hApAp := mul_le_mul_of_nonpos_left hapA (le_of_lt heta.1)
    have hAsq :
        ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) *
          ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) ≤
            (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 :=
      le_trans hAAp hApAp
    have hbpB : (quadraticRepresentation s eta).2 ≤
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 := by
      simpa [add_comm] using
        add_le_add_right hxi.2.1 (quadraticRepresentation s eta).2
    have hBnonneg : 0 ≤
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2 :=
      le_trans (le_of_lt heta.2.1) hbpB
    have hBsq :
        (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 ≤
          ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) *
            ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) :=
      mul_le_mul hbpB hbpB (le_of_lt heta.2.1) hBnonneg
    refine ⟨hAneg, add_pos_of_nonneg_of_pos hxi.2.1 heta.2.1, ?_⟩
    calc
      ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) *
          ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1) ≤
          (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 := hAsq
      _ < 2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 :=
        heta.2.2
      _ ≤ 2 * ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) *
          ((quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) := by
        simpa [mul_assoc] using
          mul_le_mul_of_nonneg_left hBsq (show (0 : ℚ) ≤ 2 by norm_num)

end Ising2DLambda.FisherZero
