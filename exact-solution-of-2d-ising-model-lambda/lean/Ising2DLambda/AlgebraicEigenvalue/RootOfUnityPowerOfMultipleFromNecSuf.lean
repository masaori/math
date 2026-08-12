/-
具体版が必要十分版の特殊化として得られることの導出。

具体版では `M := Qbar` とし、冪の法則を `pow_mul`、根の条件を `mem_rootOfUnity`、
単位元の冪を `one_pow` から供給する。ここで `Qbar` の加法・体・代数閉性は使わない。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerOfMultiple
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerOfMultiple

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnityPowerOfMultiple_from_necSuf {n m : ℕ} (_hn : 1 ≤ n) {w : Qbar}
    (hw : w ∈ RootOfUnity n) (hdiv : n ∣ m) : w ^ m = 1 := by
  obtain ⟨k, rfl⟩ := hdiv
  have hroot : w ^ n = 1 := by
    rw [mem_rootOfUnity] at hw
    exact hw
  exact NecSuf.AlgebraicEigenvalue.power_multiple_eq_one_necSuf
    (pow_mul w n k) hroot (one_pow k)

end Ising2DLambda.AlgebraicEigenvalue
