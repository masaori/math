/- 必要十分版を Qbar 上の具体的なデータへ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.RealClosedSubfield
import Ising2DLambda.NecSuf.FisherZero.RealClosedSubfield

namespace Ising2DLambda.FisherZero

/-- 具体版の帰結が必要十分版の特殊化として得られる。 -/
theorem realClosedOmega_pow_four_from_necSuf (data : RealClosedSubfieldData) :
    data.omega ^ 4 = 1 := by
  exact Ising2DLambda.NecSuf.FisherZero.omega_pow_four_of_square_neg_one_necSuf
    data.omega data.omega_sq

end Ising2DLambda.FisherZero
