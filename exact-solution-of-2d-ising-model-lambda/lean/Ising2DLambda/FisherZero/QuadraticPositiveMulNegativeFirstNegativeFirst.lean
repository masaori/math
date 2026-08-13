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
  have ha : a < 0 := by simpa [a] using hxi.1
  have hb : 0 < b := by simpa [b] using hxi.2.1
  have hap : ap < 0 := by simpa [ap] using heta.1
  have hbp : 0 < bp := by simpa [bp] using heta.2.1
  have hc : 0 < c := by simpa [c] using neg_pos.mpr ha
  have hcp : 0 < cp := by simpa [cp] using neg_pos.mpr hap
  have hSq : c * c < 2 * (b * b) := by
    simpa [c, a, b, mul_assoc] using hxi.2.2
  have hSqp : cp * cp < 2 * (bp * bp) := by
    simpa [cp, ap, bp, mul_assoc] using heta.2.2
  have hAPos : 0 < a * ap + 2 * (b * bp) := by
    have hFirst : 0 < c * cp := mul_pos hc hcp
    have hSecond : 0 < 2 * (b * bp) := by positivity
    have : 0 < c * cp + 2 * (b * bp) := add_pos hFirst hSecond
    simpa [c, cp] using this
  have hVPos : 0 < c * bp + b * cp :=
    add_pos (mul_pos hc hbp) (mul_pos hb hcp)
  have hBNeg : a * bp + b * ap < 0 := by
    have hEq : a * bp + b * ap = -(c * bp + b * cp) := by
      dsimp [c, cp]
      ring
    rw [hEq]
    exact neg_neg_of_pos hVPos
  let D := 2 * (b * b) - c * c
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) <
        (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) := by
    dsimp [D] at hMiddle
    nlinarith
  have hFinal :
      2 * ((a * bp + b * ap) * (a * bp + b * ap)) <
        (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
    calc
      2 * ((a * bp + b * ap) * (a * bp + b * ap)) =
          (c * c) * (2 * (bp * bp)) +
            4 * ((c * cp) * (b * bp)) +
            (2 * (b * b)) * (cp * cp) := by simp [c, cp]; ring
      _ < (2 * (b * b)) * (2 * (bp * bp)) +
            (c * c) * (cp * cp) +
            4 * ((c * cp) * (b * bp)) := by
          nlinarith
      _ = (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
          simp [c, cp]
          ring
  exact ⟨hAPos, hBNeg, by simpa [mul_assoc] using hFinal⟩

end Ising2DLambda.FisherZero
