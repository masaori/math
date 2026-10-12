/-
「正錐と加法の両立」の導出。
表示の加法保存と六つの符号場合の必要十分版から、九場合の証明を特殊化する。
-/
import Ising2DLambda.FisherZero.QuadraticAdditionFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeSecondFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeFirstFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeSecondNegativeSecondFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddMixedSignsFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirstFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveConeAddClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositiveCone_add_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s)
    (heta : eta ∈ quadraticPositiveCone s) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  exact Ising2DLambda.NecSuf.FisherZero.positive_cone_add_closed_necSuf
    (quadraticAddElement s) (fun a b : ℚ => a + b) (quadraticRepresentation s)
    (quadraticRepresentation_add_from_necSuf s hs) (fun a b => add_comm a b)
    (fun ab => 0 ≤ ab.1 ∧ 0 ≤ ab.2 ∧ ab ≠ (0, 0))
    (fun ab => 0 < ab.1 ∧ ab.2 < 0 ∧ 2 * ab.2 * ab.2 < ab.1 * ab.1)
    (fun ab => ab.1 < 0 ∧ 0 < ab.2 ∧ ab.1 * ab.1 < 2 * ab.2 * ab.2)
    (fun x y hx hy => quadraticPositive_add_of_nonnegativeCoefficients_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_add_of_nonnegative_negativeSecond_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_add_of_nonnegative_negativeFirst_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_add_of_negativeSecond_negativeSecond_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_add_of_mixedSigns_from_necSuf
      s hs x y hx hy)
    (fun x y hx hy => quadraticPositive_add_of_negativeFirst_negativeFirst_from_necSuf
      s hs x y hx hy)
    xi eta hxi heta

end Ising2DLambda.FisherZero
