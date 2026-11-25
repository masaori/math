import Ising2DLambda.KacWard.ClosedNonbacktrackingWalk

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The cyclic successor of an index of an actual closed walk. -/
def closedWalkSuccessor {m : ℕ} (k : Fin (m + 1)) : Fin (m + 1) :=
  if h : k.val < m then ⟨k.val + 1, Nat.succ_lt_succ h⟩ else 0

/-- The two oriented edges forming a pass of an actual closed walk. -/
def closedWalkPass {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k : Fin (m + 1)) :
    OrientedEdge L × OrientedEdge L :=
  (γ k, γ (closedWalkSuccessor k))

/-- The lattice vertex of a pass of an actual closed walk. -/
def closedWalkPassVertex {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k : Fin (m + 1)) : Vertex L :=
  orientedTarget (γ k)

theorem closedWalkPass_valid {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k : Fin (m + 1)) :
    (closedWalkPass γ hγ k).2 ∈
      nonbacktrackingSuccessors (closedWalkPass γ hγ k).1 := by
  cases k using Fin.lastCases with
  | last =>
      simpa [closedWalkPass, closedWalkSuccessor] using hγ.2
  | cast j =>
      simpa [closedWalkPass, closedWalkSuccessor, Fin.succ] using hγ.1 j

end Ising2DLambda.KacWard
