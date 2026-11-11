import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The number of cells of a finite set incident to a grid vertex. -/
def vertexCellIncidenceCount (cells : Finset GridCell) (v : GridVertex) : ℕ :=
  (cells.filter (fun x => v ∈ verticesOfCell x)).card

/-- Vertices meeting exactly `k` selected cells. -/
def verticesWithIncidence (cells : Finset GridCell) (k : ℕ) : Finset GridVertex :=
  (cellVertices cells).filter (fun v => vertexCellIncidenceCount cells v = k)

/-- The cells incident to a lattice vertex are precisely its four quadrants. -/
theorem vertexCellIncidenceCount_quadrants (cells : Finset GridCell) (r c : ℤ) :
    vertexCellIncidenceCount cells (r, c) =
      (if (r, c) ∈ cells then 1 else 0) +
      (if (r - 1, c) ∈ cells then 1 else 0) +
      (if (r, c - 1) ∈ cells then 1 else 0) +
      (if (r - 1, c - 1) ∈ cells then 1 else 0) := by
  classical
  have hfilter :
      cells.filter (fun x => (r, c) ∈ verticesOfCell x) =
        ({(r, c), (r - 1, c), (r, c - 1), (r - 1, c - 1)} : Finset GridCell) ∩ cells := by
    ext ⟨i, j⟩
    simp only [Finset.mem_filter, Finset.mem_inter, verticesOfCell,
      Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq]
    constructor
    · rintro ⟨hmem, h⟩
      constructor
      · rcases h with h | h | h | h <;> omega
      · exact hmem
    · rintro ⟨h, hmem⟩
      constructor
      · exact hmem
      · rcases h with h | h | h | h <;> omega
  rw [vertexCellIncidenceCount, hfilter]
  have h₁ : (r, c) ≠ (r - 1, c) := by intro h; have := congrArg Prod.fst h; omega
  have h₂ : (r, c) ≠ (r, c - 1) := by intro h; have := congrArg Prod.snd h; omega
  have h₃ : (r, c) ≠ (r - 1, c - 1) := by intro h; have := congrArg Prod.fst h; omega
  have h₄ : (r - 1, c) ≠ (r, c - 1) := by intro h; have := congrArg Prod.fst h; omega
  have h₅ : (r - 1, c) ≠ (r - 1, c - 1) := by intro h; have := congrArg Prod.snd h; omega
  have h₆ : (r, c - 1) ≠ (r - 1, c - 1) := by intro h; have := congrArg Prod.fst h; omega
  rw [Finset.inter_insert]
  by_cases ha : (r, c) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c - 1) ∈ cells <;>
    by_cases hd : (r - 1, c - 1) ∈ cells <;>
    simp [ha, hb, hc, hd, h₁, h₂, h₃, h₄, h₅, h₆]

/-- A vertex meets one to three cells exactly when one of its four incident
grid edges separates selected and unselected cells. -/
theorem vertexCellIncidenceCount_boundary_criterion
    (cells : Finset GridCell) (r c : ℤ) :
    (vertexCellIncidenceCount cells (r, c) = 1 ∨
      vertexCellIncidenceCount cells (r, c) = 2 ∨
      vertexCellIncidenceCount cells (r, c) = 3) ↔
      ¬ ((r, c) ∈ cells ↔ (r - 1, c) ∈ cells) ∨
      ¬ ((r, c - 1) ∈ cells ↔ (r - 1, c - 1) ∈ cells) ∨
      ¬ ((r, c) ∈ cells ↔ (r, c - 1) ∈ cells) ∨
      ¬ ((r - 1, c) ∈ cells ↔ (r - 1, c - 1) ∈ cells) := by
  rw [vertexCellIncidenceCount_quadrants]
  by_cases ha : (r, c) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c - 1) ∈ cells <;>
    by_cases hd : (r - 1, c - 1) ∈ cells <;>
    simp [ha, hb, hc, hd]

