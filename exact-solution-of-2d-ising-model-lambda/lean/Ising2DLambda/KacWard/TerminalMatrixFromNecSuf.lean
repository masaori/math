/- 実際の向き付き辺・後続辺・ねじれ・回転位相から、端末行列の必要十分版へ特殊化する。 -/
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.NecSuf.KacWard.TerminalMatrix

namespace Ising2DLambda.KacWard

open Finset Polynomial Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- 実際の行列の定義と端点・対合性を供給する導出版。 -/
theorem terminalMatrix_entry_from_necSuf (L : ℕ) [NeZero L] (z : Qbar) (s : SpinStructure)
    (e f : OrientedEdge L) :
    terminalMatrix L z s e f =
      (if f = reversal e then 1 else 0) - X *
        (if orientedSource f = orientedSource e ∧ f ≠ e
          then C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) := by
  let weight : OrientedEdge L → OrientedEdge L → QbarPoly :=
    fun g f => C ((twistSign s f : Qbar) * rotationPhase z g f)
  have hJ : polynomialReversalMatrix L =
      NecSuf.KacWard.involutionMatrix (R := QbarPoly) (@reversal L) := by
    apply Matrix.ext
    intro g f
    by_cases h : f = reversal g <;>
      simp [polynomialReversalMatrix, reversalMatrix, NecSuf.KacWard.involutionMatrix, h]
  have hK : spinKacWardPolynomialMatrix L z s =
      NecSuf.KacWard.successorKernel (@reversal L) orientedSource orientedTarget weight X := by
    apply Matrix.ext
    intro g f
    simp only [spinKacWardPolynomialMatrix, kacWardPolynomialMatrix, Matrix.sub_apply,
      Matrix.one_apply, Matrix.smul_apply, Matrix.map_apply, smul_eq_mul,
      kacWardTransitionMatrix, nonbacktrackingSuccessors, mem_filter, mem_univ, true_and,
      NecSuf.KacWard.successorKernel, weight]
    rw [apply_ite C, C_0]
  calc
    terminalMatrix L z s e f =
        NecSuf.KacWard.terminalMatrix (@reversal L) orientedSource orientedTarget weight X e f := by
      rw [terminalMatrix, hJ, hK]
      rfl
    _ = _ := NecSuf.KacWard.terminalMatrix_entry_necSuf (@reversal L)
      reversal_involutive orientedSource orientedTarget orientedTarget_reversal
      weight X (fun r => zero_mul r) (fun r => one_mul r) e f

end Ising2DLambda.KacWard
