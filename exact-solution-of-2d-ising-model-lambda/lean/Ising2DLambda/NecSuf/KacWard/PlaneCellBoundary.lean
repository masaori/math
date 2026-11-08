import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Finiteness and the integer row order suffice to find an exposed upper side. -/
theorem finite_cells_have_exposed_upper_side (cells : Finset (ℤ × ℤ))
    (hcells : cells.Nonempty) :
    ∃ r c, (r, c) ∈ cells ∧ (r + 1, c) ∉ cells := by
  let rows : Finset ℤ := cells.image Prod.fst
  have hrows : rows.Nonempty := hcells.image _
  let r : ℤ := rows.max' hrows
  have hr : r ∈ rows := Finset.max'_mem rows hrows
  obtain ⟨⟨s, c⟩, hcell, hs⟩ := Finset.mem_image.mp hr
  have hsr : s = r := by simpa [r] using hs
  subst s
  refine ⟨r, c, hcell, ?_⟩
  intro habove
  have hle : r + 1 ≤ r :=
    Finset.le_max' rows (r + 1)
      (Finset.mem_image.mpr ⟨(r + 1, c), habove, rfl⟩)
  omega

end Ising2DLambda.NecSuf.KacWard
