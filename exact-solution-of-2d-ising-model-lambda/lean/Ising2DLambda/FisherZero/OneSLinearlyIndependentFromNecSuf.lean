import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.FisherZero.OneSLinearlyIndependent

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_one_s_linearly_independent` の具体版を必要十分版から導く。 -/
theorem oneSLinearlyIndependent_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b : ℚ) (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s = 0) :
    a = 0 ∧ b = 0 := by
  exact Ising2DLambda.NecSuf.FisherZero.one_s_linearly_independent_necSuf
    (algebraMap ℚ Qbar) noRationalSquareTwo s hs a b hab

end Ising2DLambda.FisherZero
