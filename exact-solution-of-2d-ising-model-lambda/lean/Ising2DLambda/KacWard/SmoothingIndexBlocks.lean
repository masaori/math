import Ising2DLambda.KacWard.SmoothedSuccessorMap
import Ising2DLambda.NecSuf.KacWard.SmoothingIndexBlocks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_smoothing_index_blocks` for an actual closed nonbacktracking walk. -/
def smoothingIndexBlockA {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | k < r ∧ r ≤ l}

def smoothingIndexBlockB {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | 0 < r ∧ r ∉ smoothingIndexBlockA γ hγ k l}

theorem smoothingIndexBlockB_membership {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB γ hγ k l ↔ 0 < r ∧ (r ≤ k ∨ l < r) := by
  change (0 < r ∧ ¬ (k < r ∧ r ≤ l)) ↔ _
  omega

theorem smoothingIndexBlocks_nonempty {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    {k l : Fin (m + 1)} (hk : 0 < k) (hkl : k < l) :
    l ∈ smoothingIndexBlockA γ hγ k l ∧ k ∈ smoothingIndexBlockB γ hγ k l := by
  constructor
  · exact ⟨hkl, le_refl l⟩
  · exact ⟨hk, fun h => (not_lt_of_ge (le_refl k)) h.1⟩

theorem smoothingIndexBlockA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockA k l := rfl

theorem smoothingIndexBlockB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockB k l := rfl

end Ising2DLambda.KacWard
