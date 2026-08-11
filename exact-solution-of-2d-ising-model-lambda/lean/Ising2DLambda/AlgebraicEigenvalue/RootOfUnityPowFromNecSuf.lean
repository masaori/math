/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := Qbar     S := μ_n     h1 := 1 ∈ μ_n（1^n = 1 による）
  hmul := rootOfUnity_mul（μ_n が積で閉じていること）

すなわち、この段が要求するのは**モノイドであることと、S が単位元を含み積で閉じていること
だけ**である。体であることも代数閉であることも、値が代数的数であることも、
S が「n 乗して 1 になる元の全体」であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnity_pow_from_necSuf {n : ℕ} {w : Qbar} (hw : w ∈ RootOfUnity n) (k : ℕ) :
    w ^ k ∈ RootOfUnity n :=
  NecSuf.AlgebraicEigenvalue.pow_mem_necSuf (M := Qbar) (RootOfUnity n)
    (by rw [mem_rootOfUnity]; exact one_pow n)
    (fun _ _ ha hb => rootOfUnity_mul ha hb) hw k

end Ising2DLambda.AlgebraicEigenvalue
