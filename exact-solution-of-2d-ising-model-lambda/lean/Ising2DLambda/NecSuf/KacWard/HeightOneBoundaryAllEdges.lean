import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four local cases suffice for a property on the two orientations of a finite grid. -/
theorem four_edge_classes_cover {I J : Type*} [DecidableEq I] [DecidableEq J]
    (i₀ : I) (j₀ : J)
    (P Q : (I × J) ⊕ (I × J) → Prop)
    (hh0 : ∀ j, P (Sum.inl (i₀, j)) ↔ Q (Sum.inl (i₀, j)))
    (hh : ∀ i j, i ≠ i₀ → (P (Sum.inl (i, j)) ↔ Q (Sum.inl (i, j))))
    (hv0 : ∀ i, P (Sum.inr (i, j₀)) ↔ Q (Sum.inr (i, j₀)))
    (hv : ∀ i j, j ≠ j₀ → (P (Sum.inr (i, j)) ↔ Q (Sum.inr (i, j)))) :
    ∀ w, P w ↔ Q w := by
  intro w
  cases w with
  | inl p =>
    rcases p with ⟨i, j⟩
    by_cases hi : i = i₀
    · subst i; exact hh0 j
    · exact hh i j hi
  | inr p =>
    rcases p with ⟨i, j⟩
    by_cases hj : j = j₀
    · subst j; exact hv0 i
    · exact hv i j hj

end Ising2DLambda.NecSuf.KacWard
