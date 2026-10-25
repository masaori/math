import Ising2DLambda.NecSuf.KacWard.LocalPairingChoiceCount

namespace Ising2DLambda.NecSuf.KacWard

def localChoiceFamilies {V : Type*} [Fintype V] [DecidableEq V]
    (S : V → Finset (Fin 4)) : Finset (V → Fin 4 → Fin 4) :=
  Fintype.piFinset (fun v => localPairingChoices (S v))

theorem localChoiceFamilies_mem_iff {V : Type*} [Fintype V] [DecidableEq V]
    (S : V → Finset (Fin 4)) (κ : V → Fin 4 → Fin 4) :
    κ ∈ localChoiceFamilies S ↔ ∀ v : V, κ v ∈ localPairingChoices (S v) := by
  classical
  exact Fintype.mem_piFinset

theorem localChoiceFamilies_card {V : Type*} [Fintype V] [DecidableEq V]
    (S : V → Finset (Fin 4)) :
    (localChoiceFamilies S).card = ∏ v : V, (localPairingChoices (S v)).card := by
  classical
  exact Fintype.card_piFinset _

end Ising2DLambda.NecSuf.KacWard
