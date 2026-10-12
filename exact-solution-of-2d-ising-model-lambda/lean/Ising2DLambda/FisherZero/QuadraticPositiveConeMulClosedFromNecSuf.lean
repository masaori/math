/-
「正錐と乗法の両立」の導出。
積の表示公式と六つの符号場合の必要十分版から、九場合の証明を特殊化する。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecondFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirstFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeSecondNegativeSecondFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulMixedSignsFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeFirstNegativeFirstFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveConeMulClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositiveCone_mul_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s)
    (heta : eta ∈ quadraticPositiveCone s) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  exact Ising2DLambda.NecSuf.FisherZero.positive_cone_mul_closed_necSuf
    (quadraticMulElement s hs) (fun a b : ℚ => a + b) (fun a b : ℚ => a * b)
    (2 : ℚ) (quadraticRepresentation s) (quadraticRepresentation_mul_from_necSuf s hs)
    (fun a b => mul_comm a b) (fun a b => add_comm a b)
    (fun ab => 0 ≤ ab.1 ∧ 0 ≤ ab.2 ∧ ab ≠ (0, 0))
    (fun ab => 0 < ab.1 ∧ ab.2 < 0 ∧ 2 * ab.2 * ab.2 < ab.1 * ab.1)
    (fun ab => ab.1 < 0 ∧ 0 < ab.2 ∧ ab.1 * ab.1 < 2 * ab.2 * ab.2)
    (fun x y hx hy => quadraticPositive_mul_of_nonnegativeCoefficients_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_mul_of_nonnegative_negativeSecond_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_mul_of_nonnegative_negativeFirst_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_mul_of_negativeSecond_negativeSecond_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_mul_of_mixedSigns_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_mul_of_negativeFirst_negativeFirst_from_necSuf
      s hs x y hx hy)
    xi eta hxi heta

end Ising2DLambda.FisherZero
