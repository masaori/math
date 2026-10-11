/-
「二つの混合符号条件の積」の必要十分版。
二次体・除法・順序の全比較を外す。可換環での分配と並べ替え、
半順序での正数の積・和、正因子を掛ける厳密比較と移項だけを使う。
平方差の正値と中間の平方比較は、元の六条件から本文と同じ順に導く。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_mixedSigns_necSuf
    {α : Type*} [CommRing α] [PartialOrder α] [IsStrictOrderedRing α]
    (a u cp bp : α)
    (ha : 0 < a) (hu : 0 < u) (hSq : 2 * (u * u) < a * a)
    (hcp : 0 < cp) (hbp : 0 < bp) (hSqp : cp * cp < 2 * (bp * bp)) :
    -(a * cp + 2 * (u * bp)) < 0 ∧
      0 < a * bp + u * cp ∧
      (-(a * cp + 2 * (u * bp))) * (-(a * cp + 2 * (u * bp))) <
        2 * ((a * bp + u * cp) * (a * bp + u * cp)) := by
  let b := -u
  let ap := -cp
  have hbEq : b = -u := rfl
  have hapEq : ap = -cp := rfl
  let A := a * ap + 2 * (b * bp)
  let B := a * bp + b * ap
  let C := a * cp + 2 * (u * bp)
  let D := a * a - 2 * (u * u)
  -- 本文の四因子の並べ替えを、結合則と可換則へ分ける。
  have hRegroup (p q r t : α) : (p * q) * (r * t) = (p * r) * (q * t) := by
    calc
      (p * q) * (r * t) = p * (q * (r * t)) := by simp only [mul_assoc]
      _ = p * ((q * r) * t) := by simp only [mul_assoc]
      _ = p * ((r * q) * t) := by rw [mul_comm q r]
      _ = p * (r * (q * t)) := by simp only [mul_assoc]
      _ = (p * r) * (q * t) := by simp only [mul_assoc]
  have hA : A = -C := by
    calc
      A = a * ap + 2 * (b * bp) := rfl
      _ = a * (-cp) + 2 * ((-u) * bp) := by rw [hbEq, hapEq]
      _ = -(a * cp) + 2 * ((-u) * bp) := by rw [mul_neg]
      _ = -(a * cp) + 2 * (-(u * bp)) := by rw [neg_mul]
      _ = -(a * cp) + -(2 * (u * bp)) := by rw [mul_neg 2 (u * bp)]
      _ = -(a * cp + 2 * (u * bp)) := by rw [neg_add]
      _ = -C := rfl
  have hB : B = a * bp + u * cp := by
    calc
      B = a * bp + b * ap := rfl
      _ = a * bp + (-u) * (-cp) := by rw [hbEq, hapEq]
      _ = a * bp + u * cp := by rw [neg_mul_neg]
  have hTwo : (0 : α) < 2 := by norm_num
  have hFirst : 0 < a * cp := mul_pos ha hcp
  have hUB : 0 < u * bp := mul_pos hu hbp
  have hSecond : 0 < 2 * (u * bp) := mul_pos hTwo hUB
  have hCPos : 0 < C := by
    calc
      0 < a * cp + 2 * (u * bp) := add_pos hFirst hSecond
      _ = C := rfl
  have hANeg : A < 0 := by
    calc
      A = -C := hA
      _ < 0 := neg_neg_of_pos hCPos
  have hLeft : 0 < a * bp := mul_pos ha hbp
  have hRight : 0 < u * cp := mul_pos hu hcp
  have hBPos : 0 < B := by
    calc
      0 < a * bp + u * cp := add_pos hLeft hRight
      _ = B := hB.symm
  have hD : 0 < D := by
    calc
      0 < a * a - 2 * (u * u) := sub_pos.mpr hSq
      _ = D := rfl
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hChain :
      (a * a) * (cp * cp) - (2 * (u * u)) * (cp * cp) <
        (a * a) * (2 * (bp * bp)) - (2 * (u * u)) * (2 * (bp * bp)) := by
    calc
      (a * a) * (cp * cp) - (2 * (u * u)) * (cp * cp) =
          (a * a - 2 * (u * u)) * (cp * cp) := by rw [sub_mul]
      _ = D * (cp * cp) := rfl
      _ < D * (2 * (bp * bp)) := hMiddle
      _ = (a * a - 2 * (u * u)) * (2 * (bp * bp)) := rfl
      _ = (a * a) * (2 * (bp * bp)) - (2 * (u * u)) * (2 * (bp * bp)) := sub_mul _ _ _
  have hMoved :
      (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) <
        (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) :=
    sub_lt_sub_iff.mp hChain
  have hCSq : C * C =
      (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) +
      4 * ((a * cp) * (u * bp)) := by
    calc
      C * C = (a * cp + 2 * (u * bp)) * (a * cp + 2 * (u * bp)) := rfl
      _ = (a * cp) * (a * cp + 2 * (u * bp)) + (2 * (u * bp)) * (a * cp + 2 * (u * bp)) := add_mul _ _ _
      _ = ((a * cp) * (a * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * (u * bp)) * (2 * (u * bp))) := by simp only [mul_add]
      _ = ((a * a) * (cp * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * 2) * ((u * bp) * (u * bp))) := by rw [hRegroup a cp a cp, hRegroup 2 (u * bp) 2 (u * bp)]
      _ = ((a * a) * (cp * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * 2) * ((u * u) * (bp * bp))) := by rw [hRegroup u bp u bp]
      _ = ((a * a) * (cp * cp) + (a * cp) * (2 * (u * bp))) + ((2 * (u * bp)) * (a * cp) + (2 * (u * u)) * (2 * (bp * bp))) := by rw [hRegroup 2 (u * u) 2 (bp * bp)]
      _ = ((a * a) * (cp * cp) + ((a * cp) * 2) * (u * bp)) + (2 * ((u * bp) * (a * cp)) + (2 * (u * u)) * (2 * (bp * bp))) := by simp only [mul_assoc]
      _ = ((a * a) * (cp * cp) + (2 * (a * cp)) * (u * bp)) + (2 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (2 * (bp * bp))) := by rw [mul_comm (a * cp) 2, mul_comm (u * bp) (a * cp)]
      _ = ((a * a) * (cp * cp) + 2 * ((a * cp) * (u * bp))) + (2 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (2 * (bp * bp))) := by simp only [mul_assoc]
      _ = ((a * a) * (cp * cp) + (2 * ((a * cp) * (u * bp)) + 2 * ((a * cp) * (u * bp)))) + (2 * (u * u)) * (2 * (bp * bp)) := by simp only [add_assoc]
      _ = ((a * a) * (cp * cp) + (2 + 2) * ((a * cp) * (u * bp))) + (2 * (u * u)) * (2 * (bp * bp)) := by rw [add_mul]
      _ = ((a * a) * (cp * cp) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (2 * (bp * bp)) := by norm_num
      _ = (a * a) * (cp * cp) + (4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (2 * (bp * bp))) := by simp only [add_assoc]
      _ = (a * a) * (cp * cp) + ((2 * (u * u)) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp))) := by rw [add_comm (4 * ((a * cp) * (u * bp))) ((2 * (u * u)) * (2 * (bp * bp)))]
      _ = (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp)) := by simp only [add_assoc]
  have hBSq : 2 * (B * B) =
      (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) +
        4 * ((a * cp) * (u * bp)) := by
    calc
      2 * (B * B) = 2 * ((a * bp + u * cp) * (a * bp + u * cp)) := by rw [hB]
      _ = 2 * ((a * bp) * (a * bp + u * cp) + (u * cp) * (a * bp + u * cp)) := by rw [add_mul]
      _ = 2 * (((a * bp) * (a * bp) + (a * bp) * (u * cp)) + ((u * cp) * (a * bp) + (u * cp) * (u * cp))) := by simp only [mul_add]
      _ = 2 * (((a * a) * (bp * bp) + (a * u) * (bp * cp)) + ((u * a) * (cp * bp) + (u * u) * (cp * cp))) := by rw [hRegroup a bp a bp, hRegroup a bp u cp, hRegroup u cp a bp, hRegroup u cp u cp]
      _ = 2 * (((a * a) * (bp * bp) + (a * u) * (cp * bp)) + ((a * u) * (cp * bp) + (u * u) * (cp * cp))) := by rw [mul_comm bp cp, mul_comm u a]
      _ = 2 * (((a * a) * (bp * bp) + (a * cp) * (u * bp)) + ((a * cp) * (u * bp) + (u * u) * (cp * cp))) := by rw [hRegroup a u cp bp]
      _ = 2 * ((a * a) * (bp * bp) + (a * cp) * (u * bp)) + 2 * ((a * cp) * (u * bp) + (u * u) * (cp * cp)) := mul_add _ _ _
      _ = (2 * ((a * a) * (bp * bp)) + 2 * ((a * cp) * (u * bp))) + (2 * ((a * cp) * (u * bp)) + 2 * ((u * u) * (cp * cp))) := by simp only [mul_add]
      _ = (2 * ((a * a) * (bp * bp)) + (2 * ((a * cp) * (u * bp)) + 2 * ((a * cp) * (u * bp)))) + 2 * ((u * u) * (cp * cp)) := by simp only [add_assoc]
      _ = (2 * ((a * a) * (bp * bp)) + (2 + 2) * ((a * cp) * (u * bp))) + 2 * ((u * u) * (cp * cp)) := by rw [add_mul]
      _ = (2 * ((a * a) * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + 2 * ((u * u) * (cp * cp)) := by norm_num
      _ = (((2 * (a * a)) * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (cp * cp) := by simp only [mul_assoc]
      _ = ((((a * a) * 2) * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (cp * cp) := by rw [mul_comm 2 (a * a)]
      _ = ((a * a) * (2 * (bp * bp)) + 4 * ((a * cp) * (u * bp))) + (2 * (u * u)) * (cp * cp) := by simp only [mul_assoc]
      _ = (a * a) * (2 * (bp * bp)) + (4 * ((a * cp) * (u * bp)) + (2 * (u * u)) * (cp * cp)) := by simp only [add_assoc]
      _ = (a * a) * (2 * (bp * bp)) + ((2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp))) := by rw [add_comm (4 * ((a * cp) * (u * bp))) ((2 * (u * u)) * (cp * cp))]
      _ = (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) + 4 * ((a * cp) * (u * bp)) := by simp only [add_assoc]
  have hFinal : A * A < 2 * (B * B) := by
    calc
      A * A = (-C) * (-C) := by rw [hA]
      _ = C * C := neg_mul_neg _ _
      _ = (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) +
          4 * ((a * cp) * (u * bp)) := hCSq
      _ < (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) +
          4 * ((a * cp) * (u * bp)) := add_lt_add_of_lt_of_le hMoved le_rfl
      _ = 2 * (B * B) := hBSq.symm
  refine ⟨?_, ?_, ?_⟩
  · simpa only [hA, C] using hANeg
  · simpa only [hB] using hBPos
  · simpa only [hA, hB, C] using hFinal

end Ising2DLambda.NecSuf.FisherZero
