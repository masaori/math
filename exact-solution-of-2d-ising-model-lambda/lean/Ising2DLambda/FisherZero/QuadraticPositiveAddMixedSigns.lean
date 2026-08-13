/-
「二つの混合符号条件の和」の具体版で使う有理係数の核。
有理数の二つの係数対について、交差積の平方比較と
和の係数の符号による場合分けだけを行う。
-/
import Ising2DLambda.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

set_option maxHeartbeats 1600000 in
theorem quadraticPositive_add_mixedSigns_coefficients
    (a b a' b' : ℚ)
    (ha : 0 < a) (hb : b < 0) (hSq : 2 * b * b < a * a)
    (ha' : a' < 0) (hb' : 0 < b') (hSq' : a' * a' < 2 * b' * b') :
    (0 ≤ a + a' ∧ 0 ≤ b + b' ∧ (a + a', b + b') ≠ (0, 0)) ∨
      (0 < a + a' ∧ b + b' < 0 ∧
        2 * (b + b') * (b + b') < (a + a') * (a + a')) ∨
      (a + a' < 0 ∧ 0 < b + b' ∧
        (a + a') * (a + a') < 2 * (b + b') * (b + b')) := by
  let c := -a'
  let u := -b
  let A := a + a'
  let B := b + b'
  have hc : 0 < c := by simpa [c] using neg_pos.mpr ha'
  have hu : 0 < u := by simpa [u] using neg_pos.mpr hb
  have hSqLeft : 2 * u * u < a * a := by simpa [u] using hSq
  have hSqRight : c * c < 2 * b' * b' := by simpa [c] using hSq'
  have huSq : 0 < u * u := mul_pos hu hu
  have hb'Sq : 0 < b' * b' := mul_pos hb' hb'
  have hCrossSquare :
      (c * u) * (c * u) < (a * b') * (a * b') := by
    calc
      (c * u) * (c * u) = (c * c) * (u * u) := by ring
      _ < (2 * b' * b') * (u * u) :=
        mul_lt_mul_of_pos_right hSqRight huSq
      _ = (2 * u * u) * (b' * b') := by ring
      _ < (a * a) * (b' * b') :=
        mul_lt_mul_of_pos_right hSqLeft hb'Sq
      _ = (a * b') * (a * b') := by ring
  have hcuNonneg : 0 ≤ c * u := le_of_lt (mul_pos hc hu)
  have hab'Nonneg : 0 ≤ a * b' := le_of_lt (mul_pos ha hb')
  have hCross : c * u < a * b' := by
    by_contra hNot
    have hReverse : a * b' ≤ c * u := le_of_not_gt hNot
    have hFirst : (a * b') * (a * b') ≤ (c * u) * (a * b') :=
      mul_le_mul_of_nonneg_right hReverse hab'Nonneg
    have hSecond : (c * u) * (a * b') ≤ (c * u) * (c * u) :=
      mul_le_mul_of_nonneg_left hReverse hcuNonneg
    exact (not_lt_of_ge (le_trans hFirst hSecond)) hCrossSquare
  by_cases hA : 0 ≤ A
  · by_cases hB : 0 ≤ B
    · apply Or.inl
      refine ⟨by simpa [A] using hA, by simpa [B] using hB, ?_⟩
      intro hPair
      have hA0 : A = 0 := by simpa [A] using congrArg Prod.fst hPair
      have hB0 : B = 0 := by simpa [B] using congrArg Prod.snd hPair
      have hca : c = a := by simp [A] at hA0; linarith
      have hub' : u = b' := by simp [B] at hB0; linarith
      exact (ne_of_lt hCross) (by rw [hca, hub'])
    · apply Or.inr
      apply Or.inl
      have hBneg : B < 0 := lt_of_not_ge hB
      have hbpU : b' < u := by simp [B] at hBneg; linarith
      have hApos : 0 < A := by
        rcases hA.eq_or_lt with hA0 | hApos
        · have hca : c = a := by simp [A] at hA0; linarith
          have hOpposite : a * b' < c * u := by
            rw [hca]
            exact mul_lt_mul_of_pos_left hbpU ha
          exact False.elim ((not_lt_of_ge (le_of_lt hCross)) hOpposite)
        · exact hApos
      let U := u - b'
      have hU : 0 < U := by simpa [U] using sub_pos.mpr hbpU
      -- 本文の三段: a·U = a·u − a·b' < a·u − c·u = u·A
      have hRatio : a * U < u * A := by
        calc
          a * U = a * u - a * b' := by dsimp [U]; ring
          _ < a * u - c * u := sub_lt_sub_left hCross (a * u)
          _ = u * A := by dsimp [A, c]; ring
      have haU : 0 < a * U := mul_pos ha hU
      have huA : 0 < u * A := mul_pos hu hApos
      have hRatioSquare :
          (a * U) * (a * U) < (u * A) * (u * A) := by
        calc
          (a * U) * (a * U) < (u * A) * (a * U) :=
            mul_lt_mul_of_pos_right hRatio haU
          _ < (u * A) * (u * A) :=
            mul_lt_mul_of_pos_left hRatio huA
      have hScaledLeft :
          (u * u) * (2 * U * U) < (u * u) * (A * A) := by
        calc
          (u * u) * (2 * U * U) = (2 * u * u) * (U * U) := by ring
          _ < (a * a) * (U * U) :=
            mul_lt_mul_of_pos_right hSqLeft (mul_pos hU hU)
          _ = (a * U) * (a * U) := by ring
          _ < (u * A) * (u * A) := hRatioSquare
          _ = (u * u) * (A * A) := by ring
      have hFinal : 2 * U * U < A * A := by
        by_contra hNot
        have hReverse : A * A ≤ 2 * U * U := le_of_not_gt hNot
        have hScaledReverse : (u * u) * (A * A) ≤ (u * u) * (2 * U * U) :=
          mul_le_mul_of_nonneg_left hReverse (le_of_lt huSq)
        exact (not_lt_of_ge hScaledReverse) hScaledLeft
      refine ⟨by simpa [A] using hApos, by simpa [B] using hBneg, ?_⟩
      calc
        2 * (b + b') * (b + b') = 2 * U * U := by
          dsimp [U, u]
          ring
        _ < A * A := hFinal
        _ = (a + a') * (a + a') := by rfl
  · apply Or.inr
    apply Or.inr
    have hAneg : A < 0 := lt_of_not_ge hA
    have haC : a < c := by simp [A] at hAneg; linarith
    have hBpos : 0 < B := by
      by_contra hNot
      have hBnonpos : B ≤ 0 := le_of_not_gt hNot
      have hb'U : b' ≤ u := by simp [B] at hBnonpos; linarith
      have hOpposite : a * b' < c * u :=
        calc
          a * b' < c * b' := mul_lt_mul_of_pos_right haC hb'
          _ ≤ c * u := mul_le_mul_of_nonneg_left hb'U (le_of_lt hc)
      exact (not_lt_of_ge (le_of_lt hCross)) hOpposite
    let C := c - a
    have hC : 0 < C := by simpa [C] using sub_pos.mpr haC
    have huB : 0 < B := hBpos
    -- 本文の三段: b'·C = c·b' − a·b' < c·b' − c·u = c·B
    have hRatio : b' * C < c * B := by
      calc
        b' * C = c * b' - a * b' := by dsimp [C]; ring
        _ < c * b' - c * u := sub_lt_sub_left hCross (c * b')
        _ = c * B := by dsimp [B, u]; ring
    have hb'C : 0 < b' * C := mul_pos hb' hC
    have hcB : 0 < c * B := mul_pos hc huB
    have hRatioSquare :
        (b' * C) * (b' * C) < (c * B) * (c * B) := by
      calc
        (b' * C) * (b' * C) < (c * B) * (b' * C) :=
          mul_lt_mul_of_pos_right hRatio hb'C
        _ < (c * B) * (c * B) :=
          mul_lt_mul_of_pos_left hRatio hcB
    have hScaledRight :
        (b' * b') * (C * C) < (b' * b') * (2 * B * B) := by
      calc
        (b' * b') * (C * C) = (b' * C) * (b' * C) := by ring
        _ < (c * B) * (c * B) := hRatioSquare
        _ = (c * c) * (B * B) := by ring
        _ < (2 * b' * b') * (B * B) :=
          mul_lt_mul_of_pos_right hSqRight (mul_pos hBpos hBpos)
        _ = (b' * b') * (2 * B * B) := by ring
    have hFinal : C * C < 2 * B * B := by
      by_contra hNot
      have hReverse : 2 * B * B ≤ C * C := le_of_not_gt hNot
      have hScaledReverse : (b' * b') * (2 * B * B) ≤ (b' * b') * (C * C) :=
        mul_le_mul_of_nonneg_left hReverse (le_of_lt hb'Sq)
      exact (not_lt_of_ge hScaledReverse) hScaledRight
    refine ⟨by simpa [A] using hAneg, by simpa [B] using hBpos, ?_⟩
    calc
      (a + a') * (a + a') = C * C := by
        dsimp [C, c]
        ring
      _ < 2 * B * B := hFinal
      _ = 2 * (b + b') * (b + b') := by rfl

theorem quadraticPositive_add_of_mixedSigns
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 < (quadraticRepresentation s xi).1 ∧
      (quadraticRepresentation s xi).2 < 0 ∧
      2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1)
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  exact quadraticPositive_add_mixedSigns_coefficients
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 hxi.2.2 heta.1 heta.2.1 heta.2.2

end Ising2DLambda.FisherZero
