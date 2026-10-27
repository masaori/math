import Ising2DLambda.KacWard.EdgeModeIndexBijection
import Ising2DLambda.KacWard.ModeSmallMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def modeBlockMatrix {L : ℕ} (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar := by
  classical
  exact fun g h =>
    if (κ g).val.1 = (κ h).val.1 ∧ (κ g).val.2.1 = (κ h).val.2.1 then
      modeSmallMatrix z (κ h).val.1 (κ h).val.2.1 (κ g).val.2.2 (κ h).val.2.2
    else 0

end Ising2DLambda.KacWard
