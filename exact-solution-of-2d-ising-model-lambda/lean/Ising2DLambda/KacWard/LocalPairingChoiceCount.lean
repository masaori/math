import Mathlib

namespace Ising2DLambda.KacWard

/-- The four ports at a vertex are indexed by `Fin 4`.  An unused port is
fixed, while selected ports are exchanged in pairs. -/
def localPairingChoices (S : Finset (Fin 4)) : Finset (Fin 4 → Fin 4) :=
  Finset.univ.filter fun κ =>
    (∀ i, i ∉ S → κ i = i) ∧
    (∀ i, i ∈ S → κ i ∈ S ∧ κ i ≠ i) ∧
    (∀ i, κ (κ i) = i)

/-- The local choices are one, one, and three at degrees zero, two, and four. -/
theorem localPairingChoices_card (S : Finset (Fin 4))
    (hcard : S.card = 0 ∨ S.card = 2 ∨ S.card = 4) :
    (S.card = 4 → (localPairingChoices S).card = 3) ∧
    (S.card ≠ 4 → (localPairingChoices S).card = 1) := by
  revert S hcard
  decide

end Ising2DLambda.KacWard
