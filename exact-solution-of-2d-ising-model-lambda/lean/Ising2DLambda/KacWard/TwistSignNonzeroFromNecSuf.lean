/- ねじれ符号が零でないことの具体版が、必要十分版の二値の議論の特殊化として得られることの記録。 -/
import Ising2DLambda.KacWard.TwistSignNonzero
import Ising2DLambda.NecSuf.KacWard.TwistSignNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete seam parity specializes the two-value argument. -/
theorem twistSign_qbar_ne_zero_from_necSuf {L : ℕ} (s : SpinStructure)
    (e : OrientedEdge L) : ((twistSign s e : ℤ) : Qbar) ≠ 0 := by
  rw [twistSign_eq_neg_one_pow_twistParity]
  push_cast
  exact Ising2DLambda.NecSuf.KacWard.two_value_power_ne_zero
    ((-1 : Qbar)) (by norm_num) (twistParity s e)
    (twistParity_eq_zero_or_one s e)

end Ising2DLambda.KacWard
