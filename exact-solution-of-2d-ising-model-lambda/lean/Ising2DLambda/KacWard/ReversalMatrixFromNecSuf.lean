/- 対合の行列に関する必要十分版を、向き付き辺の反転と整数成分へ特殊化する。 -/
import Ising2DLambda.KacWard.ReversalMatrix
import Ising2DLambda.NecSuf.KacWard.ReversalMatrix

namespace Ising2DLambda.KacWard

theorem reversalMatrix_mul_self_from_necSuf (L : ℕ) :
    IntegerMatrix.product (reversalMatrix L) (reversalMatrix L) =
      IntegerMatrix.identity (OrientedEdge L) := by
  change
    NecSuf.KacWard.involutionMatrix (R := ℤ) (@reversal L) *
      NecSuf.KacWard.involutionMatrix (@reversal L) = 1
  exact NecSuf.KacWard.involutionMatrix_mul_self_necSuf (@reversal L)
    reversal_involutive (fun r => zero_mul r) (fun r => one_mul r)

end Ising2DLambda.KacWard
