/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ReconnectionTurningDifference
import Ising2DLambda.NecSuf.KacWard.ReconnectionTurningDifference

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。`D` を回転数の差に取り、
整除（π₄ による合同）と範囲（τ ∈ {0,1,-1}）を渡せば、必要十分版がこの主張を与える。 -/
theorem reconnection_turning_difference_from_necSuf {D : ℤ} (hdvd : (4 : ℤ) ∣ D)
    (hlow : -4 ≤ D) (hhigh : D ≤ 4) : D = -4 ∨ D = 0 ∨ D = 4 :=
  dvd_four_bounded_mem_necSuf hdvd hlow hhigh

end Ising2DLambda.KacWard
