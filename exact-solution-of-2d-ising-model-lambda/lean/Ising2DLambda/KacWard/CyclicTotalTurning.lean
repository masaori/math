import Ising2DLambda.KacWard.EdgeSequenceTotalTurning

namespace Ising2DLambda.KacWard

/-- `def_cyclic_total_turning`。実際の閉じた非後退辺列について定義する。 -/
def cyclicTotalTurning {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) : ℤ :=
  edgeSequenceTotalTurning γ + stepTurning (γ (Fin.last m)) (γ 0)

theorem cyclicTotalTurning_eq {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    cyclicTotalTurning γ hγ =
      edgeSequenceTotalTurning γ + stepTurning (γ (Fin.last m)) (γ 0) := rfl

end Ising2DLambda.KacWard
