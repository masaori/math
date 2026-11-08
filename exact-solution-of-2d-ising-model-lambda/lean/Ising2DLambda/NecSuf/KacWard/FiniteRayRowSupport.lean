import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite ray sum has no contribution outside its selected rows. -/
theorem finiteRay_zero_of_row_absent {α : Type*} [DecidableEq α]
    (edges : Finset α) (row : α → ℤ) (selected : α → Bool) (r : ℤ)
    (weight : α → ZMod 2)
    (hrow : ∀ e ∈ edges, selected e = true → row e ≠ r) :
    (∑ e ∈ edges, if selected e = true ∧ row e = r then weight e else 0) = 0 := by
  apply Finset.sum_eq_zero
  intro e he
  by_cases hs : selected e = true
  · simp [hs, (hrow e he hs)]
  · simp [hs]

/-- Every nonzero ray sum has a row represented by the finite selected family. -/
theorem finiteRay_row_support {α : Type*} [DecidableEq α]
    (edges : Finset α) (row : α → ℤ) (selected : α → Bool) (r : ℤ)
    (weight : α → ZMod 2)
    (hheight : (∑ e ∈ edges,
      if selected e = true ∧ row e = r then weight e else 0) ≠ 0) :
    r ∈ edges.image row := by
  by_contra hrow
  have habsent : ∀ e ∈ edges, selected e = true → row e ≠ r := by
    intro e he _ hs
    exact hrow (Finset.mem_image.mpr ⟨e, he, hs⟩)
  exact hheight (finiteRay_zero_of_row_absent edges row selected r weight habsent)

end Ising2DLambda.NecSuf.KacWard
