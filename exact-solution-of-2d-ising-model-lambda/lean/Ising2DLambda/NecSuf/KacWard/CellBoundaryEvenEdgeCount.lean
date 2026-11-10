import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A bijection from subsets of a finite set counts the admissible finite edge sets. -/
theorem boundary_even_edge_count
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (ambient : Finset α) (admissible : Finset β → Prop)
    (boundary : ∀ _ : {T : Finset α // T ⊆ ambient},
      {E : Finset β // admissible E})
    (hbij : Function.Bijective boundary) :
    Nat.card {E : Finset β // admissible E} = 2 ^ ambient.card := by
  classical
  letI : Fintype {T : Finset α // T ∈ ambient.powerset} :=
    ambient.powerset.finite_toSet.fintype
  letI : Fintype {T : Finset α // T ⊆ ambient} :=
    Fintype.ofEquiv {T : Finset α // T ∈ ambient.powerset}
      (Equiv.subtypeEquiv (Equiv.refl _) (fun T => Finset.mem_powerset))
  letI : Fintype {E : Finset β // admissible E} :=
    Fintype.ofEquiv _ (Equiv.ofBijective boundary hbij)
  have hcard := Fintype.card_congr (Equiv.ofBijective boundary hbij)
  rw [Nat.card_eq_fintype_card, ← hcard]
  calc
    Fintype.card {T : Finset α // T ⊆ ambient} = ambient.powerset.card := by
      simpa [Finset.mem_powerset] using (Fintype.card_coe ambient.powerset)
    _ = 2 ^ ambient.card := Finset.card_powerset ambient

end Ising2DLambda.NecSuf.KacWard
