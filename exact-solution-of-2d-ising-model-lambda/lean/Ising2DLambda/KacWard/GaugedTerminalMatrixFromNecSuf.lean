/- 実際の対角重みと端末行列の成分を必要十分版へ供給する。四乗根の仮定は不要。 -/
import Ising2DLambda.KacWard.GaugedTerminalMatrix
import Ising2DLambda.NecSuf.KacWard.GaugedTerminalMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 対角行列・定数埋込み・端末行列の二寄与を実際の定義から供給する。 -/
theorem gaugedTerminalMatrix_entry_from_necSuf (L : ℕ) [NeZero L] (z : Qbar)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f = qbarConst (gaugePairWeight z s e f) *
      ((if f = reversal e then 1 else 0) - Polynomial.X *
        (if orientedSource f = orientedSource e ∧ f ≠ e
          then Polynomial.C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f)
          else 0)) := by
  exact NecSuf.KacWard.gaugedMatrix_entry_necSuf
    qbarConst Polynomial.C_0 (fun _ _ => Polynomial.C_mul)
    (fun _ => zero_mul _) (fun _ => mul_zero _)
    (diagonalGauge L z s) (diagonalGaugeInverse L z s)
    (diagonalGaugeWeight z s) (diagonalGaugeInverseWeight z s)
    (fun _ _ => rfl) (fun _ _ => rfl)
    (terminalMatrix L z s) (z ^ (2 : ℕ)) e f (mul_comm _ _)
    _ (terminalMatrix_entry L z s e f)

end Ising2DLambda.KacWard
