import Ising2DLambda.FisherZero.QuadraticInverse
import Ising2DLambda.NecSuf.FisherZero.QuadraticInverse

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有理数の包含と二次体の表示へ特殊化する。 -/
theorem quadraticInverse_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : Qbar) (hxi : xi ∈ quadraticFieldSet s) (hnonzero : xi ≠ 0) :
    xi⁻¹ ∈ quadraticFieldSet s := by
  exact Ising2DLambda.NecSuf.FisherZero.inverse_mem_necSuf
    (algebraMap ℚ Qbar) s hs
    (fun a b h => oneSLinearlyIndependent s hs a b h)
    xi hxi hnonzero

end Ising2DLambda.FisherZero
