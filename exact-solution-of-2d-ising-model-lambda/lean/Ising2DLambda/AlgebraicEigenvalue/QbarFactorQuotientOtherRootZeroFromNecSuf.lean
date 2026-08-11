/-
「一次因子を取り除いた商は、もとの根と相異なる根で零になる」の具体版が、
必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientOtherRootZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarFactorQuotientOtherRootZero

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarFactorQuotientOtherRootZero_from_necSuf (f g : QbarPoly) (w w' : Qbar)
    (hfactor : f = (Polynomial.X - qbarConst w) * g)
    (hroot : qbarPolyEval w' f = 0) (hne : w' ≠ w) :
    qbarPolyEval w' g = 0 := by
  apply NecSuf.AlgebraicEigenvalue.factor_quotient_other_root_zero_necSuf
      (P := QbarPoly) (M := Qbar) (fun p q => p * q) (qbarPolyEval w')
      f (Polynomial.X - qbarConst w) g (w' - w) (w' - w)⁻¹
  · exact hfactor
  · simp [qbarPolyEval_eq_eval]
  · simp [qbarPolyEval_eq_eval, qbarConst]
  · exact hroot
  · exact inv_mul_cancel₀ (sub_ne_zero.mpr hne)

end Ising2DLambda.AlgebraicEigenvalue
