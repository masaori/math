import Ising2DLambda.NecSuf.KacWard.SmoothedSuccessorMap

namespace Ising2DLambda.NecSuf.KacWard

/-- The indices strictly after `k` and at most `l`. Only the finite order is used. -/
def smoothingIndexBlockA {m : ℕ} (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  {r | k < r ∧ r ≤ l}

/-- The complementary indices. -/
def smoothingIndexBlockB {m : ℕ} (k l : Fin (m + 1)) : Set (Fin (m + 1)) :=
  (smoothingIndexBlockA k l)ᶜ

theorem smoothingIndexBlockB_membership {m : ℕ} (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexBlockB k l ↔ r ≤ k ∨ l < r := by
  change (¬ (k < r ∧ r ≤ l)) ↔ r ≤ k ∨ l < r
  omega

theorem smoothingIndexBlocks_nonempty {m : ℕ} {k l : Fin (m + 1)} (hkl : k < l) :
    l ∈ smoothingIndexBlockA k l ∧ k ∈ smoothingIndexBlockB k l := by
  constructor
  · exact ⟨hkl, le_refl l⟩
  · exact fun h => (not_lt_of_ge (le_refl k)) h.1

end Ising2DLambda.NecSuf.KacWard
