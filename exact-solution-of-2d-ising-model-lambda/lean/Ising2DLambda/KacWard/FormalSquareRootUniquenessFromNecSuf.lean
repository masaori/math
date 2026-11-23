/- 形式的平方根の一意性の具体版が、必要十分版の特殊化として得られることの記録。 -/
import Ising2DLambda.KacWard.FormalSquareRootUniqueness
import Ising2DLambda.NecSuf.KacWard.FormalSquareRootUniqueness

namespace Ising2DLambda.KacWard

open PowerSeries Ising2DLambda.AlgebraicEigenvalue

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem formalSquareRoot_unique_from_necSuf (D S T : PowerSeries Qbar)
    (hS0 : constantCoeff S = 1) (hT0 : constantCoeff T = 1)
    (hSsq : S * S = D) (hTsq : T * T = D) : S = T :=
  Ising2DLambda.NecSuf.KacWard.formalSquareRoot_unique_necSuf
    (by norm_num : (2 : Qbar) ≠ 0) D S T hS0 hT0 hSsq hTsq

end Ising2DLambda.KacWard
