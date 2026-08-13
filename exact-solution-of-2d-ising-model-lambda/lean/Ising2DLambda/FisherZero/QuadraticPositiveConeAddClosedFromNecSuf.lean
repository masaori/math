/-
「正錐と加法の両立」の導出。
必要十分版へ、具体版の六補題・転送・所属の分解をそのまま渡す。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveConeAddClosed
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveConeAddClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositiveCone_add_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s)
    (heta : eta ∈ quadraticPositiveCone s) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  have hxi' : quadraticCoefficientPositive (quadraticRepresentation s xi) := hxi
  have heta' : quadraticCoefficientPositive (quadraticRepresentation s eta) := heta
  exact Ising2DLambda.NecSuf.FisherZero.positive_cone_add_closed_necSuf
    (quadraticAddElement s)
    (fun z => z ∈ quadraticPositiveCone s)
    (fun z => 0 ≤ (quadraticRepresentation s z).1 ∧
      0 ≤ (quadraticRepresentation s z).2 ∧
      quadraticRepresentation s z ≠ (0, 0))
    (fun z => 0 < (quadraticRepresentation s z).1 ∧
      (quadraticRepresentation s z).2 < 0 ∧
      2 * (quadraticRepresentation s z).2 * (quadraticRepresentation s z).2 <
        (quadraticRepresentation s z).1 * (quadraticRepresentation s z).1)
    (fun z => (quadraticRepresentation s z).1 < 0 ∧
      0 < (quadraticRepresentation s z).2 ∧
      (quadraticRepresentation s z).1 * (quadraticRepresentation s z).1 <
        2 * (quadraticRepresentation s z).2 * (quadraticRepresentation s z).2)
    xi eta hxi' heta'
    (fun h1 h2 => quadraticPositive_add_of_nonnegativeCoefficients s hs xi eta h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_nonnegative_negativeSecond s hs xi eta h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_nonnegative_negativeFirst s hs xi eta h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_nonnegative_negativeSecond s hs eta xi h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_nonnegative_negativeFirst s hs eta xi h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_negativeSecond_negativeSecond s hs xi eta h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_mixedSigns s hs xi eta h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_mixedSigns s hs eta xi h1 h2)
    (fun h1 h2 => quadraticPositive_add_of_negativeFirst_negativeFirst s hs xi eta h1 h2)
    (quadraticPositiveCone_add_transfer s hs xi eta)

end Ising2DLambda.FisherZero
