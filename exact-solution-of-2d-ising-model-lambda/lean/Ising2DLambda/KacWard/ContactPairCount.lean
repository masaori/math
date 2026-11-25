import Ising2DLambda.KacWard.ClosedWalkCrossingNumber

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_contact_pair_count` for an actual closed nonbacktracking walk. -/
noncomputable def contactPairCount {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)).card

/-- Zero contact count for an actual closed walk means that all passage vertices differ. -/
theorem contactPairCount_eq_zero_iff_pass_vertices_injective {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    contactPairCount γ hγ = 0 ↔ Function.Injective (orientedTarget ∘ γ) := by
  classical
  constructor
  · intro h i j heq
    change orientedTarget (γ i) = orientedTarget (γ j) at heq
    have hempty : ((Finset.univ ×ˢ Finset.univ).filter
        fun p : Fin (m + 1) × Fin (m + 1) =>
          p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)) = ∅ := by
      exact Finset.card_eq_zero.mp h
    rcases lt_trichotomy i j with hij | hij | hij
    · have hmem : (i, j) ∈ ((Finset.univ ×ˢ Finset.univ).filter
          fun p : Fin (m + 1) × Fin (m + 1) =>
            p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)) := by
        simp [hij, heq]
      rw [hempty] at hmem
      simp at hmem
    · exact hij
    · have hmem : (j, i) ∈ ((Finset.univ ×ˢ Finset.univ).filter
          fun p : Fin (m + 1) × Fin (m + 1) =>
            p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)) := by
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

end Ising2DLambda.KacWard
