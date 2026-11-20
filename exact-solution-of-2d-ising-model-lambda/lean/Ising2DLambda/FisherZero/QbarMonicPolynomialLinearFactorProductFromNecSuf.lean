/-
具体版が必要十分版の特殊化として得られることの導出。
値の型を Qbar[t]（積の可換モノイド）、根の型を Qbar、因子を t - x̂、
上界の述語を「その番号より上の係数が零」、先頭の係数の述語を「その番号の係数が 1」とし、
- hbase を出発点の式鎖（`qbarPolyEqOneOfCoeffZeroBound`）、
- hroot を代数閉性（`rootPolynomialDistinctFactorizationRootExists`）、
- hfactor を因数定理の商の三条件（`rootPolynomialDistinctFactorizationQuotient`）
で埋める。
-/
import Ising2DLambda.FisherZero.QbarMonicPolynomialLinearFactorProduct
import Ising2DLambda.NecSuf.FisherZero.QbarMonicPolynomialLinearFactorProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

theorem qbarMonicPolynomialLinearFactorProduct_from_necSuf (d : ℕ) (f : QbarPoly)
    (hbound : ∀ k : ℕ, d < k → f.coeff k = 0) (hlead : f.coeff d = 1) :
    ∃ α : ℕ → Qbar, f = ∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i)) := by
  exact Ising2DLambda.NecSuf.FisherZero.monic_linear_factor_product_necSuf
    (fun x => Polynomial.X - qbarConst x)
    (fun C m => ∀ k : ℕ, m < k → C.coeff k = 0)
    (fun C m => C.coeff m = 1)
    (fun x g => qbarPolyEval x g = 0)
    (fun g hb hl => qbarPolyEqOneOfCoeffZeroBound g hb hl)
    (fun g m hm hl => rootPolynomialDistinctFactorizationRootExists g m hm hl)
    (fun g x m hm hb hl hr => rootPolynomialDistinctFactorizationQuotient g x m hm hb hl hr)
    d f hbound hlead

end Ising2DLambda.FisherZero
