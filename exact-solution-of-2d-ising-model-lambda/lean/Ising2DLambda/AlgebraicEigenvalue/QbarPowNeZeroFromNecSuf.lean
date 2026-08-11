/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarPowNeZero_from_necSuf (w : Qbar) (hw : w ≠ 0) : ∀ n : ℕ, w ^ n ≠ 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_ne_zero_necSuf
    (· * ·) (· ^ ·) 0
    (fun _ => by simpa only [pow_zero] using (one_ne_zero : (1 : Qbar) ≠ 0))
    (fun z k => pow_succ z k)
    (fun a b ha hab => qbarNoZeroDivisors ha hab)
    w hw

end Ising2DLambda.AlgebraicEigenvalue
