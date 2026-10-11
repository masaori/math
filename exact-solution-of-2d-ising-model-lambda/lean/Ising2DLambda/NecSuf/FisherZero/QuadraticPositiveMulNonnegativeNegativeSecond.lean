/-
「非負係数条件と負の第二係数条件の積」の必要十分版。
二次体を外し、本文の二つの平方比較と四つの符号場合だけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_negativeSecond_necSuf
    {α : Type} [CommRing α] [LinearOrder α] [IsStrictOrderedRing α]
    (a b ap u : α)
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hap : 0 < ap) (hSq : 2 * (u * u) < ap * ap)
    (hNe : (a, b) ≠ (0, 0))
    (hNoSquare : b ≠ 0 → a * a ≠ 2 * (b * b)) :
    (0 ≤ a * ap - 2 * (b * u) ∧ 0 ≤ b * ap - a * u ∧
      (a * ap - 2 * (b * u), b * ap - a * u) ≠ (0, 0)) ∨
    (0 < a * ap - 2 * (b * u) ∧ b * ap - a * u < 0 ∧
      2 * ((b * ap - a * u) * (b * ap - a * u)) <
        (a * ap - 2 * (b * u)) * (a * ap - 2 * (b * u))) ∨
    (a * ap - 2 * (b * u) < 0 ∧ 0 < b * ap - a * u ∧
      (a * ap - 2 * (b * u)) * (a * ap - 2 * (b * u)) <
        2 * ((b * ap - a * u) * (b * ap - a * u))) := by
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
  let A := a * ap - 2 * (b * u)
  let B := b * ap - a * u
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
    have hAPos : 0 < A := by
      by_contra hNot
      have hALe : a * ap ≤ 2 * (b * u) := sub_nonpos.mp (le_of_not_gt hNot)
      have hbNe : b ≠ 0 := by
        intro hb0
        have hZero : 2 * (b * u) = 0 := by
          calc
            2 * (b * u) = 2 * (0 * u) := by rw [hb0]
            _ = 2 * 0 := by rw [zero_mul]
            _ = 0 := mul_zero _
        have hBad : a * ap ≤ 0 := hZero ▸ hALe
        exact (not_lt_of_ge hBad) (mul_pos haPos hap)
      have hbPos : 0 < b := lt_of_le_of_ne hb hbNe.symm
      have hChain : (a * a) * (ap * ap) < (2 * (b * b)) * (ap * ap) := by
        calc
          (a * a) * (ap * ap) = a * (a * (ap * ap)) := by simp only [mul_assoc]
          _ = a * ((a * ap) * ap) := by simp only [mul_assoc]
          _ = a * ((ap * a) * ap) := by simp only [mul_comm a ap]
          _ = a * (ap * (a * ap)) := by simp only [mul_assoc]
          _ = (a * ap) * (a * ap) := by simp only [mul_assoc]
          _ ≤ (2 * (b * u)) * (2 * (b * u)) := mul_self_le_mul_self (mul_nonneg ha hap.le) hALe
          _ = 2 * ((b * u) * (2 * (b * u))) := by simp only [mul_assoc]
          _ = 2 * (((b * u) * 2) * (b * u)) := by simp only [mul_assoc]
          _ = 2 * ((2 * (b * u)) * (b * u)) := by simp only [mul_comm (b * u) 2]
          _ = 2 * (2 * ((b * u) * (b * u))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * (u * (b * u)))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * ((u * b) * u))) := by simp only [mul_assoc]
          _ = 2 * (2 * (b * ((b * u) * u))) := by simp only [mul_comm u b]
          _ = 2 * (2 * (b * (b * (u * u)))) := by simp only [mul_assoc]
          _ = 2 * (2 * ((b * b) * (u * u))) := by simp only [mul_assoc]
          _ = 2 * ((2 * (b * b)) * (u * u)) := by simp only [mul_assoc]
          _ = 2 * (((b * b) * 2) * (u * u)) := by simp only [mul_comm 2 (b * b)]
          _ = 2 * ((b * b) * (2 * (u * u))) := by simp only [mul_assoc]
          _ = (2 * (b * b)) * (2 * (u * u)) := by simp only [mul_assoc]
          _ < (2 * (b * b)) * (ap * ap) := mul_lt_mul_of_pos_left hSq (mul_pos hTwo (mul_pos hbPos hbPos))
      have hOpposite : a * a < 2 * (b * b) :=
        lt_of_mul_lt_mul_right hChain (mul_self_nonneg ap)
      exact (not_lt_of_gt hFirst) hOpposite
    by_cases hBNonneg : 0 ≤ B
    · exact Or.inl ⟨hAPos.le, hBNonneg,
        fun hPair => (ne_of_gt hAPos) (congrArg Prod.fst hPair)⟩
    · have hBNeg : B < 0 := lt_of_not_ge hBNonneg
      let V := -B
      have hVPos : 0 < V := neg_pos.mpr hBNeg
      have hV : V = a * u - b * ap := by
        calc
          V = -B := rfl
          _ = -(b * ap - a * u) := rfl
          _ = a * u - b * ap := neg_sub _ _
      have hStep : b * (2 * (u * u)) ≤ b * (ap * ap) :=
        mul_le_mul_of_nonneg_left hSq.le hb
      have hLinear : ap * V ≤ u * A := by
        calc
          ap * V = ap * (a * u - b * ap) := by rw [hV]
          _ = ap * (a * u) - ap * (b * ap) := mul_sub _ _ _
          _ = (ap * a) * u - (ap * b) * ap := by simp only [mul_assoc]
          _ = (a * ap) * u - (b * ap) * ap := by simp only [mul_comm ap a, mul_comm ap b]
          _ = a * (ap * u) - b * (ap * ap) := by simp only [mul_assoc]
          _ = a * (u * ap) - b * (ap * ap) := by simp only [mul_comm ap u]
          _ ≤ a * (u * ap) - b * (2 * (u * u)) := sub_le_sub_left hStep _
          _ = (a * u) * ap - (b * 2) * (u * u) := by simp only [mul_assoc]
          _ = (u * a) * ap - (2 * b) * (u * u) := by simp only [mul_comm a u, mul_comm b 2]
          _ = u * (a * ap) - 2 * (b * (u * u)) := by simp only [mul_assoc]
          _ = u * (a * ap) - 2 * ((b * u) * u) := by simp only [mul_assoc]
          _ = u * (a * ap) - 2 * (u * (b * u)) := by simp only [mul_comm (b * u) u]
          _ = u * (a * ap) - (2 * u) * (b * u) := by simp only [mul_assoc]
          _ = u * (a * ap) - (u * 2) * (b * u) := by simp only [mul_comm 2 u]
          _ = u * (a * ap) - u * (2 * (b * u)) := by simp only [mul_assoc]
          _ = u * (a * ap - 2 * (b * u)) := (mul_sub _ _ _).symm
          _ = u * A := rfl
      have hSquare : (u * u) * (2 * (V * V)) < (u * u) * (A * A) := by
        calc
          (u * u) * (2 * (V * V)) = ((u * u) * 2) * (V * V) := by simp only [mul_assoc]
          _ = (2 * (u * u)) * (V * V) := by simp only [mul_comm (u * u) 2]
          _ < (ap * ap) * (V * V) := mul_lt_mul_of_pos_right hSq (mul_pos hVPos hVPos)
          _ = ap * (ap * (V * V)) := by simp only [mul_assoc]
          _ = ap * ((ap * V) * V) := by simp only [mul_assoc]
          _ = ap * ((V * ap) * V) := by simp only [mul_comm ap V]
          _ = ap * (V * (ap * V)) := by simp only [mul_assoc]
          _ = (ap * V) * (ap * V) := by simp only [mul_assoc]
          _ ≤ (u * A) * (u * A) := mul_self_le_mul_self (mul_nonneg hap.le hVPos.le) hLinear
          _ = u * (A * (u * A)) := by simp only [mul_assoc]
          _ = u * ((A * u) * A) := by simp only [mul_assoc]
          _ = u * ((u * A) * A) := by simp only [mul_comm A u]
          _ = u * (u * (A * A)) := by simp only [mul_assoc]
          _ = (u * u) * (A * A) := by simp only [mul_assoc]
      have hFinal : 2 * (V * V) < A * A :=
        lt_of_mul_lt_mul_left hSquare (mul_self_nonneg u)
      have hResult : 2 * (B * B) < A * A := by
        calc
          2 * (B * B) = 2 * ((-B) * (-B)) := by rw [neg_mul_neg]
          _ = 2 * (V * V) := rfl
          _ < A * A := hFinal
      exact Or.inr (Or.inl ⟨hAPos, hBNeg, hResult⟩)
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
    have hBPos : 0 < B := by
      by_contra hNot
      have hBLe : b * ap ≤ a * u := sub_nonpos.mp (le_of_not_gt hNot)
      have haNe : a ≠ 0 := by
        intro ha0
        have hZero : a * u = 0 := by
          calc
            a * u = 0 * u := by rw [ha0]
            _ = 0 := zero_mul _
        have hBad : b * ap ≤ 0 := hZero ▸ hBLe
        exact (not_lt_of_ge hBad) (mul_pos hbPos hap)
      have haPos : 0 < a := lt_of_le_of_ne ha haNe.symm
      have hSquareLe : (b * ap) * (b * ap) ≤ (a * u) * (a * u) :=
        mul_self_le_mul_self (mul_nonneg hb hap.le) hBLe
      have hChain : (2 * (b * b)) * (ap * ap) < (a * a) * (ap * ap) := by
        calc
          (2 * (b * b)) * (ap * ap) = 2 * ((b * b) * (ap * ap)) := by simp only [mul_assoc]
          _ = 2 * (b * (b * (ap * ap))) := by simp only [mul_assoc]
          _ = 2 * (b * ((b * ap) * ap)) := by simp only [mul_assoc]
          _ = 2 * (b * ((ap * b) * ap)) := by simp only [mul_comm b ap]
          _ = 2 * (b * (ap * (b * ap))) := by simp only [mul_assoc]
          _ = 2 * ((b * ap) * (b * ap)) := by simp only [mul_assoc]
          _ ≤ 2 * ((a * u) * (a * u)) := mul_le_mul_of_nonneg_left hSquareLe hTwo.le
          _ = 2 * (a * (u * (a * u))) := by simp only [mul_assoc]
          _ = 2 * (a * ((u * a) * u)) := by simp only [mul_assoc]
          _ = 2 * (a * ((a * u) * u)) := by simp only [mul_comm u a]
          _ = 2 * (a * (a * (u * u))) := by simp only [mul_assoc]
          _ = 2 * ((a * a) * (u * u)) := by simp only [mul_assoc]
          _ = (2 * (a * a)) * (u * u) := by simp only [mul_assoc]
          _ = ((a * a) * 2) * (u * u) := by simp only [mul_comm 2 (a * a)]
          _ = (a * a) * (2 * (u * u)) := by simp only [mul_assoc]
          _ < (a * a) * (ap * ap) := mul_lt_mul_of_pos_left hSq (mul_pos haPos haPos)
      have hOpposite : 2 * (b * b) < a * a :=
        lt_of_mul_lt_mul_right hChain (mul_self_nonneg ap)
      exact (not_lt_of_gt hSecond) hOpposite
    by_cases hANonneg : 0 ≤ A
    · exact Or.inl ⟨hANonneg, hBPos.le,
        fun hPair => (ne_of_gt hBPos) (congrArg Prod.snd hPair)⟩
    · have hANeg : A < 0 := lt_of_not_ge hANonneg
      let C := -A
      have hCPos : 0 < C := neg_pos.mpr hANeg
      have hC : C = 2 * (b * u) - a * ap := by
        calc
          C = -A := rfl
          _ = -(a * ap - 2 * (b * u)) := rfl
          _ = 2 * (b * u) - a * ap := neg_sub _ _
      have hStep : a * (2 * (u * u)) ≤ a * (ap * ap) :=
        mul_le_mul_of_nonneg_left hSq.le ha
      have hLinear : ap * C ≤ (2 * u) * B := by
        calc
          ap * C = ap * (2 * (b * u) - a * ap) := by rw [hC]
          _ = ap * (2 * (b * u)) - ap * (a * ap) := mul_sub _ _ _
          _ = (ap * 2) * (b * u) - (ap * a) * ap := by simp only [mul_assoc]
          _ = (2 * ap) * (b * u) - (a * ap) * ap := by simp only [mul_comm ap 2, mul_comm ap a]
          _ = 2 * (ap * (b * u)) - a * (ap * ap) := by simp only [mul_assoc]
          _ = 2 * ((ap * b) * u) - a * (ap * ap) := by simp only [mul_assoc]
          _ = 2 * ((b * ap) * u) - a * (ap * ap) := by simp only [mul_comm ap b]
          _ = 2 * (b * (ap * u)) - a * (ap * ap) := by simp only [mul_assoc]
          _ = 2 * (b * (u * ap)) - a * (ap * ap) := by simp only [mul_comm ap u]
          _ ≤ 2 * (b * (u * ap)) - a * (2 * (u * u)) := sub_le_sub_left hStep _
          _ = 2 * ((b * u) * ap) - (a * 2) * (u * u) := by simp only [mul_assoc]
          _ = 2 * ((u * b) * ap) - (2 * a) * (u * u) := by simp only [mul_comm b u, mul_comm a 2]
          _ = (2 * (u * b)) * ap - 2 * (a * (u * u)) := by simp only [mul_assoc]
          _ = ((2 * u) * b) * ap - 2 * ((a * u) * u) := by simp only [mul_assoc]
          _ = (2 * u) * (b * ap) - 2 * ((a * u) * u) := by simp only [mul_assoc]
          _ = (2 * u) * (b * ap) - 2 * (u * (a * u)) := by simp only [mul_comm (a * u) u]
          _ = (2 * u) * (b * ap) - (2 * u) * (a * u) := by simp only [mul_assoc]
          _ = (2 * u) * (b * ap - a * u) := (mul_sub _ _ _).symm
          _ = (2 * u) * B := rfl
      have hSquare : (ap * ap) * (C * C) < (ap * ap) * (2 * (B * B)) := by
        calc
          (ap * ap) * (C * C) = ap * (ap * (C * C)) := by simp only [mul_assoc]
          _ = ap * ((ap * C) * C) := by simp only [mul_assoc]
          _ = ap * ((C * ap) * C) := by simp only [mul_comm ap C]
          _ = ap * (C * (ap * C)) := by simp only [mul_assoc]
          _ = (ap * C) * (ap * C) := by simp only [mul_assoc]
          _ ≤ ((2 * u) * B) * ((2 * u) * B) := mul_self_le_mul_self (mul_nonneg hap.le hCPos.le) hLinear
          _ = (2 * (u * B)) * (2 * (u * B)) := by simp only [mul_assoc]
          _ = 2 * ((u * B) * (2 * (u * B))) := by simp only [mul_assoc]
          _ = 2 * (((u * B) * 2) * (u * B)) := by simp only [mul_assoc]
          _ = 2 * ((2 * (u * B)) * (u * B)) := by simp only [mul_comm (u * B) 2]
          _ = 2 * (2 * ((u * B) * (u * B))) := by simp only [mul_assoc]
          _ = 2 * (2 * (u * (B * (u * B)))) := by simp only [mul_assoc]
          _ = 2 * (2 * (u * ((B * u) * B))) := by simp only [mul_assoc]
          _ = 2 * (2 * (u * ((u * B) * B))) := by simp only [mul_comm B u]
          _ = 2 * (2 * (u * (u * (B * B)))) := by simp only [mul_assoc]
          _ = 2 * (2 * ((u * u) * (B * B))) := by simp only [mul_assoc]
          _ = 2 * ((2 * (u * u)) * (B * B)) := by simp only [mul_assoc]
          _ = 2 * (((u * u) * 2) * (B * B)) := by simp only [mul_comm 2 (u * u)]
          _ = 2 * ((u * u) * (2 * (B * B))) := by simp only [mul_assoc]
          _ = (2 * (u * u)) * (2 * (B * B)) := by simp only [mul_assoc]
          _ < (ap * ap) * (2 * (B * B)) := mul_lt_mul_of_pos_right hSq (mul_pos hTwo (mul_pos hBPos hBPos))
      have hFinal : C * C < 2 * (B * B) :=
        lt_of_mul_lt_mul_left hSquare (mul_self_nonneg ap)
      have hResult : A * A < 2 * (B * B) := by
        calc
          A * A = (-A) * (-A) := (neg_mul_neg _ _).symm
          _ = C * C := rfl
          _ < 2 * (B * B) := hFinal
      exact Or.inr (Or.inr ⟨hANeg, hBPos, hResult⟩)

end Ising2DLambda.NecSuf.FisherZero
