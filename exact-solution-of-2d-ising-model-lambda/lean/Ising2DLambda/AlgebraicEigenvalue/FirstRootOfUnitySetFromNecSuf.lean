/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.FirstRootOfUnitySet
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FirstRootOfUnitySet

namespace Ising2DLambda.AlgebraicEigenvalue

theorem firstRootOfUnitySet_from_necSuf : RootOfUnity 1 = {1} := by
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.singleton_of_mem_iff_eq_necSuf
  intro w
  constructor
  · intro hw
    calc
      w = w ^ 1 := by rw [pow_one]
      _ = 1 := hw
  · intro hw
    rw [mem_rootOfUnity]
    calc
      w ^ 1 = (1 : Qbar) ^ 1 := by rw [hw]
      _ = 1 := by rw [one_pow]

end Ising2DLambda.AlgebraicEigenvalue
