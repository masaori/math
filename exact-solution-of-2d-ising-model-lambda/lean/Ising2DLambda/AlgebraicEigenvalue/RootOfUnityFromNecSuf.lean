/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.pow_eq_one_of_dvd_necSuf`）は、モノイド `M` の元 `z` が
`z ^ d = 1` を満たし `d ∣ n` ならば `z ^ n = 1` であることを言う。
具体版は `M := Qbar`（ℚ の代数閉包。乗法モノイドとしてだけ使う）と取り、
`μ_d ⊆ μ_n` を要素の条件へ開いたものである。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である（`M := Qbar`）。 -/
theorem rootOfUnity_of_dvd_from_necSuf {d n : ℕ} (hd : d ∣ n) :
    RootOfUnity d ⊆ RootOfUnity n := by
  intro z hz
  rw [mem_rootOfUnity] at hz
  rw [mem_rootOfUnity]
  exact NecSuf.AlgebraicEigenvalue.pow_eq_one_of_dvd_necSuf hd hz

end Ising2DLambda.AlgebraicEigenvalue
