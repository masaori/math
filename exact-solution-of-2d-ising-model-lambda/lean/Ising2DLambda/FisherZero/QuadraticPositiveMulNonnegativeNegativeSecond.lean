/-
「非負係数条件と負の第二係数条件の積」の具体版。
本文と同じ手順で証明する: 混合符号の排除で a·a ≠ 2·(b·b) を確かめて二場合に分け、
各場合で片係数の正値を平方比較の背理法で示し、残る係数の符号で
線形比較を平方へ移して正錐の三条件へ振り分ける。
本文の u := -b' は、ここでは -(quadraticRepresentation s eta).2 を直接書く。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegative_negativeSecond
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  set a := (quadraticRepresentation s xi).1 with ha_def
  set b := (quadraticRepresentation s xi).2 with hb_def
  set ap := (quadraticRepresentation s eta).1 with hap_def
  set bp := (quadraticRepresentation s eta).2 with hbp_def
  obtain ⟨ha, hb, hNe⟩ := hxi
  obtain ⟨hap0, hbp0, hSq⟩ := heta
  -- 本文: 混合符号の排除（claim_rational_square_ne_double_square）により a·a ≠ 2·(b·b)
  have hUnequal : a * a ≠ 2 * (b * b) := by
    by_cases hb0 : b = 0
    · intro hEq
      have haa : a * a = 0 := by rw [hEq, hb0]; ring
      exact hNe (Prod.ext (mul_self_eq_zero.mp haa) hb0)
    · exact rationalSquareNeDoubleSquare a b hb0
  -- 本文: Q の順序の三分律で二場合に分ける
  rcases lt_or_gt_of_ne hUnequal with hCaseSecond | hCaseFirst
  · -- 本文の第二の場合 a·a < 2·(b·b): まず 0 < B を背理法で示す
    have hbPos : 0 < b := by nlinarith
    have hBPos : 0 < a * bp + b * ap := by
      by_contra hNot
      -- B ≤ 0 なので 0 < b·ap ≤ a·(-bp)
      have hBLe : b * ap ≤ a * (-bp) := by
        have := not_lt.mp hNot
        linarith
      have haPos : 0 < a := by
        rcases eq_or_lt_of_le ha with ha0 | haPos
        · exfalso
          have hLeZero : b * ap ≤ 0 := by
            have := hBLe
            rw [← ha0, zero_mul] at this
            exact this
          exact absurd (mul_pos hbPos hap0) (not_lt.mpr hLeZero)
        · exact haPos
      -- 本文の鎖: 2·((b·b)·(ap·ap)) = 2·((b·ap)·(b·ap)) ≤ 2·((a·(-bp))·(a·(-bp)))
      --           = (a·a)·(2·(bp·bp)) < (a·a)·(ap·ap)
      have hChain : (2 * (b * b)) * (ap * ap) < (a * a) * (ap * ap) := by
        calc (2 * (b * b)) * (ap * ap)
            = 2 * ((b * ap) * (b * ap)) := by ring
          _ ≤ 2 * ((a * (-bp)) * (a * (-bp))) := by
              have hSqLe : (b * ap) * (b * ap) ≤ (a * (-bp)) * (a * (-bp)) :=
                mul_self_le_mul_self (mul_nonneg hb (le_of_lt hap0)) hBLe
              linarith
          _ = (a * a) * (2 * (bp * bp)) := by ring
          _ < (a * a) * (ap * ap) :=
              mul_lt_mul_of_pos_left (by linarith [hSq]) (mul_pos haPos haPos)
      -- 正因子 ap·ap を消去すると第二の場合に反する
      have : 2 * (b * b) < a * a :=
        lt_of_mul_lt_mul_right hChain (by positivity)
      linarith
    by_cases hA : 0 ≤ a * ap + 2 * (b * bp)
    · -- 表示は正錐の非負係数条件を満たす
      exact Or.inl ⟨hA, le_of_lt hBPos,
        fun hPair => (ne_of_gt hBPos) (congrArg Prod.snd hPair)⟩
    · -- A < 0: 本文の C := -A。線形比較 ap·C ≤ (2·(-bp))·B を作る
      have hANeg : a * ap + 2 * (b * bp) < 0 := lt_of_not_ge hA
      have hLinear : ap * (-(a * ap + 2 * (b * bp))) ≤
          (2 * (-bp)) * (a * bp + b * ap) := by
        have hStep : a * (2 * (bp * bp)) ≤ a * (ap * ap) :=
          mul_le_mul_of_nonneg_left (by linarith [hSq]) ha
        nlinarith [hStep]
      have hLinearNonneg : 0 ≤ ap * (-(a * ap + 2 * (b * bp))) :=
        mul_nonneg (le_of_lt hap0) (by linarith)
      -- 本文の平方の鎖: (ap·ap)·(C·C) = (ap·C)² ≤ ((2·(-bp))·B)²
      --                = (2·(bp·bp))·(2·(B·B)) < (ap·ap)·(2·(B·B))
      have hSquare : (ap * ap) *
            ((-(a * ap + 2 * (b * bp))) * (-(a * ap + 2 * (b * bp)))) <
          (ap * ap) * (2 * ((a * bp + b * ap) * (a * bp + b * ap))) := by
        calc (ap * ap) *
              ((-(a * ap + 2 * (b * bp))) * (-(a * ap + 2 * (b * bp))))
            = (ap * (-(a * ap + 2 * (b * bp)))) *
                (ap * (-(a * ap + 2 * (b * bp)))) := by ring
          _ ≤ ((2 * (-bp)) * (a * bp + b * ap)) *
                ((2 * (-bp)) * (a * bp + b * ap)) :=
              mul_self_le_mul_self hLinearNonneg hLinear
          _ = (2 * (bp * bp)) * (2 * ((a * bp + b * ap) * (a * bp + b * ap))) := by
              ring
          _ < (ap * ap) * (2 * ((a * bp + b * ap) * (a * bp + b * ap))) := by
              have hBB : 0 < (a * bp + b * ap) * (a * bp + b * ap) :=
                mul_pos hBPos hBPos
              exact mul_lt_mul_of_pos_right (by linarith [hSq]) (by linarith)
      -- 正因子 ap·ap を消去して A·A < 2·(B·B)（正錐の負の第一係数条件）
      have hFinal : (-(a * ap + 2 * (b * bp))) * (-(a * ap + 2 * (b * bp))) <
          2 * ((a * bp + b * ap) * (a * bp + b * ap)) :=
        lt_of_mul_lt_mul_left hSquare (by positivity)
      exact Or.inr (Or.inr ⟨hANeg, hBPos, by nlinarith [hFinal]⟩)
  · -- 本文の第一の場合 2·(b·b) < a·a: まず 0 < A を背理法で示す
    have haPos : 0 < a := by nlinarith
    have hAPos : 0 < a * ap + 2 * (b * bp) := by
      by_contra hNot
      -- A ≤ 0 なので 0 < a·ap ≤ 2·(b·(-bp))
      have hALe : a * ap ≤ 2 * (b * (-bp)) := by
        have := not_lt.mp hNot
        linarith
      have hbPos : 0 < b := by
        rcases eq_or_lt_of_le hb with hb0 | hbPos
        · exfalso
          have hLeZero : a * ap ≤ 0 := by
            have := hALe
            rw [← hb0] at this
            simpa using this
          exact absurd (mul_pos haPos hap0) (not_lt.mpr hLeZero)
        · exact hbPos
      -- 本文の鎖: (a·a)·(ap·ap) = (a·ap)·(a·ap) ≤ (2·(b·(-bp)))·(2·(b·(-bp)))
      --           = (2·(b·b))·(2·(bp·bp)) < (2·(b·b))·(ap·ap)
      have hChain : (a * a) * (ap * ap) < (2 * (b * b)) * (ap * ap) := by
        calc (a * a) * (ap * ap)
            = (a * ap) * (a * ap) := by ring
          _ ≤ (2 * (b * (-bp))) * (2 * (b * (-bp))) :=
              mul_self_le_mul_self (mul_nonneg ha (le_of_lt hap0)) hALe
          _ = (2 * (b * b)) * (2 * (bp * bp)) := by ring
          _ < (2 * (b * b)) * (ap * ap) := by
              have hbb : 0 < 2 * (b * b) := by positivity
              exact mul_lt_mul_of_pos_left (by linarith [hSq]) hbb
      -- 正因子 ap·ap を消去すると第一の場合に反する
      have : a * a < 2 * (b * b) :=
        lt_of_mul_lt_mul_right hChain (by positivity)
      linarith
    by_cases hB : 0 ≤ a * bp + b * ap
    · -- 表示は正錐の非負係数条件を満たす
      exact Or.inl ⟨le_of_lt hAPos, hB,
        fun hPair => (ne_of_gt hAPos) (congrArg Prod.fst hPair)⟩
    · -- B < 0: 本文の V := -B。線形比較 ap·V ≤ (-bp)·A を作る
      have hBNeg : a * bp + b * ap < 0 := lt_of_not_ge hB
      have hLinear : ap * (-(a * bp + b * ap)) ≤
          (-bp) * (a * ap + 2 * (b * bp)) := by
        have hStep : b * (2 * (bp * bp)) ≤ b * (ap * ap) :=
          mul_le_mul_of_nonneg_left (by linarith [hSq]) hb
        nlinarith [hStep]
      have hLinearNonneg : 0 ≤ ap * (-(a * bp + b * ap)) :=
        mul_nonneg (le_of_lt hap0) (by linarith)
      -- 本文の平方の鎖: (bp·bp)·(2·(V·V)) = (2·(bp·bp))·(V·V) < (ap·ap)·(V·V)
      --                = (ap·V)² ≤ ((-bp)·A)² = (bp·bp)·(A·A)
      have hSquare : (bp * bp) *
            (2 * ((-(a * bp + b * ap)) * (-(a * bp + b * ap)))) <
          (bp * bp) * ((a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp))) := by
        calc (bp * bp) * (2 * ((-(a * bp + b * ap)) * (-(a * bp + b * ap))))
            = (2 * (bp * bp)) * ((-(a * bp + b * ap)) * (-(a * bp + b * ap))) := by
              ring
          _ < (ap * ap) * ((-(a * bp + b * ap)) * (-(a * bp + b * ap))) := by
              have hVV : 0 < (-(a * bp + b * ap)) * (-(a * bp + b * ap)) :=
                mul_pos (by linarith) (by linarith)
              exact mul_lt_mul_of_pos_right (by linarith [hSq]) hVV
          _ = (ap * (-(a * bp + b * ap))) * (ap * (-(a * bp + b * ap))) := by
              ring
          _ ≤ ((-bp) * (a * ap + 2 * (b * bp))) *
                ((-bp) * (a * ap + 2 * (b * bp))) :=
              mul_self_le_mul_self hLinearNonneg hLinear
          _ = (bp * bp) * ((a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp))) := by
              ring
      -- 正因子 bp·bp を消去して 2·(B·B) < A·A（正錐の負の第二係数条件）
      have hFinal : 2 * ((-(a * bp + b * ap)) * (-(a * bp + b * ap))) <
          (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) :=
        lt_of_mul_lt_mul_left hSquare (mul_self_nonneg bp)
      exact Or.inr (Or.inl ⟨hAPos, hBNeg, by nlinarith [hFinal]⟩)

end Ising2DLambda.FisherZero