/-- A grid vertex belongs to at most the four cells in its quadrants. -/
theorem vertexCellIncidenceCount_le_four (cells : Finset GridCell)
    (v : GridVertex) : vertexCellIncidenceCount cells v ≤ 4 := by
  classical
  rcases v with ⟨r, c⟩
  have hsubset :
      cells.filter (fun x => (r, c) ∈ verticesOfCell x) ⊆
        ({(r, c), (r - 1, c), (r, c - 1), (r - 1, c - 1)} : Finset GridCell) := by
    intro x hx
    rcases x with ⟨i, j⟩
    simp only [Finset.mem_filter] at hx
    simp only [verticesOfCell, Finset.mem_insert, Finset.mem_singleton,
      Prod.mk.injEq] at hx ⊢
    rcases hx.2 with h | h | h | h <;> omega
  have hcard :
      ({(r, c), (r - 1, c), (r, c - 1), (r - 1, c - 1)} :
        Finset GridCell).card ≤ 4 := by
    have h₁ := Finset.card_insert_le (r, c)
      ({(r - 1, c), (r, c - 1), (r - 1, c - 1)} : Finset GridCell)
    have h₂ := Finset.card_insert_le (r - 1, c)
      ({(r, c - 1), (r - 1, c - 1)} : Finset GridCell)
    have h₃ := Finset.card_insert_le (r, c - 1)
      ({(r - 1, c - 1)} : Finset GridCell)
    simp only [Finset.card_singleton] at h₃
    omega
  exact (Finset.card_le_card hsubset).trans hcard

/-- Every vertex of the cell complex meets one, two, three, or four cells. -/
theorem vertexCellIncidenceCount_one_to_four (cells : Finset GridCell)
    (v : GridVertex) (hv : v ∈ cellVertices cells) :
    vertexCellIncidenceCount cells v = 1 ∨
      vertexCellIncidenceCount cells v = 2 ∨
      vertexCellIncidenceCount cells v = 3 ∨
      vertexCellIncidenceCount cells v = 4 := by
  have hpositive : 0 < vertexCellIncidenceCount cells v := by
    obtain ⟨x, hx, hvertex⟩ := Finset.mem_biUnion.mp hv
    apply Finset.card_pos.mpr
    exact ⟨x, Finset.mem_filter.mpr ⟨hx, hvertex⟩⟩
  have hbounded := vertexCellIncidenceCount_le_four cells v
  omega

/-- Count incidences between the cells and vertices of a finite cell set in
both orders. -/
theorem cellVertexIncidence_sum (cells : Finset GridCell) :
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
      4 * cells.card := by
  classical
  calc
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
        ∑ v ∈ cellVertices cells, ∑ x ∈ cells, if v ∈ verticesOfCell x then 1 else 0 := by
          simp only [vertexCellIncidenceCount, Finset.card_filter]
    _ = ∑ x ∈ cells, ∑ v ∈ cellVertices cells, if v ∈ verticesOfCell x then 1 else 0 := by
          rw [Finset.sum_comm]
    _ = ∑ x ∈ cells, (verticesOfCell x).card := by
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.sum_subset (show verticesOfCell x ⊆ cellVertices cells by
            intro v hv
            exact Finset.mem_biUnion.mpr ⟨x, hx, hv⟩)]
          · simp
          · intro v hv hvx
            simp [hvx]
    _ = 4 * cells.card := by
          have hcard (x : GridCell) : (verticesOfCell x).card = 4 := by
            rcases x with ⟨r, c⟩
            simp [verticesOfCell]
          simp [hcard, mul_comm]

/-- Split the vertex incidence sum according to its four possible values. -/
theorem cellVertexIncidence_sum_by_class (cells : Finset GridCell) :
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
      (verticesWithIncidence cells 1).card +
      2 * (verticesWithIncidence cells 2).card +
      3 * (verticesWithIncidence cells 3).card +
      4 * (verticesWithIncidence cells 4).card := by
  classical
  let A := cellVertices cells
  let n := vertexCellIncidenceCount cells
  have hpoint (v : GridVertex) (hv : v ∈ A) :
      n v = (if n v = 1 then 1 else 0) +
        (if n v = 2 then 2 else 0) +
        (if n v = 3 then 3 else 0) +
        (if n v = 4 then 4 else 0) := by
    rcases vertexCellIncidenceCount_one_to_four cells v hv with h | h | h | h <;>
      simp [n, h]
  calc
    (∑ v ∈ A, n v) = ∑ v ∈ A,
        ((if n v = 1 then 1 else 0) + (if n v = 2 then 2 else 0) +
          (if n v = 3 then 3 else 0) + (if n v = 4 then 4 else 0)) := by
          apply Finset.sum_congr rfl
          exact hpoint
    _ = (verticesWithIncidence cells 1).card +
        2 * (verticesWithIncidence cells 2).card +
        3 * (verticesWithIncidence cells 3).card +
        4 * (verticesWithIncidence cells 4).card := by
          simp [Finset.sum_add_distrib, verticesWithIncidence, A, n,
            Finset.sum_ite, mul_comm]

end Ising2DLambda.KacWard
