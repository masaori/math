/-
「二つの混合符号条件の積」の具体版。
本文と同じく、両係数の符号を確定し、第一因子の平方差を正因子として
第二因子の平方比較へ掛け、移項と平方展開で負の第一係数条件を得る。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_mixedSigns
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
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  apply Or.inr
  apply Or.inr
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let u := -b
  let cp := -ap
  have ha : 0 < a := hxi.1
  have hb : b < 0 := hxi.2.1
  have hap : ap < 0 := heta.1
  have hbp : 0 < bp := heta.2.1
  have hu : 0 < u := neg_pos.mpr hb
  have hcp : 0 < cp := neg_pos.mpr hap
  have hbEq : b = -u := (neg_neg b).symm
  have hapEq : ap = -cp := (neg_neg ap).symm
  have hSq : 2 * (u * u) < a * a := by
    calc
      2 * (u * u) = 2 * ((-b) * (-b)) := rfl
      _ = 2 * (b * b) := by rw [neg_mul_neg]
      _ = (2 * b) * b := (mul_assoc _ _ _).symm
      _ < a * a := hxi.2.2
  have hSqp : cp * cp < 2 * (bp * bp) := by
    calc
      cp * cp = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
      _ < (2 * bp) * bp := heta.2.2
      _ = 2 * (bp * bp) := mul_assoc _ _ _
  let A := a * ap + 2 * (b * bp)
  let B := a * bp + b * ap
  let C := a * cp + 2 * (u * bp)
  let D := a * a - 2 * (u * u)
  -- 本文の四因子の並べ替えを、結合則と可換則へ分ける。
  have hRegroup (p q r t : ℚ) : (p * q) * (r * t) = (p * r) * (q * t) := by
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
  have hTwo : (0 : ℚ) < 2 := by norm_num
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
  have hOutputCompare : A * A < (2 * B) * B := by
    calc
      A * A < 2 * (B * B) := hFinal
      _ = (2 * B) * B := (mul_assoc _ _ _).symm
  exact ⟨hANeg, hBPos, hOutputCompare⟩

end Ising2DLambda.FisherZero
