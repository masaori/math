/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  ι := 有限和の添字の型   M := Qbar
  z := スカラー             v := 列ベクトルの族の、固定した点 τ における成分

すなわち、この段が要求するのは**値の側が非単位的・非結合的半環であることだけ**である。
値が代数的数であることも、添字が行配位であることも、点の型が有限であることも、
有限和の添字の型が有限であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarSmulSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarSmulSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarSmul_sum_from_necSuf {ι : Type*} (L : ℕ) [NeZero L]
    (z : Qbar) (s : Finset ι) (v : ι → QbarRowVector L) :
    qbarVectorSmul L z (qbarVectorSum L s v)
      = qbarVectorSum L s (fun i => qbarVectorSmul L z (v i)) := by
  funext τ
  exact
    NecSuf.AlgebraicEigenvalue.smul_sum_necSuf
      (ι := ι) (M := Qbar) z s (fun i => v i τ)

end Ising2DLambda.AlgebraicEigenvalue
