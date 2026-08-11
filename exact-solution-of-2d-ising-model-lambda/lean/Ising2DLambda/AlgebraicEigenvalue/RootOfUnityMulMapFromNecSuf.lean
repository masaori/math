/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := Qbar        S := μ_n        hmul := rootOfUnity_mul（μ_n が積で閉じていること）
  w := w           v := w^{n-1}    hv := rootOfUnity_pow hw (n-1)
  hvw := powPred_mul hn hw（w^{n-1} w = 1）
  hwv := 可換則で hvw を裏返したもの（w w^{n-1} = 1）

すなわち、この段が要求するのは**モノイドであることと、S が積で閉じていること、
そして S の中に両側の逆元を持つ元であることだけ**である。体であることも代数閉であることも、
値が代数的数であることも、S が「n 乗して 1 になる元の全体」であることも、
`v` が `w` の冪であることも使っていない。可換則は `hwv` を作るためだけに使う。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMulMap
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityMulMap

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem mulMap_bijective_from_necSuf {n : ℕ} (hn : 1 ≤ n) {w : Qbar}
    (hw : w ∈ RootOfUnity n) : Function.Bijective (mulMap hw) :=
  NecSuf.AlgebraicEigenvalue.mulMap_bijective_necSuf (M := Qbar) (RootOfUnity n)
    (fun _ _ ha hb => rootOfUnity_mul ha hb) hw (rootOfUnity_pow hw (n - 1))
    (powPred_mul hn hw)
    (by rw [mul_comm w (w ^ (n - 1))]; exact powPred_mul hn hw)

end Ising2DLambda.AlgebraicEigenvalue
