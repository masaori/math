import Ising2DLambda.FisherZero.OneSLinearlyIndependentFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticRepresentationUnique

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_representation_unique` の具体的な包含写像・右乗法・一次独立性を
必要十分版へ供給する。係数差の移送と復元は、本文の十六行・六行・六行に対応する。 -/
theorem quadraticRepresentationUnique_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b a' b' : ℚ)
    (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s =
      algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) :
    a = a' ∧ b = b' := by
  exact Ising2DLambda.NecSuf.FisherZero.quadratic_representation_unique_necSuf
    add_zero neg_add_cancel add_assoc zero_add
    add_assoc add_comm add_neg_cancel zero_add
    (algebraMap ℚ Qbar) (map_add (algebraMap ℚ Qbar)) (map_neg (algebraMap ℚ Qbar))
    (fun z : Qbar => z * s) (fun x y => add_mul x y s) (zero_mul s)
    (fun α β hzero => oneSLinearlyIndependent_from_necSuf s hs α β hzero)
    a b a' b' hab

end Ising2DLambda.FisherZero
