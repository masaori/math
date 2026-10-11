import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirst
import Ising2DLambda.FisherZero.QuadraticAdditionFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirst

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_negativeFirst_negativeFirst_from_necSuf
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
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  -- 本文の和の表示を、実際の二次体の表示から供給する。
  have hRep := quadraticRepresentation_add_from_necSuf s hs xi eta
  -- 係数の二条件を必要十分版へ特殊化する。
  have hCoefficients :=
    Ising2DLambda.NecSuf.FisherZero.positive_add_negativeFirst_negativeFirst_necSuf
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
      hxi.1 hxi.2.1 hxi.2.2 heta.1 heta.2.1 heta.2.2
  -- 本文の正錐所属の行。
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  exact Or.inr (Or.inr hCoefficients)

end Ising2DLambda.FisherZero
