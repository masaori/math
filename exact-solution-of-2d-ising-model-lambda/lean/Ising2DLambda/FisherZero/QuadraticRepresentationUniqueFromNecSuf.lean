import Ising2DLambda.FisherZero.OneSLinearlyIndependent
import Ising2DLambda.NecSuf.FisherZero.QuadraticRepresentationUnique

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_representation_unique` の具体版を必要十分版から導く。 -/
theorem quadraticRepresentationUnique_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (a b a' b' : ℚ)
    (hab : algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s =
      algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) :
    a = a' ∧ b = b' := by
  apply Ising2DLambda.NecSuf.FisherZero.quadratic_representation_unique_necSuf
      (embed := (algebraMap ℚ Qbar).toAddMonoidHom)
      (smul := fun z t : Qbar => z * t)
      (s := s)
  · intro x y t
    exact add_mul x y t
  · intro t
    exact zero_mul t
  · intro α β hzero
    exact oneSLinearlyIndependent s hs α β hzero
  · exact hab

end Ising2DLambda.FisherZero
