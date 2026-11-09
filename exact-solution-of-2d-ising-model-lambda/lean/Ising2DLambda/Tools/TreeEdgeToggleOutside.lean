import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Data.Finset.SymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

/-- Toggling a tree edge leaves the selected non-tree edges unchanged. -/
theorem treeEdge_toggle_outside (n : ℕ) (A E F : Finset (Sym2 (Fin n)))
    (e : Sym2 (Fin n)) (he : e ∈ F) :
    (A ∆ {e}) ∩ (E \ F) = A ∩ (E \ F) := by
  classical
  ext x
  by_cases hx : x = e
  · subst x
    simp [he]
  · simp [Finset.mem_symmDiff, hx]

/-- A finite sequence of tree-edge choices preserves the non-tree restriction. -/
theorem treeEdge_toggles_outside (n : ℕ) (A E F : Finset (Sym2 (Fin n)))
    (es : List (Sym2 (Fin n))) (hes : ∀ e ∈ es, e ∈ F) :
    (es.foldl (fun B e => B ∆ {e}) A) ∩ (E \ F) = A ∩ (E \ F) := by
  induction es generalizing A with
  | nil => simp
  | cons e es ih =>
    have he : e ∈ F := hes e (by simp)
    have hrest : ∀ x ∈ es, x ∈ F := by
      intro x hx
      exact hes x (by simp [hx])
    simp only [List.foldl_cons]
    rw [ih (A := A ∆ {e}) hrest, treeEdge_toggle_outside n A E F e he]

end Ising2DLambda.Tools
