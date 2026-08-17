/-
「持ち上げの値は整係数多項式の代数的数における値に一致する」の具体版が、
必要十分版 `lift_eval_eq_of_coeff_eq_necSuf` の特殊化として得られることの導出。
S を Qbar、x を ξ、n を f の次数、cL を持ち上げの係数、cR を f の係数の像に取る。
-/
import Ising2DLambda.ThermodynamicLimit.IntegerPolynomialQbarLiftEvaluation
import Ising2DLambda.NecSuf.ThermodynamicLimit.IntegerPolynomialQbarLiftEvaluation

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero

theorem qbarPolyEval_integerPolynomialQbarLift_from_necSuf (xi : Qbar) (f : Polynomial ℤ) :
    qbarPolyEval xi (integerPolynomialQbarLift f) = qbarPolynomialEval xi f :=
  NecSuf.ThermodynamicLimit.lift_eval_eq_of_coeff_eq_necSuf xi f.natDegree
    (fun k => (integerPolynomialQbarLift f).coeff k)
    (fun k => ((f.coeff k : ℤ) : Qbar))
    (qbarPolyEval xi (integerPolynomialQbarLift f)) (qbarPolynomialEval xi f)
    (qbarPolyEvalCoefficientSum xi (integerPolynomialQbarLift f) f.natDegree
      (fun k hk => integerPolynomialQbarLift_coeff_eq_zero_of_natDegree_lt f k hk))
    (fun k => integerPolynomialQbarLift_coeff f k)
    (by
      unfold qbarPolynomialEval
      rw [Polynomial.coe_eval₂RingHom, Polynomial.eval₂_eq_sum_range]
      rfl)

end Ising2DLambda.ThermodynamicLimit
