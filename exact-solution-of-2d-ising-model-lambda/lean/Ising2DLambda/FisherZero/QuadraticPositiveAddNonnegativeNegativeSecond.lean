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
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let B := b + bp
  have ha : 0 ≤ a := hxi.1
  have hb : 0 ≤ b := hxi.2.1
  have hap : 0 < ap := heta.1
  have hbp : bp < 0 := heta.2.1
  have hSq : 2 * (bp * bp) < ap * ap := by
    simpa only [mul_assoc] using heta.2.2
  -- 本文の和の表示。B は第二係数の和の別名である。
  have hRep : quadraticRepresentation s (quadraticAddElement s xi eta) =
      (a + ap, B) := quadraticRepresentation_add s hs xi eta
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  by_cases hB : 0 ≤ B
  · have hApos : 0 < a + ap := add_pos_of_nonneg_of_pos ha hap
    have hAnonneg : 0 ≤ a + ap := le_of_lt hApos
    have hPair : (a + ap, B) ≠ (0, 0) := by
      intro hZero
      have hA0 : a + ap = 0 := congrArg Prod.fst hZero
      exact (ne_of_gt hApos) hA0
    exact Or.inl ⟨hAnonneg, hB, hPair⟩
  · have hBneg : B < 0 := lt_of_not_ge hB
    -- 第二係数の鎖は零元則・加法単調性・B の定義の三行。
    have hbpB : bp ≤ B := by
      calc
        bp = 0 + bp := (zero_add bp).symm
        _ ≤ b + bp := _root_.add_le_add hb (le_refl bp)
        _ = B := rfl
    have hBsq : B * B ≤ bp * bp := by
      calc
        B * B ≤ bp * B := mul_le_mul_of_nonpos_right hbpB (le_of_lt hBneg)
        _ ≤ bp * bp := mul_le_mul_of_nonpos_left hbpB (le_of_lt hbp)
    -- 第一係数の正値性を出し、平方は一度に片方の因子だけを比較する。
    have hApA : ap ≤ a + ap := by
      calc
        ap = 0 + ap := (zero_add ap).symm
        _ ≤ a + ap := _root_.add_le_add ha (le_refl ap)
    have hApos : 0 < a + ap := lt_of_lt_of_le hap hApA
    have hAsq : ap * ap ≤ (a + ap) * (a + ap) := by
      calc
        ap * ap ≤ (a + ap) * ap := mul_le_mul_of_nonneg_right hApA (le_of_lt hap)
        _ ≤ (a + ap) * (a + ap) :=
          mul_le_mul_of_nonneg_left hApA (le_of_lt hApos)
    have hSumSq : 2 * (B * B) < (a + ap) * (a + ap) := by
      calc
        2 * (B * B) ≤ 2 * (bp * bp) :=
          mul_le_mul_of_nonneg_left hBsq (show (0 : ℚ) ≤ 2 by norm_num)
        _ < ap * ap := hSq
        _ ≤ (a + ap) * (a + ap) := hAsq
    apply Or.inr
    apply Or.inl
    refine ⟨hApos, hBneg, ?_⟩
    simpa only [mul_assoc] using hSumSq

end Ising2DLambda.FisherZero
