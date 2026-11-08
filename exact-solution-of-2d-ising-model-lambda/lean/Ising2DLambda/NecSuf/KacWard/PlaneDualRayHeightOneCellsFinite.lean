import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A binary height with finite row and column support has finite height-one support. -/
theorem binaryHeight_one_cells_finite (height : ℤ → ℤ → ZMod 2)
    (rows cols : Finset ℤ)
    (hrows : ∀ r c : ℤ, height r c = 1 → r ∈ rows)
    (hcols : ∀ r c : ℤ, height r c = 1 → c ∈ cols) :
    ∃ cells : Finset (ℤ × ℤ), ∀ r c : ℤ,
      (r, c) ∈ cells ↔ height r c = 1 := by
  refine ⟨(rows.product cols).filter (fun p => height p.1 p.2 = 1), ?_⟩
  intro r c
  constructor
  · intro h
    exact (Finset.mem_filter.mp h).2
  · intro h
    exact Finset.mem_filter.mpr
      ⟨Finset.mem_product.mpr ⟨hrows r c h, hcols r c h⟩, h⟩

end Ising2DLambda.NecSuf.KacWard
