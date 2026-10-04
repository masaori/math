/- 必要十分版へ実際の辺集合と二方向反転を渡して具体的な行列式を得る。 -/
import Ising2DLambda.KacWard.ReversalMatrixDeterminant
import Ising2DLambda.NecSuf.KacWard.ReversalMatrixDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- 辺集合の濃度は `2L²`、必要十分版の反転は既存の反転そのものである。 -/
theorem reversalMatrix_determinant_from_necSuf (L : ℕ) :
    IntegerMatrix.determinant (reversalMatrix L) = 1 := by
  letI : LinearOrder (Edge L × Bool) := orientedEdgeLinearOrder L
  have hcard : Even (Fintype.card (Edge L)) := by
    refine ⟨L ^ 2, ?_⟩
    calc
      Fintype.card (Edge L) = 2 * L ^ 2 := card_edge L
      _ = L ^ 2 + L ^ 2 := two_mul _
  have hmatrix : reversalMatrix L = NecSuf.KacWard.pairedReversalMatrix (Edge L) := by
    apply Matrix.ext
    intro e f
    rfl
  calc
    IntegerMatrix.determinant (reversalMatrix L) =
        IntegerMatrix.determinant (NecSuf.KacWard.pairedReversalMatrix (Edge L)) := by
      exact congrArg IntegerMatrix.determinant hmatrix
    _ = 1 := NecSuf.KacWard.pairedReversalMatrix_determinant_of_even (Edge L) hcard

end Ising2DLambda.KacWard
