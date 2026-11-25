/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ClosedWalkRotationNumberSign
import Ising2DLambda.KacWard.ClosedWalkRotationPhaseFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationNumberSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

theorem closed_walk_rotation_phase_sign_from_necSuf {z : Qbar} (hz4 : z ^ 4 = -1)
    (r : ℤ) : z ^ ((4 : ℤ) * r) = (-1 : Qbar) ^ r :=
  zpow_four_mul_eq_neg_one_zpow_necSuf hz4 r

end Ising2DLambda.KacWard
