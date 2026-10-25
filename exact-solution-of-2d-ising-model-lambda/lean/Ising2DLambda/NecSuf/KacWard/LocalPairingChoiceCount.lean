import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A four-element set has no geometric structure.  Outside the selected set
the mate is fixed; inside it the mate is a fixed-point-free involution. -/
def localPairingChoices (S : Finset (Fin 4)) : Finset (Fin 4 → Fin 4) :=
  Finset.univ.filter fun mate =>
    (∀ i, i ∉ S → mate i = i) ∧
    (∀ i, i ∈ S → mate i ∈ S ∧ mate i ≠ i) ∧
    (∀ i, mate (mate i) = i)

theorem localPairingChoices_card (S : Finset (Fin 4))
    (hcard : S.card = 0 ∨ S.card = 2 ∨ S.card = 4) :
    (S.card = 4 → (localPairingChoices S).card = 3) ∧
    (S.card ≠ 4 → (localPairingChoices S).card = 1) := by
  revert S hcard
  decide

end Ising2DLambda.NecSuf.KacWard
