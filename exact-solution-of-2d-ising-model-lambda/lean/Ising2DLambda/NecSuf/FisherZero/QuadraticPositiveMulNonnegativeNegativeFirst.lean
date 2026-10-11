/-
「非負係数条件と負の第一係数条件の積」の必要十分版。
二次体を外し、同じ平方比較に使う順序付き可換環の演算と、非零時の平方の不一致を残す。
c の正値は本文では入力から従うが、以下の論法は c の平方比較だけを使う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_negativeFirst_necSuf
    {α : Type} [CommRing α] [LinearOrder α] [IsStrictOrderedRing α]
    (a b c bp : α) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hbp : 0 < bp) (hSq : c * c < 2 * (bp * bp))
    (hNe : (a, b) ≠ (0, 0))
    (hNoSquare : b ≠ 0 → a * a ≠ 2 * (b * b)) :
    (0 ≤ 2 * (b * bp) - a * c ∧ 0 ≤ a * bp - b * c ∧
      (2 * (b * bp) - a * c, a * bp - b * c) ≠ (0, 0)) ∨
    (0 < 2 * (b * bp) - a * c ∧ a * bp - b * c < 0 ∧
      2 * ((a * bp - b * c) * (a * bp - b * c)) <
        (2 * (b * bp) - a * c) * (2 * (b * bp) - a * c)) ∨
    (2 * (b * bp) - a * c < 0 ∧ 0 < a * bp - b * c ∧
      (2 * (b * bp) - a * c) * (2 * (b * bp) - a * c) <
        2 * ((a * bp - b * c) * (a * bp - b * c))) := by
  have hUnequal : a * a ≠ 2 * (b * b) := by
    intro hEq
    by_cases hb0 : b = 0
    · have haa : a * a = 0 := by
        calc
          a * a = 2 * (b * b) := hEq
          _ = 2 * (0 * 0) := by rw [hb0]
          _ = 2 * 0 := by rw [zero_mul]
          _ = 0 := mul_zero _
      have ha0 : a = 0 := mul_self_eq_zero.mp haa
      exact hNe (Prod.ext ha0 hb0)
    · exact hNoSquare hb0 hEq
  let A := 2 * (b * bp) - a * c
  let B := a * bp - b * c
  have hTwo : (0 : α) < 2 := by norm_num
  rcases lt_or_gt_of_ne hUnequal.symm with hFirst | hSecond
  · have haNe : a ≠ 0 := by
      intro ha0
      have hZero : a * a = 0 := by
        calc
          a * a = 0 * 0 := by rw [ha0]
          _ = 0 := zero_mul _
      have hBad : 2 * (b * b) < 0 := hZero ▸ hFirst
      exact (not_lt_of_ge (mul_nonneg hTwo.le (mul_self_nonneg b))) hBad
    have haPos : 0 < a := lt_of_le_of_ne ha haNe.symm
    have hBPos : 0 < B := by
      by_contra hNot
      have hBLe : a * bp ≤ b * c := sub_nonpos.mp (le_of_not_gt hNot)
      have hbNe : b ≠ 0 := by
        intro hb0
        have hZero : b * c = 0 := by
          calc
            b * c = 0 * c := by rw [hb0]
            _ = 0 := zero_mul _
        have hBad : a * bp ≤ 0 := hZero ▸ hBLe
        exact (not_lt_of_ge hBad) (mul_pos haPos hbp)
      have hbPos : 0 < b := lt_of_le_of_ne hb hbNe.symm
      have hChain : (a * a) * (bp * bp) < (2 * (b * b)) * (bp * bp) := by
        calc
          (a * a) * (bp * bp) = a * (a * (bp * bp)) := by simp only [mul_assoc]
          _ = a * ((a * bp) * bp) := by simp only [mul_assoc]
          _ = a * ((bp * a) * bp) := by simp only [mul_comm a bp]
          _ = a * (bp * (a * bp)) := by simp only [mul_assoc]
          _ = (a * bp) * (a * bp) := by simp only [mul_assoc]
          _ ≤ (b * c) * (b * c) := mul_self_le_mul_self (mul_nonneg ha hbp.le) hBLe
          _ = b * (c * (b * c)) := by simp only [mul_assoc]
          _ = b * ((c * b) * c) := by simp only [mul_assoc]
          _ = b * ((b * c) * c) := by simp only [mul_comm b c]
          _ = b * (b * (c * c)) := by simp only [mul_assoc]
          _ = (b * b) * (c * c) := by simp only [mul_assoc]
          _ < (b * b) * (2 * (bp * bp)) := mul_lt_mul_of_pos_left hSq (mul_pos hbPos hbPos)
          _ = ((b * b) * 2) * (bp * bp) := by simp only [mul_assoc]
          _ = (2 * (b * b)) * (bp * bp) := by simp only [mul_comm (b * b) 2]
      have hOpposite : a * a < 2 * (b * b) := by
        exact lt_of_mul_lt_mul_right hChain (mul_self_nonneg bp)
      exact (not_lt_of_gt hFirst) hOpposite
    by_cases hA : 0 ≤ A
    · exact Or.inl ⟨hA, hBPos.le,
        fun hPair => (ne_of_gt hBPos) (congrArg Prod.snd hPair)⟩
    · have hANeg : A < 0 := lt_of_not_ge hA
      let C := -A
      have hCPos : 0 < C := neg_pos.mpr hANeg
      have hC : C = a * c - 2 * (b * bp) := by
        calc
          C = -A := rfl
          _ = -(2 * (b * bp) - a * c) := rfl
          _ = a * c - 2 * (b * bp) := neg_sub _ _
      have hStep : b * (c * c) ≤ b * (2 * (bp * bp)) := by
        exact mul_le_mul_of_nonneg_left hSq.le hb
      have hLinear : bp * C ≤ c * B := by
        calc
          bp * C = bp * (a * c - 2 * (b * bp)) := by rw [hC]
          _ = bp * (a * c) - bp * (2 * (b * bp)) := mul_sub _ _ _
          _ = (bp * a) * c - (bp * 2) * (b * bp) := by simp only [mul_assoc]
          _ = (a * bp) * c - (2 * bp) * (b * bp) := by rw [mul_comm bp a, mul_comm bp 2]
          _ = a * (bp * c) - 2 * (bp * (b * bp)) := by simp only [mul_assoc]
          _ = a * (bp * c) - 2 * ((bp * b) * bp) := by simp only [mul_assoc]
          _ = a * (c * bp) - 2 * ((b * bp) * bp) := by rw [mul_comm bp c, mul_comm bp b]
          _ = a * (c * bp) - 2 * (b * (bp * bp)) := by simp only [mul_assoc]
          _ = a * (c * bp) - (2 * b) * (bp * bp) := by simp only [mul_assoc]
          _ = a * (c * bp) - (b * 2) * (bp * bp) := by rw [mul_comm 2 b]
          _ = a * (c * bp) - b * (2 * (bp * bp)) := by simp only [mul_assoc]
          _ ≤ a * (c * bp) - b * (c * c) := sub_le_sub_left hStep _
          _ = (a * c) * bp - (b * c) * c := by simp only [mul_assoc]
          _ = (c * a) * bp - (c * b) * c := by rw [mul_comm a c, mul_comm b c]
          _ = c * (a * bp) - c * (b * c) := by simp only [mul_assoc]
          _ = c * (a * bp - b * c) := (mul_sub _ _ _).symm
          _ = c * B := rfl
      have hLinearNonneg : 0 ≤ bp * C := (mul_pos hbp hCPos).le
      have hSquare : (bp * bp) * (C * C) < (bp * bp) * (2 * (B * B)) := by
        calc
          (bp * bp) * (C * C) = bp * (bp * (C * C)) := by simp only [mul_assoc]
          _ = bp * ((bp * C) * C) := by simp only [mul_assoc]
          _ = bp * ((C * bp) * C) := by simp only [mul_comm bp C]
          _ = bp * (C * (bp * C)) := by simp only [mul_assoc]
          _ = (bp * C) * (bp * C) := by simp only [mul_assoc]
          _ ≤ (c * B) * (c * B) := mul_self_le_mul_self hLinearNonneg hLinear
          _ = c * (B * (c * B)) := by simp only [mul_assoc]
          _ = c * ((B * c) * B) := by simp only [mul_assoc]
          _ = c * ((c * B) * B) := by simp only [mul_comm c B]
          _ = c * (c * (B * B)) := by simp only [mul_assoc]
          _ = (c * c) * (B * B) := by simp only [mul_assoc]
          _ < (2 * (bp * bp)) * (B * B) := mul_lt_mul_of_pos_right hSq (mul_pos hBPos hBPos)
          _ = ((bp * bp) * 2) * (B * B) := by rw [mul_comm 2 (bp * bp)]
          _ = (bp * bp) * (2 * (B * B)) := by simp only [mul_assoc]
      have hFinal : A * A < 2 * (B * B) := by
        calc
          A * A = (-A) * (-A) := (neg_mul_neg _ _).symm
          _ = C * C := rfl
          _ < 2 * (B * B) := lt_of_mul_lt_mul_left hSquare (mul_self_nonneg bp)
      exact Or.inr (Or.inr ⟨hANeg, hBPos, hFinal⟩)
  · have hbNe : b ≠ 0 := by
      intro hb0
      have hZero : 2 * (b * b) = 0 := by
        calc
          2 * (b * b) = 2 * (0 * 0) := by rw [hb0]
          _ = 2 * 0 := by rw [zero_mul]
          _ = 0 := mul_zero _
      have hBad : a * a < 0 := hZero ▸ hSecond
      exact (not_lt_of_ge (mul_self_nonneg a)) hBad
    have hbPos : 0 < b := lt_of_le_of_ne hb hbNe.symm
    have hAPos : 0 < A := by
      by_contra hNot
      have hALe : 2 * (b * bp) ≤ a * c := sub_nonpos.mp (le_of_not_gt hNot)
      have haNe : a ≠ 0 := by
        intro ha0
        have hZero : a * c = 0 := by
          calc
            a * c = 0 * c := by rw [ha0]
            _ = 0 := zero_mul _
        have hBad : 2 * (b * bp) ≤ 0 := hZero ▸ hALe
        exact (not_lt_of_ge hBad) (mul_pos hTwo (mul_pos hbPos hbp))
      have haPos : 0 < a := lt_of_le_of_ne ha haNe.symm
      have hChain : (2 * (b * b)) * (2 * (bp * bp)) <
          (a * a) * (2 * (bp * bp)) := by
        calc
          (2 * (b * b)) * (2 * (bp * bp)) = 2 * ((b * b) * (2 * (bp * bp))) := by simp only [mul_assoc]
          _ = 2 * (((b * b) * 2) * (bp * bp)) := by simp only [mul_assoc]
          _ = 2 * ((2 * (b * b)) * (bp * bp)) := by simp only [mul_comm (b * b) 2]
          _ = 2 * (2 * ((b * b) * (bp * bp))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * (b * (bp * bp)))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * ((b * bp) * bp))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * ((bp * b) * bp))) := by simp only [mul_comm b bp]
          _ = 2 * (2 * (b * (bp * (b * bp)))) := by simp only [mul_assoc]
          _ = 2 * (2 * ((b * bp) * (b * bp))) := by simp only [mul_assoc]
          _ = 2 * ((2 * (b * bp)) * (b * bp)) := by simp only [mul_assoc]
          _ = 2 * (((b * bp) * 2) * (b * bp)) := by simp only [mul_comm 2 (b * bp)]
          _ = 2 * ((b * bp) * (2 * (b * bp))) := by simp only [mul_assoc]
          _ = (2 * (b * bp)) * (2 * (b * bp)) := by simp only [mul_assoc]
          _ ≤ (a * c) * (a * c) := mul_self_le_mul_self (mul_nonneg hTwo.le (mul_nonneg hb hbp.le)) hALe
          _ = a * (c * (a * c)) := by simp only [mul_assoc]
          _ = a * ((c * a) * c) := by simp only [mul_assoc]
          _ = a * ((a * c) * c) := by simp only [mul_comm a c]
          _ = a * (a * (c * c)) := by simp only [mul_assoc]
          _ = (a * a) * (c * c) := by simp only [mul_assoc]
          _ < (a * a) * (2 * (bp * bp)) := mul_lt_mul_of_pos_left hSq (mul_pos haPos haPos)
      have hOpposite : 2 * (b * b) < a * a := by
        exact lt_of_mul_lt_mul_right hChain (mul_nonneg hTwo.le (mul_self_nonneg bp))
      exact (not_lt_of_gt hSecond) hOpposite
    by_cases hB : 0 ≤ B
    · exact Or.inl ⟨hAPos.le, hB,
        fun hPair => (ne_of_gt hAPos) (congrArg Prod.fst hPair)⟩
    · have hBNeg : B < 0 := lt_of_not_ge hB
      let V := -B
      have hVPos : 0 < V := neg_pos.mpr hBNeg
      have hV : V = b * c - a * bp := by
        calc
          V = -B := rfl
          _ = -(a * bp - b * c) := rfl
          _ = b * c - a * bp := neg_sub _ _
      have hStep : a * (c * c) ≤ a * (2 * (bp * bp)) := by
        exact mul_le_mul_of_nonneg_left hSq.le ha
      have hLinear : (2 * bp) * V ≤ c * A := by
        calc
          (2 * bp) * V = (2 * bp) * (b * c - a * bp) := by rw [hV]
          _ = (2 * bp) * (b * c) - (2 * bp) * (a * bp) := mul_sub _ _ _
          _ = 2 * (bp * (b * c)) - 2 * (bp * (a * bp)) := by simp only [mul_assoc]
          _ = 2 * ((bp * b) * c) - 2 * ((bp * a) * bp) := by simp only [mul_assoc]
          _ = 2 * ((b * bp) * c) - 2 * ((a * bp) * bp) := by rw [mul_comm bp b, mul_comm bp a]
          _ = 2 * (b * (bp * c)) - 2 * (a * (bp * bp)) := by simp only [mul_assoc]
          _ = 2 * (b * (c * bp)) - 2 * (a * (bp * bp)) := by rw [mul_comm bp c]
          _ = 2 * (b * (c * bp)) - (2 * a) * (bp * bp) := by simp only [mul_assoc]
          _ = 2 * (b * (c * bp)) - (a * 2) * (bp * bp) := by rw [mul_comm 2 a]
          _ = 2 * (b * (c * bp)) - a * (2 * (bp * bp)) := by simp only [mul_assoc]
          _ ≤ 2 * (b * (c * bp)) - a * (c * c) := sub_le_sub_left hStep _
          _ = 2 * ((b * c) * bp) - (a * c) * c := by simp only [mul_assoc]
          _ = 2 * ((c * b) * bp) - (c * a) * c := by rw [mul_comm b c, mul_comm a c]
          _ = 2 * (c * (b * bp)) - c * (a * c) := by simp only [mul_assoc]
          _ = (2 * c) * (b * bp) - c * (a * c) := by simp only [mul_assoc]
          _ = (c * 2) * (b * bp) - c * (a * c) := by rw [mul_comm 2 c]
          _ = c * (2 * (b * bp)) - c * (a * c) := by simp only [mul_assoc]
          _ = c * (2 * (b * bp) - a * c) := (mul_sub _ _ _).symm
          _ = c * A := rfl
      have hLinearNonneg : 0 ≤ (2 * bp) * V := (mul_pos (mul_pos hTwo hbp) hVPos).le
      have hSquare : (2 * (bp * bp)) * (2 * (V * V)) <
          (2 * (bp * bp)) * (A * A) := by
        calc
          (2 * (bp * bp)) * (2 * (V * V)) = 2 * ((bp * bp) * (2 * (V * V))) := by simp only [mul_assoc]
          _ = 2 * (((bp * bp) * 2) * (V * V)) := by simp only [mul_assoc]
          _ = 2 * ((2 * (bp * bp)) * (V * V)) := by simp only [mul_comm (bp * bp) 2]
          _ = 2 * (2 * ((bp * bp) * (V * V))) := by simp only [mul_assoc]
          _ = 2 * (2 * (bp * (bp * (V * V)))) := by simp only [mul_assoc]
          _ = 2 * (2 * (bp * ((bp * V) * V))) := by simp only [mul_assoc]
          _ = 2 * (2 * (bp * ((V * bp) * V))) := by simp only [mul_comm bp V]
          _ = 2 * (2 * (bp * (V * (bp * V)))) := by simp only [mul_assoc]
          _ = 2 * (2 * ((bp * V) * (bp * V))) := by simp only [mul_assoc]
          _ = 2 * ((2 * (bp * V)) * (bp * V)) := by simp only [mul_assoc]
          _ = 2 * (((bp * V) * 2) * (bp * V)) := by simp only [mul_comm 2 (bp * V)]
          _ = 2 * ((bp * V) * (2 * (bp * V))) := by simp only [mul_assoc]
          _ = (2 * (bp * V)) * (2 * (bp * V)) := by simp only [mul_assoc]
          _ = ((2 * bp) * V) * ((2 * bp) * V) := by simp only [mul_assoc]
          _ ≤ (c * A) * (c * A) := mul_self_le_mul_self hLinearNonneg hLinear
          _ = c * (A * (c * A)) := by simp only [mul_assoc]
          _ = c * ((A * c) * A) := by simp only [mul_assoc]
          _ = c * ((c * A) * A) := by simp only [mul_comm c A]
          _ = c * (c * (A * A)) := by simp only [mul_assoc]
          _ = (c * c) * (A * A) := by simp only [mul_assoc]
          _ < (2 * (bp * bp)) * (A * A) := mul_lt_mul_of_pos_right hSq (mul_pos hAPos hAPos)
      have hFinal : 2 * (B * B) < A * A := by
        calc
          2 * (B * B) = 2 * ((-B) * (-B)) := by rw [neg_mul_neg]
          _ = 2 * (V * V) := rfl
          _ < A * A := lt_of_mul_lt_mul_left hSquare (mul_nonneg hTwo.le (mul_self_nonneg bp))
      exact Or.inr (Or.inl ⟨hAPos, hBNeg, hFinal⟩)

end Ising2DLambda.NecSuf.FisherZero
