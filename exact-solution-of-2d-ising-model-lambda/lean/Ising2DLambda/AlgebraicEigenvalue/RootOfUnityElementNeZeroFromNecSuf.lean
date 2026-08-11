/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityElementNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootOfUnityElementNeZero_from_necSuf (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) : w ≠ 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.root_of_unity_element_ne_zero_necSuf
    (· * ·) (· ^ ·) 1 0
    (fun z k => pow_succ z k)
    (fun a => mul_zero a)
    one_ne_zero
    n hn w ((mem_rootOfUnity).1 hw)

end Ising2DLambda.AlgebraicEigenvalue
