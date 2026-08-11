/-
章「固有値の代数性」の「一次因子を取り除いた商は、もとの根と相異なる根で零になる」の具体版。
人手証明の正本は `claim_qbar_factor_quotient_other_root_zero` である。

人手証明と同じく、因子分解をもう一つの根で評価し、零でない差を左から割る。
既製の多項式の根の個数定理には委ねない。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorTheorem
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- `f = (X - C w)g` で、`w' ≠ w` が `f` の根ならば `w'` は `g` の根である。 -/
theorem qbarFactorQuotientOtherRootZero (f g : QbarPoly) (w w' : Qbar)
    (hfactor : f = (Polynomial.X - qbarConst w) * g)
    (hroot : qbarPolyEval w' f = 0) (hne : w' ≠ w) :
    qbarPolyEval w' g = 0 := by
  have hchain : (w' - w) * qbarPolyEval w' g = 0 := by
    calc
      (w' - w) * qbarPolyEval w' g
          = qbarPolyEval w' (Polynomial.X - qbarConst w) * qbarPolyEval w' g := by
              simp [qbarPolyEval_eq_eval, qbarConst]
      _ = qbarPolyEval w' ((Polynomial.X - qbarConst w) * g) := by
              simp [qbarPolyEval_eq_eval]
      _ = qbarPolyEval w' f := by rw [hfactor]
      _ = 0 := hroot
  have hdiff : w' - w ≠ 0 := sub_ne_zero.mpr hne
  exact qbarNoZeroDivisors hdiff hchain

end Ising2DLambda.AlgebraicEigenvalue
