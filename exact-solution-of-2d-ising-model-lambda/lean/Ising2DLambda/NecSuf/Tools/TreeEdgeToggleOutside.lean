import Mathlib.Data.Finset.SymmDiff

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

/-- Restriction to a set disjoint from the toggled edge is invariant. -/
theorem toggle_preserves_outside {α : Type*} [DecidableEq α]
    (A E F : Finset α) (e : α) (he : e ∈ F) :
    (A ∆ {e}) ∩ (E \ F) = A ∩ (E \ F) := by
  ext x
  by_cases hx : x = e
  · subst x
    simp [he]
  · simp [Finset.mem_symmDiff, hx]

/-- Restriction to the complement is invariant under any finite list of toggles inside it. -/
theorem toggles_preserve_outside {α : Type*} [DecidableEq α]
    (A E F : Finset α) (es : List α) (hes : ∀ e ∈ es, e ∈ F) :
    (es.foldl (fun B e => B ∆ {e}) A) ∩ (E \ F) = A ∩ (E \ F) := by
  induction es generalizing A with
  | nil => simp
  | cons e es ih =>
    have he : e ∈ F := hes e (by simp)
    have hrest : ∀ x ∈ es, x ∈ F := by
      intro x hx
      exact hes x (by simp [hx])
    simp only [List.foldl_cons]
    rw [ih (A := A ∆ {e}) hrest, toggle_preserves_outside A E F e he]

end Ising2DLambda.NecSuf.Tools
