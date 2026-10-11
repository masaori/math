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
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let A := a + ap
  have ha : 0 ≤ a := hxi.1
  have hb : 0 ≤ b := hxi.2.1
  have hap : ap < 0 := heta.1
  have hbp : 0 < bp := heta.2.1
  have hSq : ap * ap < 2 * (bp * bp) := by
    simpa only [mul_assoc] using heta.2.2
  have hRep : quadraticRepresentation s (quadraticAddElement s xi eta) =
      (A, b + bp) := quadraticRepresentation_add s hs xi eta
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  by_cases hA : 0 ≤ A
  · have hBpos : 0 < b + bp := add_pos_of_nonneg_of_pos hb hbp
    have hBnonneg : 0 ≤ b + bp := le_of_lt hBpos
    have hPair : (A, b + bp) ≠ (0, 0) := by
      intro hZero
      have hB0 : b + bp = 0 := congrArg Prod.snd hZero
      exact (ne_of_gt hBpos) hB0
    exact Or.inl ⟨hA, hBnonneg, hPair⟩
  · have hAneg : A < 0 := lt_of_not_ge hA
    have hapA : ap ≤ A := by
      calc
        ap = 0 + ap := (zero_add ap).symm
        _ ≤ a + ap := _root_.add_le_add ha (le_refl ap)
        _ = A := rfl
    have hAsq : A * A ≤ ap * ap := by
      calc
        A * A ≤ ap * A := mul_le_mul_of_nonpos_right hapA (le_of_lt hAneg)
        _ ≤ ap * ap := mul_le_mul_of_nonpos_left hapA (le_of_lt hap)
    have hbpB : bp ≤ b + bp := by
      calc
        bp = 0 + bp := (zero_add bp).symm
        _ ≤ b + bp := _root_.add_le_add hb (le_refl bp)
    have hBpos : 0 < b + bp := lt_of_lt_of_le hbp hbpB
    have hBsq : bp * bp ≤ (b + bp) * (b + bp) := by
      calc
        bp * bp ≤ (b + bp) * bp := mul_le_mul_of_nonneg_right hbpB (le_of_lt hbp)
        _ ≤ (b + bp) * (b + bp) :=
          mul_le_mul_of_nonneg_left hbpB (le_of_lt hBpos)
    have hSumSq : A * A < 2 * ((b + bp) * (b + bp)) := by
      calc
        A * A ≤ ap * ap := hAsq
        _ < 2 * (bp * bp) := hSq
        _ ≤ 2 * ((b + bp) * (b + bp)) :=
          mul_le_mul_of_nonneg_left hBsq (show (0 : ℚ) ≤ 2 by norm_num)
    apply Or.inr
    apply Or.inr
    refine ⟨hAneg, hBpos, ?_⟩
    simpa only [mul_assoc] using hSumSq

end Ising2DLambda.FisherZero
