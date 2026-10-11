/-
「負の第一係数条件どうしの積」の具体版。
本文と同じく、両係数の符号を確定し、第一因子の平方差を正因子として
第二因子の平方比較へ掛け、移項と平方展開で負の第二係数条件を得る。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_negativeFirst_negativeFirst
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : (quadraticRepresentation s xi).1 < 0 ∧
      0 < (quadraticRepresentation s xi).2 ∧
      (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1 <
        2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2)
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  apply Or.inr
  apply Or.inl
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let c := -a
  let cp := -ap
  have ha : a < 0 := hxi.1
  have hap : ap < 0 := heta.1
  have hb : 0 < b := hxi.2.1
  have hbp : 0 < bp := heta.2.1
  have hc : 0 < c := neg_pos.mpr ha
  have hcp : 0 < cp := neg_pos.mpr hap
  have haEq : a = -c := (neg_neg a).symm
  have hapEq : ap = -cp := (neg_neg ap).symm
  have hSq : c * c < 2 * (b * b) := by
    calc
      c * c = (-a) * (-a) := rfl
      _ = a * a := neg_mul_neg _ _
      _ < (2 * b) * b := hxi.2.2
      _ = 2 * (b * b) := mul_assoc _ _ _
  have hSqp : cp * cp < 2 * (bp * bp) := by
    calc
      cp * cp = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
      _ < (2 * bp) * bp := heta.2.2
      _ = 2 * (bp * bp) := mul_assoc _ _ _
  let A := a * ap + 2 * (b * bp)
  let B := a * bp + b * ap
  let V := c * bp + b * cp
  let D := 2 * (b * b) - c * c
  have hTwo : (0 : ℚ) < 2 := by norm_num
  -- 本文「四因子の並べ替え」の五つの等号。
  have hRegroup (p q r t : ℚ) : (p * q) * (r * t) = (p * r) * (q * t) := by
    calc
      (p * q) * (r * t) = p * (q * (r * t)) := by simp only [mul_assoc]
      _ = p * ((q * r) * t) := by simp only [mul_assoc]
      _ = p * ((r * q) * t) := by rw [mul_comm q r]
      _ = p * (r * (q * t)) := by simp only [mul_assoc]
      _ = (p * r) * (q * t) := by simp only [mul_assoc]
  -- 本文「第一係数の表示」「第二係数の表示」。
  have hA : A = c * cp + 2 * (b * bp) := by
    calc
      A = a * ap + 2 * (b * bp) := rfl
      _ = (-c) * (-cp) + 2 * (b * bp) := by rw [haEq, hapEq]
      _ = c * cp + 2 * (b * bp) := by rw [neg_mul_neg]
  have hB : B = -V := by
    calc
      B = a * bp + b * ap := rfl
      _ = (-c) * bp + b * (-cp) := by rw [haEq, hapEq]
      _ = -(c * bp) + b * (-cp) := by rw [neg_mul]
      _ = -(c * bp) + -(b * cp) := by rw [mul_neg]
      _ = -(c * bp + b * cp) := by rw [neg_add]
      _ = -V := rfl
  have hFirst : 0 < c * cp := mul_pos hc hcp
  have hBB : 0 < b * bp := mul_pos hb hbp
  have hSecond : 0 < 2 * (b * bp) := mul_pos hTwo hBB
  have hAPos : 0 < A := by
    calc
      0 < c * cp + 2 * (b * bp) := add_pos hFirst hSecond
      _ = A := hA.symm
  have hLeft : 0 < c * bp := mul_pos hc hbp
  have hRight : 0 < b * cp := mul_pos hb hcp
  have hVPos : 0 < V := by
    calc
      0 < c * bp + b * cp := add_pos hLeft hRight
      _ = V := rfl
  have hBNeg : B < 0 := by
    calc
      B = -V := hB
      _ < 0 := neg_neg_of_pos hVPos
  -- 本文「正因子を掛けた比較」と移項。
  have hD : 0 < D := by
    calc
      0 < 2 * (b * b) - c * c := sub_pos.mpr hSq
      _ = D := rfl
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hChain :
      (2 * (b * b)) * (cp * cp) - (c * c) * (cp * cp) <
      (2 * (b * b)) * (2 * (bp * bp)) - (c * c) * (2 * (bp * bp)) := by
    calc
      (2 * (b * b)) * (cp * cp) - (c * c) * (cp * cp) =
          (2 * (b * b) - c * c) * (cp * cp) := by rw [sub_mul]
      _ = D * (cp * cp) := rfl
      _ < D * (2 * (bp * bp)) := hMiddle
      _ = (2 * (b * b) - c * c) * (2 * (bp * bp)) := rfl
      _ = (2 * (b * b)) * (2 * (bp * bp)) - (c * c) * (2 * (bp * bp)) := sub_mul _ _ _
  have hMoved :
      (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) <
      (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) :=
    sub_lt_sub_iff.mp hChain
  -- 本文「第一係数の平方の展開」。
  have hASq : A * A =
      (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) +
      4 * ((c * cp) * (b * bp)) := by
    calc
      A * A = (c * cp + 2 * (b * bp)) * (c * cp + 2 * (b * bp)) := by rw [hA]
      _ = (c * cp) * (c * cp + 2 * (b * bp)) + (2 * (b * bp)) * (c * cp + 2 * (b * bp)) := add_mul _ _ _
      _ = ((c * cp) * (c * cp) + (c * cp) * (2 * (b * bp))) + ((2 * (b * bp)) * (c * cp) + (2 * (b * bp)) * (2 * (b * bp))) := by simp only [mul_add]
      _ = ((c * c) * (cp * cp) + (c * cp) * (2 * (b * bp))) + ((2 * (b * bp)) * (c * cp) + (2 * 2) * ((b * bp) * (b * bp))) := by rw [hRegroup c cp c cp, hRegroup 2 (b * bp) 2 (b * bp)]
      _ = ((c * c) * (cp * cp) + (c * cp) * (2 * (b * bp))) + ((2 * (b * bp)) * (c * cp) + (2 * 2) * ((b * b) * (bp * bp))) := by rw [hRegroup b bp b bp]
      _ = ((c * c) * (cp * cp) + (c * cp) * (2 * (b * bp))) + ((2 * (b * bp)) * (c * cp) + (2 * (b * b)) * (2 * (bp * bp))) := by rw [hRegroup 2 (b * b) 2 (bp * bp)]
      _ = ((c * c) * (cp * cp) + ((c * cp) * 2) * (b * bp)) + (2 * ((b * bp) * (c * cp)) + (2 * (b * b)) * (2 * (bp * bp))) := by simp only [mul_assoc]
      _ = ((c * c) * (cp * cp) + (2 * (c * cp)) * (b * bp)) + (2 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (2 * (bp * bp))) := by rw [mul_comm (c * cp) 2, mul_comm (b * bp) (c * cp)]
      _ = ((c * c) * (cp * cp) + 2 * ((c * cp) * (b * bp))) + (2 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (2 * (bp * bp))) := by simp only [mul_assoc]
      _ = ((c * c) * (cp * cp) + (2 * ((c * cp) * (b * bp)) + 2 * ((c * cp) * (b * bp)))) + (2 * (b * b)) * (2 * (bp * bp)) := by simp only [add_assoc]
      _ = ((c * c) * (cp * cp) + (2 + 2) * ((c * cp) * (b * bp))) + (2 * (b * b)) * (2 * (bp * bp)) := by rw [add_mul]
      _ = ((c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (2 * (bp * bp)) := by norm_num
      _ = (c * c) * (cp * cp) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (2 * (bp * bp))) := by simp only [add_assoc]
      _ = (c * c) * (cp * cp) + ((2 * (b * b)) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp))) := by rw [add_comm (4 * ((c * cp) * (b * bp))) ((2 * (b * b)) * (2 * (bp * bp)))]
      _ = (c * c) * (cp * cp) + (2 * (b * b)) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp)) := by simp only [add_assoc]
      _ = (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp)) := by rw [add_comm ((c * c) * (cp * cp)) ((2 * (b * b)) * (2 * (bp * bp)))]
  -- 本文の最終比較。各等号・不等号は本文と同じ中間式を持つ。
  have hFinal : 2 * (B * B) < A * A := by
    calc
      2 * (B * B) = 2 * ((-V) * (-V)) := by rw [hB]
      _ = 2 * (V * V) := by rw [neg_mul_neg]
      _ = 2 * ((c * bp + b * cp) * (c * bp + b * cp)) := rfl
      _ = 2 * ((c * bp) * (c * bp + b * cp) + (b * cp) * (c * bp + b * cp)) := by rw [add_mul]
      _ = 2 * (((c * bp) * (c * bp) + (c * bp) * (b * cp)) + ((b * cp) * (c * bp) + (b * cp) * (b * cp))) := by simp only [mul_add]
      _ = 2 * (((c * c) * (bp * bp) + (c * b) * (bp * cp)) + ((b * c) * (cp * bp) + (b * b) * (cp * cp))) := by rw [hRegroup c bp c bp, hRegroup c bp b cp, hRegroup b cp c bp, hRegroup b cp b cp]
      _ = 2 * (((c * c) * (bp * bp) + (c * b) * (cp * bp)) + ((c * b) * (cp * bp) + (b * b) * (cp * cp))) := by rw [mul_comm bp cp, mul_comm b c]
      _ = 2 * (((c * c) * (bp * bp) + (c * cp) * (b * bp)) + ((c * cp) * (b * bp) + (b * b) * (cp * cp))) := by rw [hRegroup c b cp bp]
      _ = 2 * ((c * c) * (bp * bp) + (c * cp) * (b * bp)) + 2 * ((c * cp) * (b * bp) + (b * b) * (cp * cp)) := mul_add _ _ _
      _ = (2 * ((c * c) * (bp * bp)) + 2 * ((c * cp) * (b * bp))) + (2 * ((c * cp) * (b * bp)) + 2 * ((b * b) * (cp * cp))) := by simp only [mul_add]
      _ = (2 * ((c * c) * (bp * bp)) + (2 * ((c * cp) * (b * bp)) + 2 * ((c * cp) * (b * bp)))) + 2 * ((b * b) * (cp * cp)) := by simp only [add_assoc]
      _ = (2 * ((c * c) * (bp * bp)) + (2 + 2) * ((c * cp) * (b * bp))) + 2 * ((b * b) * (cp * cp)) := by rw [add_mul]
      _ = (2 * ((c * c) * (bp * bp)) + 4 * ((c * cp) * (b * bp))) + 2 * ((b * b) * (cp * cp)) := by norm_num
      _ = (((2 * (c * c)) * (bp * bp)) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (cp * cp) := by simp only [mul_assoc]
      _ = ((((c * c) * 2) * (bp * bp)) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (cp * cp) := by rw [mul_comm 2 (c * c)]
      _ = ((c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (cp * cp) := by simp only [mul_assoc]
      _ = (c * c) * (2 * (bp * bp)) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (cp * cp)) := by simp only [add_assoc]
      _ = (c * c) * (2 * (bp * bp)) + ((2 * (b * b)) * (cp * cp) + 4 * ((c * cp) * (b * bp))) := by rw [add_comm (4 * ((c * cp) * (b * bp))) ((2 * (b * b)) * (cp * cp))]
      _ = (c * c) * (2 * (bp * bp)) + (2 * (b * b)) * (cp * cp) + 4 * ((c * cp) * (b * bp)) := by simp only [add_assoc]
      _ = (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp)) := by rw [add_comm ((c * c) * (2 * (bp * bp))) ((2 * (b * b)) * (cp * cp))]
      _ < (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp)) := add_lt_add_of_lt_of_le hMoved le_rfl
      _ = A * A := hASq.symm
  have hOutputCompare : (2 * B) * B < A * A := by
    calc
      (2 * B) * B = 2 * (B * B) := mul_assoc _ _ _
      _ < A * A := hFinal
  exact ⟨hAPos, hBNeg, hOutputCompare⟩

end Ising2DLambda.FisherZero
