/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  κ := RowConfig L（行配位の全体）   ι := 有限和の添字の型   M := Qbar
  A := 行列の成分                     v := 列ベクトルの族の成分

すなわち、この段が要求するのは**作用の側の添字の型が有限であることと、値の側が
非単位的・非結合的半環であることだけ**である。値が代数的数であることも、添字が行配位で
あることも、有限和の添字の型が有限であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarActionSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarAction_sum_from_necSuf {ι : Type*} (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (s : Finset ι) (v : ι → QbarRowVector L) :
    qbarAction L A (qbarVectorSum L s v)
      = qbarVectorSum L s (fun i => qbarAction L A (v i)) := by
  funext τ
  exact
    NecSuf.AlgebraicEigenvalue.action_sum_necSuf
      (ι := ι) (κ := RowConfig L) (M := Qbar) A s v τ

end Ising2DLambda.AlgebraicEigenvalue
