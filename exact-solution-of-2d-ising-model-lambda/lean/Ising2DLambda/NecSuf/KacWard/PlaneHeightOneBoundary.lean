import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Finite support and a binary jump law identify the selected edges with a cell boundary. -/
theorem binaryHeight_boundary {Cell Edge : Type*} [DecidableEq Cell] [DecidableEq Edge]
    (allEdges selected : Finset Edge) (cells : Finset Cell)
    (side₀ side₁ : Edge → Cell) (height : Cell → Bool)
    (hselected : selected ⊆ allEdges)
    (hcell : ∀ x, x ∈ cells ↔ height x = true)
    (hjump : ∀ e ∈ allEdges, e ∈ selected ↔ height (side₀ e) ≠ height (side₁ e)) :
    allEdges.filter (fun e =>
      ((side₀ e ∈ cells ∧ side₁ e ∉ cells) ∨
        (side₀ e ∉ cells ∧ side₁ e ∈ cells))) = selected := by
  ext e
  by_cases he : e ∈ allEdges
  · simp only [Finset.mem_filter, he, true_and]
    rw [hcell (side₀ e), hcell (side₁ e)]
    have hx : ((height (side₀ e) = true ∧ height (side₁ e) ≠ true) ∨
        (height (side₀ e) ≠ true ∧ height (side₁ e) = true)) ↔
        height (side₀ e) ≠ height (side₁ e) := by
      cases height (side₀ e) <;> cases height (side₁ e) <;> simp
    exact hx.trans (hjump e he).symm
  · have hn : e ∉ selected := fun hs => he (hselected hs)
    simp only [Finset.mem_filter, he, false_and, hn, iff_self]

end Ising2DLambda.NecSuf.KacWard
