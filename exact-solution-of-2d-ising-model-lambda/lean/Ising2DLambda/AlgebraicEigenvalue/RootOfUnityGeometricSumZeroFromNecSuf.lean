/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  R := Qbar（体なので当然に環である）
  z := z        n := n        inv := (z - 1)⁻¹
  hinv := inv_mul_cancel₀ hz1（hz1 は具体版の準備の段 z - 1 ≠ 0。
                              ここでだけ `z ≠ 1` と体であることを使う）
  hz := mem_rootOfUnity.mp hz

すなわち、この段が要求するのは**環であることと、`z - 1` が左逆元を持つこと**だけである。
体であることも、代数閉であることも、積が可換であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityGeometricSumZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityGeometricSumZero

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnityGeometricSumZero_from_necSuf {n : ℕ} {z : Qbar}
    (hz : z ∈ RootOfUnity n) (hne : z ≠ 1) : qbarGeomSum z n = 0 := by
  have hz1 : z - 1 ≠ 0 := by
    intro h
    apply hne
    calc z = (z - 1) + 1 := by rw [sub_add_cancel]
      _ = 0 + 1 := by rw [h]
      _ = 1 := zero_add 1
  exact NecSuf.AlgebraicEigenvalue.geometric_sum_zero_necSuf (R := Qbar)
    (inv_mul_cancel₀ hz1) (mem_rootOfUnity.mp hz)

end Ising2DLambda.AlgebraicEigenvalue
