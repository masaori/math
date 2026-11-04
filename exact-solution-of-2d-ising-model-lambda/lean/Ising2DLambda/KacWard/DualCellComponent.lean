import Ising2DLambda.KacWard.CellSetBoundaryCoefficients

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- A dual step crosses an edge absent from the walk. -/
def dualCellStep (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
  (p q : ZMod L × ZMod L) : Prop :=
  (∃ i j : ZMod L,
      (∀ k : Fin (m + 1), (γ k).1 ≠ edgeOfRow L false i j) ∧
      ((p = (i, j) ∧ q = (i - 1, j)) ∨
       (p = (i - 1, j) ∧ q = (i, j)))) ∨
  (∃ i j : ZMod L,
      (∀ k : Fin (m + 1), (γ k).1 ≠ edgeOfRow L true i j) ∧
      ((p = (i, j - 1) ∧ q = (i, j)) ∨
       (p = (i, j) ∧ q = (i, j - 1))))

/-- The cells reachable from a chosen cell by dual steps avoiding the walk. -/
noncomputable def dualCellComponent (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root : ZMod L × ZMod L) : Finset (ZMod L × ZMod L) := by
  classical
  exact Finset.univ.filter (Relation.ReflTransGen (dualCellStep L m γ) root)

theorem root_mem_dualCellComponent (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root : ZMod L × ZMod L) :
    root ∈ dualCellComponent L m γ root := by
  classical
  simp only [dualCellComponent, Finset.mem_filter, Finset.mem_univ, true_and]
  exact Relation.ReflTransGen.refl

theorem dualCellComponent_closed (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root p q : ZMod L × ZMod L)
    (hp : p ∈ dualCellComponent L m γ root)
    (hstep : dualCellStep L m γ p q) :
    q ∈ dualCellComponent L m γ root := by
  classical
  simp only [dualCellComponent, Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
  exact Relation.ReflTransGen.tail hp hstep

theorem dualCellComponent_proper_of_unreachable (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root outside : ZMod L × ZMod L)
    (houtside : ¬ Relation.ReflTransGen (dualCellStep L m γ) root outside) :
    dualCellComponent L m γ root ≠ Finset.univ := by
  classical
  intro hfull
  have hin : outside ∈ dualCellComponent L m γ root := by rw [hfull]; simp
  exact houtside (by simpa [dualCellComponent] using hin)

theorem dualCellComponent_boundary_blocks_step (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root p q : ZMod L × ZMod L)
    (hp : p ∈ dualCellComponent L m γ root)
    (hq : q ∉ dualCellComponent L m γ root) :
    ¬ dualCellStep L m γ p q := by
  intro hstep
  exact hq (dualCellComponent_closed L m γ root p q hp hstep)

end Ising2DLambda.KacWard
