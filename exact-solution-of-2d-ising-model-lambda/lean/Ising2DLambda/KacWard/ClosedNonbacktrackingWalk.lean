import Ising2DLambda.KacWard.TerminalMatrix

namespace Ising2DLambda.KacWard

/-- 長さ `m + 1` の向き付き辺列の隣接二辺がすべて非後退で接続する。 -/
def nonbacktrackingEdgeSequence {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) : Prop :=
  ∀ k : Fin m, γ (Fin.succ k) ∈ nonbacktrackingSuccessors (γ (Fin.castSucc k))

/-- 非後退辺列の終辺から始辺へも非後退で接続する。 -/
def closedNonbacktrackingWalk {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) : Prop :=
  nonbacktrackingEdgeSequence γ ∧
    γ 0 ∈ nonbacktrackingSuccessors (γ (Fin.last m))

end Ising2DLambda.KacWard
