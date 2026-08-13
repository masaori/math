/-
「正錐の非負係数条件どうしの積」の具体版。
本文と同じ四つの正座標の場合分けで、積の二座標が同時には零にならないことを示す。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegativeCoefficients
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  apply Or.inl
  refine ⟨add_nonneg (mul_nonneg hxi.1 heta.1)
      (mul_nonneg (by norm_num) (mul_nonneg hxi.2.1 heta.2.1)),
    add_nonneg (mul_nonneg hxi.1 heta.2.1) (mul_nonneg hxi.2.1 heta.1), ?_⟩
  have hxiPos : 0 < (quadraticRepresentation s xi).1 ∨
      0 < (quadraticRepresentation s xi).2 := by
    rcases eq_or_lt_of_le hxi.1 with ha0 | ha
    · right
      rcases eq_or_lt_of_le hxi.2.1 with hb0 | hb
      · exact False.elim (hxi.2.2 (Prod.ext ha0.symm hb0.symm))
      · exact hb
    · exact Or.inl ha
  have hetaPos : 0 < (quadraticRepresentation s eta).1 ∨
      0 < (quadraticRepresentation s eta).2 := by
    rcases eq_or_lt_of_le heta.1 with hap0 | hap
    · right
      rcases eq_or_lt_of_le heta.2.1 with hbp0 | hbp
      · exact False.elim (heta.2.2 (Prod.ext hap0.symm hbp0.symm))
      · exact hbp
    · exact Or.inl hap
  intro hPair
  have hA := congrArg Prod.fst hPair
  have hB := congrArg Prod.snd hPair
  rcases hxiPos with ha | hb <;> rcases hetaPos with hap | hbp
  · have hPositive : 0 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
          2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2) := by
      have hMain := mul_pos ha hap
      have hRest := mul_nonneg hxi.2.1 heta.2.1
      nlinarith
    linarith
  · have hPositive : 0 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
          (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1 := by
      have hMain := mul_pos ha hbp
      have hRest := mul_nonneg hxi.2.1 heta.1
      nlinarith
    linarith
  · have hPositive : 0 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
          (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1 := by
      have hMain := mul_pos hb hap
      have hRest := mul_nonneg hxi.1 heta.2.1
      nlinarith
    linarith
  · have hPositive : 0 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
          2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2) := by
      have hMain := mul_pos hb hbp
      have hRest := mul_nonneg hxi.1 heta.1
      nlinarith
    linarith

end Ising2DLambda.FisherZero
