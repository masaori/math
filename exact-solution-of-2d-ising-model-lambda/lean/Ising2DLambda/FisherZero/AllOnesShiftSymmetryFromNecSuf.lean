/- 必要十分版を `Qbar` 係数の対称多項式へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.AllOnesShiftSymmetry
import Ising2DLambda.NecSuf.FisherZero.AllOnesShiftSymmetry

namespace Ising2DLambda.FisherZero

/-- `claim_qbar_all_ones_shift_preserves_symmetry` を必要十分版から得る。
`K = Qbar`、`σ = Fin n`、`e = ϱ`。置換・指数 `1_n`・`sd_n` は具体版と同じ式で定めてある。 -/
theorem allOnesShift_isQbarSymmetric_from_necSuf {n : ℕ} (P : QbarMvPoly n)
    (hsym : IsQbarSymmetric P) : IsQbarSymmetric (allOnesShift P) := fun ϱ =>
  Ising2DLambda.NecSuf.FisherZero.allOnesShift_equivInvariant_necSuf ϱ P (hsym ϱ)

end Ising2DLambda.FisherZero
