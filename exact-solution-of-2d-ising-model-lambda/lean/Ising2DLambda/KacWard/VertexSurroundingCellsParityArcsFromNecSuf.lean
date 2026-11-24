/-
具体版が必要十分版の特殊化として得られることの導出。

四つのセルの交差数の偶奇と、接する四辺の通過回数を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
import Ising2DLambda.NecSuf.KacWard.VertexSurroundingCellsParityArcs

namespace Ising2DLambda.KacWard

/-- 具体版の四セルの偶奇弧の条件は、必要十分版の同名の条件と一致する。 -/
theorem fourCellsFormParityArcs_eq_necSuf :
    FourCellsFormParityArcs = Ising2DLambda.NecSuf.KacWard.FourCellsFormParityArcs := rfl

/-- `claim_vertex_surrounding_cells_form_parity_arcs` を必要十分版から導く。 -/
theorem vertexSurroundingCells_formParityArcs_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : ℕ) (hj : j < m + 1) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    Ising2DLambda.NecSuf.KacWard.FourCellsFormParityArcs
      (rightRayCrossingCount (m + 1) row col (row j - 1) (col j - 1) % 2)
      (rightRayCrossingCount (m + 1) row col (row j - 1) (col j) % 2)
      (rightRayCrossingCount (m + 1) row col (row j) (col j) % 2)
      (rightRayCrossingCount (m + 1) row col (row j) (col j - 1) % 2) := by
  rw [← fourCellsFormParityArcs_eq_necSuf]
  exact vertexSurroundingCells_formParityArcs γ hγ hh hv hdistinct j hj

end Ising2DLambda.KacWard
