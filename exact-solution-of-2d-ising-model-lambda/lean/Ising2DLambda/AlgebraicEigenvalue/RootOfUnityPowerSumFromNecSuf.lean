/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  ι := ↥μ_n（有限性の仮定 `[Fintype (RootOfUnity n)]` がそのまま `Fintype ι` になる）
  R := Qbar        f z := z^m        c := w^m
  e := mulMap hw（w を掛ける操作）    he := mulMap_bijective hn hw
  hcompat := qbarMul_pow から出る w^m z^m = (w z)^m

すなわち、この段が要求するのは**有限和が定まること、積が有限和へ分配されること、
掛ける操作が全単射であること、そしてそれが和の各項と両立することだけ**である。
体であることも代数閉であることも、値が代数的数であることも、
μ_n が「n 乗して 1 になる元の全体」であることも、指数 `m` の中身も使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerSum

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 具体版は必要十分版の特殊化である。 -/
theorem powerSum_mul_invariant_from_necSuf {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)]
    {w : Qbar} (hw : w ∈ RootOfUnity n) (m : ℕ) :
    w ^ m * powerSum n m = powerSum n m :=
  NecSuf.AlgebraicEigenvalue.sum_mul_invariant_necSuf
    (ι := RootOfUnity n) (R := Qbar)
    (fun z => (z.1) ^ m) (w ^ m) (mulMap hw) (mulMap_bijective hn hw)
    (fun z => (qbarMul_pow w z.1 m).symm)

end Ising2DLambda.AlgebraicEigenvalue
