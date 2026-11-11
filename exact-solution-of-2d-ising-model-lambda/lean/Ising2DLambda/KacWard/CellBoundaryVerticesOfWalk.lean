import Ising2DLambda.KacWard.CellBoundaryVertices
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcludedOfWalk
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Each boundary vertex of the actual simple closed walk's interior cells
meets precisely two boundary edges. -/
theorem interiorCellsOfWalk_boundaryVertex_two_incident_edges
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (r c : ℤ)
    (hvertex : (r, c) ∈ cellBoundaryVertices
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (if (false, (r, c)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (false, (r, c - 1)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (true, (r, c)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (true, (r - 1, c)) ∈ planeCellBoundary cells then 1 else 0) = 2 := by
  dsimp only
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (r, c) ∈ cellBoundaryVertices cells at hvertex
  change (if (false, (r, c)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (false, (r, c - 1)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (true, (r, c)) ∈ planeCellBoundary cells then 1 else 0) +
      (if (true, (r - 1, c)) ∈ planeCellBoundary cells then 1 else 0) = 2
  have hbit (n : ℕ) : (if Odd n then (1 : ℕ) else 0) = n % 2 := by
    by_cases h : Odd n
    · simp [h, Nat.odd_iff.mp h]
    · have hzero : n % 2 = 0 := by
        have hlt := Nat.mod_lt n (by omega : 0 < 2)
        have hone : n % 2 ≠ 1 := fun he => h (Nat.odd_iff.mpr he)
        omega
      simp [h, hzero]
  have hcell (a b : ℤ) :
      (if (a, b) ∈ cells then (1 : ℕ) else 0) =
        rightRayVerticalCrossingCount γ hγ a b % 2 := by
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk,
      Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct r c
  rw [← hcell (r - 1) (c - 1), ← hcell (r - 1) c,
    ← hcell r c, ← hcell r (c - 1)] at hdiag
  have hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells) := by
    intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  have hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells) := by
    intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  exact cellBoundaryVertices_two_incident_edges cells r c hvertex hdiag₁ hdiag₂

end Ising2DLambda.KacWard
