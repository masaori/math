/-
具体版が必要十分版の特殊化として得られることの導出。
値の型を Qbar[t]、因子を t - ŵ_k、上界の述語を「その番号より上の係数が零」とし、
hprod を一次因子の積の係数上界（r2）、hstep を一次因子との積の係数上界（d4b2a）で埋める。
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
        = (Polynomial.X - qbarConst (w i)) * B ∧
      ∀ l : ℕ, j - 1 < l → B.coeff l = 0 := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.linear_factor_product_extract_necSuf
    (fun k => Polynomial.X - qbarConst (w k))
    (fun B m => ∀ l : ℕ, m < l → B.coeff l = 0)
    (fun m => qbarPolyLinearFactorProductCoeffBound w m)
    (fun C m n hC => qbarPolyLinearFactorCoeffBound (w n) C m hC)
    j i hi

end Ising2DLambda.AlgebraicEigenvalue
