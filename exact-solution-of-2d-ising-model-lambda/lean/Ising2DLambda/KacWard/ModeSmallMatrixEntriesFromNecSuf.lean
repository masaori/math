import Ising2DLambda.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.KacWard.ModeSmallMatrixFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_mode_small_matrix_entries`: specialize the generic calculation. -/
theorem modeSmallMatrix_eq_entries_from_necSuf (z varpi varsigma : Qbar) :
    modeSmallMatrix z varpi varsigma = modeSmallMatrixEntries z varpi varsigma := by
  rw [modeSmallMatrix_from_necSuf]
  rw [Ising2DLambda.NecSuf.KacWard.modeSmallMatrix_eq_entries]
  rfl

end Ising2DLambda.KacWard
