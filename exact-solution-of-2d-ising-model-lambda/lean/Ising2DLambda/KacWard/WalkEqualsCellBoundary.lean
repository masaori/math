import Ising2DLambda.KacWard.CellBoundaryWinding

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The coefficient of an unoriented edge in an oriented edge occurrence. -/
def orientedEdgeCoefficient {L : ℕ} (edge : Edge L) (e : OrientedEdge L) : ℤ :=
  if e.1 = edge then 1 - 2 * (e.2.toNat : ℤ) else 0

/-- The signed coefficient of an edge in an actual finite walk. -/
def walkEdgeCoefficient {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (edge : Edge L) : ℤ :=
  ∑ k : Fin (m + 1), orientedEdgeCoefficient edge (γ k)

/-- The signed coefficient of an edge in a finite cell boundary. -/
def cellSetEdgeCoefficient (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (edge : Edge L) : ℤ :=
  ∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map (orientedEdgeCoefficient edge)).sum

private theorem orientedWeight_sum (L : ℕ) (e : OrientedEdge L)
    (weight : Edge L → ℤ) :
    (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 =
      ∑ edge : Edge L, orientedEdgeCoefficient edge e * weight edge := by
  classical
  simp [orientedEdgeCoefficient]

private theorem listWeight_sum (L : ℕ) (edges : List (OrientedEdge L))
    (weight : Edge L → ℤ) :
    (edges.map fun e => (1 - 2 * (e.2.toNat : ℤ)) * weight e.1).sum =
      ∑ edge : Edge L,
        ((edges.map (orientedEdgeCoefficient edge)).sum) * weight edge := by
  classical
  induction edges with
  | nil => simp
  | cons e tail ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [ih, orientedWeight_sum L e weight, ← Finset.sum_add_distrib]
      congr 1
      funext edge
      simp [add_mul]

private theorem walkWeight_sum {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (weight : Edge L → ℤ) :
    (∑ k : Fin (m + 1), (1 - 2 * ((γ k).2.toNat : ℤ)) * weight (γ k).1) =
      ∑ edge : Edge L, walkEdgeCoefficient γ edge * weight edge := by
  classical
  calc
    _ = ∑ k : Fin (m + 1), ∑ edge : Edge L,
          orientedEdgeCoefficient edge (γ k) * weight edge := by
            apply Finset.sum_congr rfl
            intro k _
            exact orientedWeight_sum L (γ k) weight
    _ = ∑ edge : Edge L, ∑ k : Fin (m + 1),
          orientedEdgeCoefficient edge (γ k) * weight edge := Finset.sum_comm
    _ = _ := by simp [walkEdgeCoefficient, Finset.sum_mul]

private theorem cellSetWeight_sum (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (weight : Edge L → ℤ) :
    cellSetBoundaryEvaluation L S
      (fun e => (1 - 2 * (e.2.toNat : ℤ)) * weight e.1) =
      ∑ edge : Edge L, cellSetEdgeCoefficient L S edge * weight edge := by
  classical
  simp only [cellSetBoundaryEvaluation]
  calc
    _ = ∑ p ∈ S, ∑ edge : Edge L,
          ((cellBoundaryEdges L p.1 p.2).map
            (orientedEdgeCoefficient edge)).sum * weight edge := by
            apply Finset.sum_congr rfl
            intro p hp
            exact listWeight_sum L (cellBoundaryEdges L p.1 p.2) weight
    _ = ∑ edge : Edge L, ∑ p ∈ S,
          ((cellBoundaryEdges L p.1 p.2).map
            (orientedEdgeCoefficient edge)).sum * weight edge := Finset.sum_comm
    _ = _ := by simp [cellSetEdgeCoefficient, Finset.sum_mul]

theorem walk_boundary_winding_zero (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (S : Finset (ZMod L × ZMod L))
    (_hclosed : closedNonbacktrackingWalk γ)
    (hcoeff : ∀ edge : Edge L, walkEdgeCoefficient γ edge =
      cellSetEdgeCoefficient L S edge) :
    horizontalDirectedWindingNumber γ = 0 ∧
      verticalDirectedWindingNumber γ = 0 := by
  constructor
  · let weight : Edge L → ℤ := fun edge => (horizontalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = horizontalSeamContribution e := by
      simp [weight, horizontalSeamContribution, horizontalSeamParity, mul_comm]
    calc
      horizontalDirectedWindingNumber γ
          = ∑ k : Fin (m + 1),
              (1 - 2 * ((γ k).2.toNat : ℤ)) * weight (γ k).1 := by
                change ∑ k : Fin (m + 1), horizontalSeamContribution (γ k) = _
                apply Finset.sum_congr rfl
                intro k _
                exact (hw (γ k)).symm
      _ = ∑ edge : Edge L, walkEdgeCoefficient γ edge * weight edge :=
            walkWeight_sum γ weight
      _ = ∑ edge : Edge L, cellSetEdgeCoefficient L S edge * weight edge := by
            apply Finset.sum_congr rfl
            intro edge _
            rw [hcoeff edge]
      _ = cellSetBoundaryEvaluation L S horizontalSeamContribution := by
            rw [← cellSetWeight_sum L S weight]
            congr 1
            funext e
            exact hw e
      _ = 0 := cellSetBoundary_horizontalSeam_sum_zero L S
  · let weight : Edge L → ℤ := fun edge => (verticalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = verticalSeamContribution e := by
      simp [weight, verticalSeamContribution, verticalSeamParity, mul_comm]
    calc
      verticalDirectedWindingNumber γ
          = ∑ k : Fin (m + 1),
              (1 - 2 * ((γ k).2.toNat : ℤ)) * weight (γ k).1 := by
                change ∑ k : Fin (m + 1), verticalSeamContribution (γ k) = _
                apply Finset.sum_congr rfl
                intro k _
                exact (hw (γ k)).symm
      _ = ∑ edge : Edge L, walkEdgeCoefficient γ edge * weight edge :=
            walkWeight_sum γ weight
      _ = ∑ edge : Edge L, cellSetEdgeCoefficient L S edge * weight edge := by
            apply Finset.sum_congr rfl
            intro edge _
            rw [hcoeff edge]
      _ = cellSetBoundaryEvaluation L S verticalSeamContribution := by
            rw [← cellSetWeight_sum L S weight]
            congr 1
            funext e
            exact hw e
      _ = 0 := cellSetBoundary_verticalSeam_sum_zero L S

theorem walk_signed_boundary_winding_zero (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (S : Finset (ZMod L × ZMod L))
    (ε : ℤ) (hε : ε ∈ ({-1, 1} : Finset ℤ))
    (hcoeff : ∀ edge : Edge L,
      cellSetEdgeCoefficient L S edge = ε * walkEdgeCoefficient γ edge) :
    horizontalDirectedWindingNumber γ = 0 ∧
      verticalDirectedWindingNumber γ = 0 := by
  have hε0 : ε ≠ 0 := by
    simp only [Finset.mem_insert, Finset.mem_singleton] at hε
    rcases hε with h | h <;> simp [h]
  constructor
  · let weight : Edge L → ℤ := fun edge => (horizontalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = horizontalSeamContribution e := by
      simp [weight, horizontalSeamContribution, horizontalSeamParity, mul_comm]
    have hsum : ε * horizontalDirectedWindingNumber γ = 0 := by
      calc
        ε * horizontalDirectedWindingNumber γ
            = ε * (∑ edge : Edge L, walkEdgeCoefficient γ edge * weight edge) := by
                rw [← walkWeight_sum γ weight]
                change ε * (∑ k : Fin (m + 1), horizontalSeamContribution (γ k)) = _
                congr 1
                apply Finset.sum_congr rfl
                intro k _
                exact (hw (γ k)).symm
        _ = ∑ edge : Edge L, cellSetEdgeCoefficient L S edge * weight edge := by
              rw [Finset.mul_sum]
              apply Finset.sum_congr rfl
              intro edge _
              rw [hcoeff edge]
              ring
        _ = cellSetBoundaryEvaluation L S horizontalSeamContribution := by
              rw [← cellSetWeight_sum L S weight]
              congr 1
              funext e
              exact hw e
        _ = 0 := cellSetBoundary_horizontalSeam_sum_zero L S
    exact (mul_eq_zero.mp hsum).resolve_left hε0
  · let weight : Edge L → ℤ := fun edge => (verticalSeamParity (edge, false) : ℤ)
    have hw (e : OrientedEdge L) :
        (1 - 2 * (e.2.toNat : ℤ)) * weight e.1 = verticalSeamContribution e := by
      simp [weight, verticalSeamContribution, verticalSeamParity, mul_comm]
    have hsum : ε * verticalDirectedWindingNumber γ = 0 := by
      calc
        ε * verticalDirectedWindingNumber γ
            = ε * (∑ edge : Edge L, walkEdgeCoefficient γ edge * weight edge) := by
                rw [← walkWeight_sum γ weight]
                change ε * (∑ k : Fin (m + 1), verticalSeamContribution (γ k)) = _
                congr 1
                apply Finset.sum_congr rfl
                intro k _
                exact (hw (γ k)).symm
        _ = ∑ edge : Edge L, cellSetEdgeCoefficient L S edge * weight edge := by
              rw [Finset.mul_sum]
              apply Finset.sum_congr rfl
              intro edge _
              rw [hcoeff edge]
              ring
        _ = cellSetBoundaryEvaluation L S verticalSeamContribution := by
              rw [← cellSetWeight_sum L S weight]
              congr 1
              funext e
              exact hw e
        _ = 0 := cellSetBoundary_verticalSeam_sum_zero L S
    exact (mul_eq_zero.mp hsum).resolve_left hε0

end Ising2DLambda.KacWard
