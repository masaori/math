/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialFactorQuotient
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootPolynomialFactorQuotient

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootPolynomialFactorQuotientEq_from_necSuf (w : Qbar) (n : ℕ) (hn : 1 ≤ n) :
    rootFactorQuotient w n = qbarPolyPowDiffSum w n := by
  rw [rootFactorQuotient]
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.single_term_sum_necSuf
  · have hn0 : n ≠ 0 := Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one hn)
    rw [rootPolynomial_coeff_top n hn0]
    simp [qbarConst]
  · intro k hk hkn
    exact rootFactorQuotient_term_zero w n k hkn

end Ising2DLambda.AlgebraicEigenvalue
