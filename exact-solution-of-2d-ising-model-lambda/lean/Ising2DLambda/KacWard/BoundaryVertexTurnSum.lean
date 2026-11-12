import Ising2DLambda.KacWard.BoundaryVertexLocalTurn
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcludedOfWalk
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Sum the four-cell turn table over the boundary vertices. -/
theorem cellBoundary_turn_sum (cells : Finset GridCell)
    (hdiag : ∀ r c : ℤ,
      ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
        (r, c) ∈ cells ∧ (r, c - 1) ∉ cells) ∧
      ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
        (r, c) ∉ cells ∧ (r, c - 1) ∈ cells)) :
    (∑ v ∈ cellBoundaryVertices cells,
      directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2)) =
      (verticesWithIncidence cells 3).card -
        (verticesWithIncidence cells 1).card := by
  classical
  let B := cellBoundaryVertices cells
  let n := vertexCellIncidenceCount cells
  have hpoint (v : GridVertex) (hv : v ∈ B) :
      directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (cellBoundaryOutgoing cells v.1 v.2) =
        -(if n v = 1 then (1 : ℤ) else 0) +
          (if n v = 3 then (1 : ℤ) else 0) := by
    obtain ⟨h₁, h₂⟩ := hdiag v.1 v.2
    rw [cellBoundary_turn_by_incidence cells v.1 v.2 hv h₁ h₂]
    by_cases h : n v = 1 <;> by_cases h' : n v = 3 <;> simp_all [n]
  calc
    (∑ v ∈ B, directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2)) =
        ∑ v ∈ B, (-(if n v = 1 then (1 : ℤ) else 0) +
          (if n v = 3 then (1 : ℤ) else 0)) := by
            apply Finset.sum_congr rfl
            exact hpoint
    _ = (B.filter (fun v => n v = 3)).card -
        (B.filter (fun v => n v = 1)).card := by
          simp [Finset.sum_add_distrib, sub_eq_add_neg]
          abel
    _ = (verticesWithIncidence cells 3).card -
        (verticesWithIncidence cells 1).card := by
          have hclass (k : ℕ) (hk : k = 1 ∨ k = 3) :
              B.filter (fun v => n v = k) = verticesWithIncidence cells k := by
            ext v
            simp only [Finset.mem_filter, verticesWithIncidence, Finset.mem_filter]
            constructor
            · intro h
              have hpos : 0 < vertexCellIncidenceCount cells v := by
                rcases v with ⟨r, c⟩
                have hc := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp h.1
                omega
              obtain ⟨x, hx⟩ := Finset.card_pos.mp hpos
              exact ⟨Finset.mem_biUnion.mpr ⟨x, (Finset.mem_filter.mp hx).1,
                (Finset.mem_filter.mp hx).2⟩, h.2⟩
            · intro h
              rcases v with ⟨r, c⟩
              refine ⟨?_, h.2⟩
              apply (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mpr
              rcases hk with rfl | rfl
              · exact Or.inl h.2
              · exact Or.inr (Or.inr h.2)
          rw [hclass 3 (Or.inr rfl), hclass 1 (Or.inl rfl)]

/-- The same sum for the cells enclosed by an actual vertex-simple closed walk. -/
theorem interiorCellsOfWalk_boundary_turn_sum {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (∑ v ∈ cellBoundaryVertices cells,
      directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2)) =
      (verticesWithIncidence cells 3).card -
        (verticesWithIncidence cells 1).card := by
  classical
  dsimp only
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (∑ v ∈ cellBoundaryVertices cells,
      directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2)) =
      (verticesWithIncidence cells 3).card -
        (verticesWithIncidence cells 1).card
  apply cellBoundary_turn_sum cells
  intro r c
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
    simp only [cells, Set.Finite.mem_toFinset, oddRayInteriorCellsOfWalk, Set.mem_setOf_eq]
    exact hbit _
  have hdiag := boundaryVertex_diagonalContactExcluded_ofWalk
    γ hγ hh hv hdistinct r c
  rw [← hcell (r - 1) (c - 1), ← hcell (r - 1) c,
    ← hcell r c, ← hcell r (c - 1)] at hdiag
  constructor
  · intro h
    exact hdiag.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])
  · intro h
    exact hdiag.2.1 (by simp [h.1, h.2.1, h.2.2.1, h.2.2.2])

end Ising2DLambda.KacWard
