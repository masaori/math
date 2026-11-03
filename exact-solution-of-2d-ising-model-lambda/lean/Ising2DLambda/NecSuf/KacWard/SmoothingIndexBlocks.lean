import Ising2DLambda.NecSuf.KacWard.SmoothedSuccessorMap

namespace Ising2DLambda.NecSuf.KacWard

/-- The indices strictly after `k` and at most `l`. Only the finite order is used. -/
def smoothingIndexBlockA {m : ℕ} (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | k < r ∧ r ≤ l}

/-- The complementary indices inside `I_m = {1, ..., m}`. -/
def smoothingIndexBlockB {m : ℕ} (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | 0 < r ∧ r ∉ smoothingIndexBlockA k l}

theorem smoothingIndexBlockB_membership {m : ℕ} (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB k l ↔ 0 < r ∧ (r ≤ k ∨ l < r) := by
  change (0 < r ∧ ¬ (k < r ∧ r ≤ l)) ↔ _
  omega

theorem smoothingIndexBlocks_nonempty {m : ℕ} {k l : Fin (m + 1)}
    (hk : 0 < k) (hkl : k < l) :
    l ∈ smoothingIndexBlockA k l ∧ k ∈ smoothingIndexBlockB k l := by
  constructor
  · exact ⟨hkl, le_refl l⟩
  · exact ⟨hk, fun h => (not_lt_of_ge (le_refl k)) h.1⟩

end Ising2DLambda.NecSuf.KacWard
