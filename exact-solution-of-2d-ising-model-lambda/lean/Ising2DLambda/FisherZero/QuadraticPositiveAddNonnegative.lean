/-
「正錐の非負係数条件どうしの和」の具体版。
本文と同じく和の表示を使い、二座標の非負性と非零性を個別に示す。
-/
import Ising2DLambda.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegativeCoefficients
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  apply Or.inl
  refine ⟨add_nonneg hxi.1 heta.1, add_nonneg hxi.2.1 heta.2.1, ?_⟩
  intro hPair
  have hA := congrArg Prod.fst hPair
  have hB := congrArg Prod.snd hPair
  have haNonpos : (quadraticRepresentation s xi).1 ≤ 0 := by
    linarith only [heta.1, hA]
  have ha0 : (quadraticRepresentation s xi).1 = 0 :=
    le_antisymm haNonpos hxi.1
  have hbNonpos : (quadraticRepresentation s xi).2 ≤ 0 := by
    linarith only [heta.2.1, hB]
  have hb0 : (quadraticRepresentation s xi).2 = 0 :=
    le_antisymm hbNonpos hxi.2.1
  exact hxi.2.2 (Prod.ext ha0 hb0)

end Ising2DLambda.FisherZero
