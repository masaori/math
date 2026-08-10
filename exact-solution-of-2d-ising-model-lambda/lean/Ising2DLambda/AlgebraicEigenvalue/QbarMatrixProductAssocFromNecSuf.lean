/-
具体版が必要十分版の特殊化として得られることの導出。

**この主張のために新しい必要十分版は書いていない。** 必要十分版として要るものは既にある
`Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_product_necSuf`
（主張「行列の積の作用は、作用を 2 度施したものである」の必要十分版）そのものであり、
新しい仮定を一つも要求しない。列ベクトルの側を `v := fun τ'' => C τ'' τ'''`
（`C` の 1 列）と取れば、行列 3 つについての結合則の成分の等式になる。
一行で終わる別名を新しい必要十分版として立てないための扱いである
（`docs/context/証明の書き方.md`「mathlib の高抽象度の既製定理へ丸投げしない」と同じ理由で、
自前の言明を 2 つに増やさず、1 つの言明の 2 つの特殊化であることを見せる）。

  ι := RowConfig L（行配位の全体）      M := Qbar
  A, B := 行列の成分                     v := C の第 τ''' 列

すなわちこの段が要求するのは、**添字の型が有限であることと、値の側が非単位的半環である
ことだけ**であり、値が代数的数であることも、添字が行配位であることも使っていない。
とくに**積の可換性を使っていない**（`Qbar` は可換だが、必要十分版は要求しない）。
SageMath 側でも、成分を非可換環（2 次上三角行列）に取って結合則が成り立つことを確かめてある。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixProductAssoc
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarMatrixProduct_assoc_from_necSuf (L : ℕ) [NeZero L]
    (A B C : QbarRowMatrix L) :
    qbarRowMatrixProduct L (qbarRowMatrixProduct L A B) C
      = qbarRowMatrixProduct L A (qbarRowMatrixProduct L B C) := by
  funext τ τ'''
  exact
    NecSuf.AlgebraicEigenvalue.action_product_necSuf
      (ι := RowConfig L) (M := Qbar) A B (fun τ'' => C τ'' τ''') τ

end Ising2DLambda.AlgebraicEigenvalue
