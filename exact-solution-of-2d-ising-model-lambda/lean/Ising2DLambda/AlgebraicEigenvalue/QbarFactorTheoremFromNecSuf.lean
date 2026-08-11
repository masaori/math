/- 「根を持つ多項式は一次式を因子に持つ」の具体版が必要十分版の特殊化であること。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorTheorem
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FactorFromFiniteSum

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarFactorTheorem_from_necSuf (f : QbarPoly) (w : Qbar) (n : ℕ)
    (hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0)
    (hroot : qbarPolyEval w f = 0) :
    ∃ g : QbarPoly, f = (Polynomial.X - qbarConst w) * g := by
  apply NecSuf.AlgebraicEigenvalue.factor_from_finite_sum_necSuf
      f Polynomial.X (qbarConst w) (fun k => qbarConst (f.coeff k))
      (qbarPolyPowDiffSum w) n
  · exact qbarPolyMonomialDecomposition f n hcoeff
  · have hw : (∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k) = 0 := by
      rw [← qbarPolyEvalCoefficientSum w f n hcoeff, hroot]
    simpa only [qbarConst, map_pow, map_mul, map_sum, map_zero] using
      congrArg Polynomial.C hw
  · intro k
    exact (qbarPolyPowerDifferenceFactorization w k).symm

end Ising2DLambda.AlgebraicEigenvalue
