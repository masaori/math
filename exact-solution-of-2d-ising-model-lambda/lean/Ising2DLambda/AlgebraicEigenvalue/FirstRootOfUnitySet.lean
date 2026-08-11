/-
「1 乗して 1 になる代数的数は 1 だけである」の具体版。
人手証明と同じく、集合の等号を両包含で示し、各向きで 1 乗の値を一段ずつ確かめる。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `μ_1` は `1` だけからなる集合である。 -/
theorem firstRootOfUnitySet : RootOfUnity 1 = {1} := by
  ext w
  constructor
  · intro hw
    rw [Set.mem_singleton_iff]
    calc
      w = w ^ 1 := by rw [pow_one]
      _ = 1 := hw
  · intro hw
    rw [Set.mem_singleton_iff] at hw
    rw [mem_rootOfUnity]
    calc
      w ^ 1 = (1 : Qbar) ^ 1 := by rw [hw]
      _ = 1 := by rw [one_pow]

end Ising2DLambda.AlgebraicEigenvalue
