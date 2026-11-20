/-
具体版が必要十分版の特殊化として得られることの導出。
因子のモノイドを Qbar[t]、値の環を Qbar、値を取る写像を z での評価、因子を t - β̂(r)、
各因子の値を z - β(r)（`qbarPolyEvalLinearFactorProduct` の第四・第五の等号と同じ約束）とする。
-/
import Ising2DLambda.FisherZero.QbarLinearFactorProductRootIsListedRoot
import Ising2DLambda.NecSuf.FisherZero.QbarLinearFactorProductRootIsListedRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open scoped BigOperators

theorem qbarLinearFactorProductRootIsListedRoot_from_necSuf (N : ℕ) (β : ℕ → Qbar) (z : Qbar)
    (h : qbarPolyEval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) = 0) :
    ∃ r : ℕ, r < N ∧ z = β r := by
  refine Ising2DLambda.NecSuf.FisherZero.linear_factor_product_root_is_listed_root_necSuf
    (Polynomial.evalRingHom z).toMonoidHom (fun r => Polynomial.X - qbarConst (β r)) β z
    (fun r => ?_) N ?_
  · show Polynomial.eval z (Polynomial.X - qbarConst (β r)) = z - β r
    rw [Polynomial.eval_sub, Polynomial.eval_X, qbarConst, Polynomial.eval_C]
  · show Polynomial.eval z (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) = 0
    rw [← qbarPolyEval_eq_eval]
    exact h

end Ising2DLambda.FisherZero
