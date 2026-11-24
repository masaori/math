/-
具体版が必要十分版の特殊化として得られることの導出。

閉じた非後退辺列・零巻き付き・持ち上げ点の相異性を具体版へ渡す。
-/
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcluded
import Ising2DLambda.NecSuf.KacWard.BoundaryVertexDiagonalContactExcluded

namespace Ising2DLambda.KacWard

/-- 具体版の対角二セルの除外の条件は、必要十分版の同名の条件と一致する。 -/
theorem diagonalCellPairsExcluded_eq_necSuf :
    DiagonalCellPairsExcluded = Ising2DLambda.NecSuf.KacWard.DiagonalCellPairsExcluded := rfl

/-- `claim_boundary_vertex_diagonal_contact_excluded` を必要十分版から導く。 -/
theorem boundaryVertex_diagonalContactExcluded_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (a b : ℤ) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    Ising2DLambda.NecSuf.KacWard.DiagonalCellPairsExcluded
      (rightRayCrossingCount (m + 1) row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount (m + 1) row col (a - 1) b % 2)
      (rightRayCrossingCount (m + 1) row col a b % 2)
      (rightRayCrossingCount (m + 1) row col a (b - 1) % 2) := by
  rw [← diagonalCellPairsExcluded_eq_necSuf]
  exact boundaryVertex_diagonalContactExcluded γ hγ hh hv hdistinct a b

end Ising2DLambda.KacWard
