/-
「負の第二係数条件どうしの積」の具体版。
本文と同じく、両係数の符号を確定し、第一因子の平方差を正因子として
第二因子の平方比較へ掛け、移項と平方展開で負の第二係数条件を得る。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_negativeSecond_negativeSecond
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 < (quadraticRepresentation s xi).1 ∧
      (quadraticRepresentation s xi).2 < 0 ∧
      2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1)
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
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
  let u := -b
  let up := -bp
  have ha : 0 < a := by simpa [a] using hxi.1
  have hb : b < 0 := by simpa [b] using hxi.2.1
  have hap : 0 < ap := by simpa [ap] using heta.1
  have hbp : bp < 0 := by simpa [bp] using heta.2.1
  have hu : 0 < u := by simpa [u] using neg_pos.mpr hb
  have hup : 0 < up := by simpa [up] using neg_pos.mpr hbp
  have hSq : 2 * (u * u) < a * a := by
    simpa [u, a, b, mul_assoc] using hxi.2.2
  have hSqp : 2 * (up * up) < ap * ap := by
    simpa [up, ap, bp, mul_assoc] using heta.2.2
  have hAPos : 0 < a * ap + 2 * (b * bp) := by
    have hFirst : 0 < a * ap := mul_pos ha hap
    have hSecond : 0 < 2 * (u * up) := by positivity
    have : 0 < a * ap + 2 * (u * up) := add_pos hFirst hSecond
    simpa [u, up] using this
  have hVPos : 0 < a * up + u * ap :=
    add_pos (mul_pos ha hup) (mul_pos hu hap)
  have hBNeg : a * bp + b * ap < 0 := by
    have hEq : a * bp + b * ap = -(a * up + u * ap) := by
      dsimp [u, up]
      ring
    rw [hEq]
    exact neg_neg_of_pos hVPos
  let D := a * a - 2 * (u * u)
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (2 * (up * up)) < D * (ap * ap) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) <
        (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) := by
    dsimp [D] at hMiddle
    nlinarith
  have hFinal :
      2 * ((a * bp + b * ap) * (a * bp + b * ap)) <
        (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
    calc
      2 * ((a * bp + b * ap) * (a * bp + b * ap)) =
          (a * a) * (2 * (up * up)) +
            4 * ((a * ap) * (u * up)) +
            (2 * (u * u)) * (ap * ap) := by simp [u, up]; ring
      _ < (a * a) * (ap * ap) +
            (2 * (u * u)) * (2 * (up * up)) +
            4 * ((a * ap) * (u * up)) := by
          nlinarith
      _ = (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
          simp [u, up]
          ring
  exact ⟨hAPos, hBNeg, by simpa [mul_assoc] using hFinal⟩

end Ising2DLambda.FisherZero
