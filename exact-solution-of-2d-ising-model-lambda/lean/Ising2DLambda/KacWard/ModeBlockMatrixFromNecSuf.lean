import Ising2DLambda.KacWard.ModeBlockMatrix
import Ising2DLambda.NecSuf.KacWard.ModeBlockMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem modeBlockMatrix_from_necSuf {L : ℕ} (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    modeBlockMatrix z s κ =
      Ising2DLambda.NecSuf.KacWard.modeBlockMatrix κ
        (fun m => (m.val.1, m.val.2.1)) (fun m => m.val.2.2)
        (fun p => modeSmallMatrix z p.1 p.2) := by
  classical
  ext g h
  simp only [modeBlockMatrix, Ising2DLambda.NecSuf.KacWard.modeBlockMatrix,
    Prod.mk.injEq]

end Ising2DLambda.KacWard
