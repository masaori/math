/-
「非負係数条件と負の第一係数条件の積」の具体版。
本文と同じ手順で証明する: 混合符号の排除で a·a ≠ 2·(b·b) を確かめて二場合に分け、
各場合で片係数の正値を平方比較の背理法で示し、残る係数の符号で
線形比較を平方へ移して正錐の三条件へ振り分ける。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegative_negativeFirst
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  set a := (quadraticRepresentation s xi).1 with ha_def
  set b := (quadraticRepresentation s xi).2 with hb_def
  set ap := (quadraticRepresentation s eta).1 with hap_def
  set bp := (quadraticRepresentation s eta).2 with hbp_def
  set c := -ap with hc_def
  obtain ⟨ha, hb, hNe⟩ := hxi
  obtain ⟨hap0, hbp0, hSqRaw⟩ := heta
  have hSq : c * c < 2 * (bp * bp) := by
    simpa [c, mul_assoc] using hSqRaw
  have hUnequal : a * a ≠ 2 * (b * b) := by
    by_cases hb0 : b = 0
    · intro hEq
      have haa : a * a = 0 := by rw [hEq, hb0]; ring
      exact hNe (Prod.ext (mul_self_eq_zero.mp haa) hb0)
    · exact rationalSquareNeDoubleSquare a b hb0
  rcases lt_or_gt_of_ne hUnequal with hSecond | hFirst
  · -- 本文の第二の場合 a·a < 2·(b·b): まず 0 < A を背理法で示す
    have hbPos : 0 < b := by nlinarith
    have hAPos : 0 < a * ap + 2 * (b * bp) := by
      by_contra hNot
      have hALe : 2 * (b * bp) ≤ a * c := by
        have := not_lt.mp hNot
        nlinarith [hc_def]
      have haPos : 0 < a := by
        rcases eq_or_lt_of_le ha with ha0 | haPos
        · exfalso
          have hLeZero : 2 * (b * bp) ≤ 0 := by simpa [← ha0] using hALe
          exact absurd (by positivity : 0 < 2 * (b * bp)) (not_lt.mpr hLeZero)
        · exact haPos
      have hChain : (2 * (b * b)) * (2 * (bp * bp)) <
          (a * a) * (2 * (bp * bp)) := by
        calc
          (2 * (b * b)) * (2 * (bp * bp))
              = (2 * (b * bp)) * (2 * (b * bp)) := by ring
          _ ≤ (a * c) * (a * c) :=
              mul_self_le_mul_self (by positivity) hALe
          _ = (a * a) * (c * c) := by ring
          _ < (a * a) * (2 * (bp * bp)) :=
              mul_lt_mul_of_pos_left hSq (mul_pos haPos haPos)
      have : 2 * (b * b) < a * a :=
        lt_of_mul_lt_mul_right hChain (by positivity)
      linarith
    by_cases hB : 0 ≤ a * bp + b * ap
    · exact Or.inl ⟨le_of_lt hAPos, hB,
        fun hPair => (ne_of_gt hAPos) (congrArg Prod.fst hPair)⟩
    · have hBNeg : a * bp + b * ap < 0 := lt_of_not_ge hB
      have hLinear : (2 * bp) * (-(a * bp + b * ap)) ≤
          c * (a * ap + 2 * (b * bp)) := by
        have hStep : a * (c * c) ≤ a * (2 * (bp * bp)) :=
          mul_le_mul_of_nonneg_left (le_of_lt hSq) ha
        nlinarith [hStep, hc_def]
      have hLinearNonneg : 0 ≤ (2 * bp) * (-(a * bp + b * ap)) :=
        mul_nonneg (by positivity) (by linarith)
      have hSquare : (2 * (bp * bp)) *
            (2 * ((-(a * bp + b * ap)) * (-(a * bp + b * ap)))) <
          (2 * (bp * bp)) *
            ((a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp))) := by
        calc
          (2 * (bp * bp)) *
                (2 * ((-(a * bp + b * ap)) * (-(a * bp + b * ap))))
              = ((2 * bp) * (-(a * bp + b * ap))) *
                  ((2 * bp) * (-(a * bp + b * ap))) := by ring
          _ ≤ (c * (a * ap + 2 * (b * bp))) *
                (c * (a * ap + 2 * (b * bp))) :=
              mul_self_le_mul_self hLinearNonneg hLinear
          _ = (c * c) *
                ((a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp))) := by ring
          _ < (2 * (bp * bp)) *
                ((a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp))) := by
              exact mul_lt_mul_of_pos_right hSq (mul_pos hAPos hAPos)
      have hFinal : 2 * ((a * bp + b * ap) * (a * bp + b * ap)) <
          (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
        have hCancel := lt_of_mul_lt_mul_left hSquare (by positivity : 0 ≤ 2 * (bp * bp))
        nlinarith
      exact Or.inr (Or.inl ⟨hAPos, hBNeg, by simpa [mul_assoc] using hFinal⟩)
  · -- 本文の第一の場合 2·(b·b) < a·a: まず 0 < B を背理法で示す
    have haPos : 0 < a := by nlinarith
    have hBPos : 0 < a * bp + b * ap := by
      by_contra hNot
      have hBLe : a * bp ≤ b * c := by
        have := not_lt.mp hNot
        nlinarith [hc_def]
      have hbPos : 0 < b := by
        rcases eq_or_lt_of_le hb with hb0 | hbPos
        · exfalso
          have hLeZero : a * bp ≤ 0 := by simpa [← hb0] using hBLe
          exact absurd (mul_pos haPos hbp0) (not_lt.mpr hLeZero)
        · exact hbPos
      have hChain : (a * a) * (bp * bp) < (2 * (b * b)) * (bp * bp) := by
        calc
          (a * a) * (bp * bp) = (a * bp) * (a * bp) := by ring
          _ ≤ (b * c) * (b * c) :=
              mul_self_le_mul_self (mul_nonneg ha (le_of_lt hbp0)) hBLe
          _ = (b * b) * (c * c) := by ring
          _ < (b * b) * (2 * (bp * bp)) :=
              mul_lt_mul_of_pos_left hSq (mul_pos hbPos hbPos)
          _ = (2 * (b * b)) * (bp * bp) := by ring
      have : a * a < 2 * (b * b) :=
        lt_of_mul_lt_mul_right hChain (by positivity)
      linarith
    by_cases hA : 0 ≤ a * ap + 2 * (b * bp)
    · exact Or.inl ⟨hA, le_of_lt hBPos,
        fun hPair => (ne_of_gt hBPos) (congrArg Prod.snd hPair)⟩
    · have hANeg : a * ap + 2 * (b * bp) < 0 := lt_of_not_ge hA
      have hLinear : bp * (-(a * ap + 2 * (b * bp))) ≤
          c * (a * bp + b * ap) := by
        have hStep : b * (c * c) ≤ b * (2 * (bp * bp)) :=
          mul_le_mul_of_nonneg_left (le_of_lt hSq) hb
        nlinarith [hStep, hc_def]
      have hLinearNonneg : 0 ≤ bp * (-(a * ap + 2 * (b * bp))) :=
        mul_nonneg (le_of_lt hbp0) (by linarith)
      have hSquare : (bp * bp) *
            ((-(a * ap + 2 * (b * bp))) * (-(a * ap + 2 * (b * bp)))) <
          (bp * bp) * (2 * ((a * bp + b * ap) * (a * bp + b * ap))) := by
        calc
          (bp * bp) *
                ((-(a * ap + 2 * (b * bp))) * (-(a * ap + 2 * (b * bp))))
              = (bp * (-(a * ap + 2 * (b * bp)))) *
                  (bp * (-(a * ap + 2 * (b * bp)))) := by ring
          _ ≤ (c * (a * bp + b * ap)) * (c * (a * bp + b * ap)) :=
              mul_self_le_mul_self hLinearNonneg hLinear
          _ = (c * c) * ((a * bp + b * ap) * (a * bp + b * ap)) := by ring
          _ < (2 * (bp * bp)) * ((a * bp + b * ap) * (a * bp + b * ap)) := by
              exact mul_lt_mul_of_pos_right hSq (mul_pos hBPos hBPos)
          _ = (bp * bp) * (2 * ((a * bp + b * ap) * (a * bp + b * ap))) := by ring
      have hFinal : (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) <
          2 * ((a * bp + b * ap) * (a * bp + b * ap)) := by
        have hCancel := lt_of_mul_lt_mul_left hSquare (mul_self_nonneg bp)
        nlinarith
      exact Or.inr (Or.inr ⟨hANeg, hBPos, by simpa [mul_assoc] using hFinal⟩)

end Ising2DLambda.FisherZero
