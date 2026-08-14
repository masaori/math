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
  have ha : 0 < a := by simpa [a] using hxi.1
  have hb : b < 0 := by simpa [b] using hxi.2.1
  have hap : ap < 0 := by simpa [ap] using heta.1
  have hbp : 0 < bp := by simpa [bp] using heta.2.1
  have hu : 0 < u := by simpa [u] using neg_pos.mpr hb
  have hcp : 0 < cp := by simpa [cp] using neg_pos.mpr hap
  have hSq : 2 * (u * u) < a * a := by
    simpa [u, a, b, mul_assoc] using hxi.2.2
  have hSqp : cp * cp < 2 * (bp * bp) := by
    simpa [cp, ap, bp, mul_assoc] using heta.2.2
  have hCPos : 0 < a * cp + 2 * (u * bp) :=
    add_pos (mul_pos ha hcp) (by positivity)
  have hANeg : a * ap + 2 * (b * bp) < 0 := by
    have hEq : a * ap + 2 * (b * bp) = -(a * cp + 2 * (u * bp)) := by
      dsimp [u, cp]
      ring
    rw [hEq]
    exact neg_neg_of_pos hCPos
  have hBPos : 0 < a * bp + b * ap := by
    have hEq : a * bp + b * ap = a * bp + u * cp := by
      dsimp [u, cp]
      ring
    rw [hEq]
    exact add_pos (mul_pos ha hbp) (mul_pos hu hcp)
  let D := a * a - 2 * (u * u)
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) <
        (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) := by
    dsimp [D] at hMiddle
    nlinarith
  have hFinal :
      (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) <
        2 * ((a * bp + b * ap) * (a * bp + b * ap)) := by
    calc
      (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) =
          (a * a) * (cp * cp) +
            4 * ((a * cp) * (u * bp)) +
            (2 * (u * u)) * (2 * (bp * bp)) := by simp [u, cp]; ring
      _ < (a * a) * (2 * (bp * bp)) +
            (2 * (u * u)) * (cp * cp) +
            4 * ((a * cp) * (u * bp)) := by
          nlinarith
      _ = 2 * ((a * bp + b * ap) * (a * bp + b * ap)) := by
          simp [u, cp]
          ring
  exact ⟨hANeg, hBPos, by simpa [mul_assoc] using hFinal⟩

end Ising2DLambda.FisherZero
