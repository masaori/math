/-
具体版が必要十分版の特殊化として得られることの導出。
値の型を Qbar[t]、因子を t - ŵ_k とする。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorProductExtract
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorProductExtract

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

theorem qbarPolyLinearFactorProductExtract_from_necSuf (w : ℕ → Qbar) (j i : ℕ)
    (hi : i < j) :
    ∃ B : QbarPoly,
      (∏ k ∈ Finset.range j, (Polynomial.X - qbarConst (w k)))
        = (Polynomial.X - qbarConst (w i)) * B := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.linear_factor_product_extract_necSuf
    (fun k => Polynomial.X - qbarConst (w k)) j i hi

end Ising2DLambda.AlgebraicEigenvalue
