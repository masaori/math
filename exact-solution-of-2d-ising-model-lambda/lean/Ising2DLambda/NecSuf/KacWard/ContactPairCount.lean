import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- The number of pairs of passages through the same target vertex. -/
noncomputable def contactPairCount {E V : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ target (γ p.1) = target (γ p.2)).card

/-- A finite passage sequence has no contact pair exactly when its target map is injective. -/
theorem contactPairCount_eq_zero_iff_injective {E V : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (target : E → V) :
    contactPairCount γ target = 0 ↔ Function.Injective (target ∘ γ) := by
  classical
  constructor
  · intro h i j heq
    change target (γ i) = target (γ j) at heq
    have hempty : ((Finset.univ ×ˢ Finset.univ).filter
        fun p : Fin (m + 1) × Fin (m + 1) =>
          p.1 < p.2 ∧ target (γ p.1) = target (γ p.2)) = ∅ := by
      exact Finset.card_eq_zero.mp h
    rcases lt_trichotomy i j with hij | hij | hij
    · have hmem : (i, j) ∈ ((Finset.univ ×ˢ Finset.univ).filter
          fun p : Fin (m + 1) × Fin (m + 1) =>
            p.1 < p.2 ∧ target (γ p.1) = target (γ p.2)) := by
        simp [hij, heq]
      rw [hempty] at hmem
      simp at hmem
    · exact hij
    · have hmem : (j, i) ∈ ((Finset.univ ×ˢ Finset.univ).filter
          fun p : Fin (m + 1) × Fin (m + 1) =>
            p.1 < p.2 ∧ target (γ p.1) = target (γ p.2)) := by
        simp [hij, heq.symm]
      rw [hempty] at hmem
      simp at hmem
  · intro hinj
    apply Finset.card_eq_zero.mpr
    ext p
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
      true_and]
    constructor
    · intro hp
      exact False.elim ((ne_of_lt hp.1) (hinj hp.2))
    · intro hp
      simp at hp

end Ising2DLambda.NecSuf.KacWard
