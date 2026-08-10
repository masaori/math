/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  ι := RowConfig L（行配位の全体）      M := Qbar
  A, B := 行列の成分                     v := 列ベクトルの成分

すなわちこの段が要求するのは、**添字の型が有限であることと、値の側が非単位的半環である
ことだけ**であり、値が代数的数であることも、添字が行配位であることも使っていない。
とくに**積の可換性を使っていない**（`Qbar` は可換だが、必要十分版は要求しない）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarAction
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarAction_product_from_necSuf (L : ℕ) [NeZero L]
    (A B : QbarRowMatrix L) (v : QbarRowVector L) :
    qbarAction L (qbarRowMatrixProduct L A B) v = qbarAction L A (qbarAction L B v) := by
  funext τ
  exact
    NecSuf.AlgebraicEigenvalue.action_product_necSuf
      (ι := RowConfig L) (M := Qbar) A B v τ

end Ising2DLambda.AlgebraicEigenvalue
