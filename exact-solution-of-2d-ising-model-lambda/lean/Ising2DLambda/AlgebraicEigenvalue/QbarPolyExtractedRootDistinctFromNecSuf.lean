/-
具体版が必要十分版の特殊化として得られることの導出。
点の型を Qbar、多項式の型を Qbar[t]、値の型を Qbar、評価の族を qbarPolyEval とし、
終点の非零性は d4b2c1（rootPolynomialRemainingFactorValueNeZero）から供給する。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyExtractedRootDistinct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyExtractedRootDistinct

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarPolyExtractedRootDistinct_from_necSuf (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) (h A g : QbarPoly)
    (hcoeff : ∀ k, n < k → h.coeff k = 0)
    (hf : rootPolynomial n = (Polynomial.X - qbarConst w) * h)
    (hAg : h = A * g) (w' : Qbar) (hg : qbarPolyEval w' g = 0) :
    w' ≠ w := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.extracted_root_distinct_necSuf
    (fun q p => qbarPolyEval q p) h A g w w' hAg
    (by
      rw [qbarPolyEval_eq_eval, Polynomial.eval_mul,
        ← qbarPolyEval_eq_eval, ← qbarPolyEval_eq_eval])
    (by rw [mul_zero])
    (rootPolynomialRemainingFactorValueNeZero n hn w hw h hcoeff hf) hg

end Ising2DLambda.AlgebraicEigenvalue
