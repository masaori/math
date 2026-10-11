import Ising2DLambda.FisherZero.NoRationalSquareTwoFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.FisherZero.OneSLinearlyIndependent

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_one_s_linearly_independent` の五計算鎖を、包含写像の保存則と
有理数・代数的数の演算法則、および有理数平方の非二性の導出版で特殊化する。 -/
theorem oneSLinearlyIndependent_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b : ℚ) (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s = 0) :
    a = 0 ∧ b = 0 := by
  exact Ising2DLambda.NecSuf.FisherZero.one_s_linearly_independent_necSuf
    (algebraMap ℚ Qbar) (algebraMap ℚ Qbar).injective
    (map_mul (algebraMap ℚ Qbar)) (map_neg (algebraMap ℚ Qbar))
    (map_one (algebraMap ℚ Qbar)) (map_zero (algebraMap ℚ Qbar))
    (fun _ hb => inv_mul_cancel₀ hb)
    zero_add add_zero neg_add_cancel add_assoc one_mul mul_assoc zero_mul
    2 noRationalSquareTwo_from_necSuf s hs a b hab

end Ising2DLambda.FisherZero
