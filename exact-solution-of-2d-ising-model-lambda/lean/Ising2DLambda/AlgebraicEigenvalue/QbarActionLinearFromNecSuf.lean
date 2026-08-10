/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  ι := RowConfig L（行配位の全体）      M := Qbar
  A := 行列の成分                        v, w := 列ベクトルの成分      z := 代数的数

すなわち、和を保つことが要求するのは**添字の型が有限であることと、値の側が
非単位的・非結合的半環であることだけ**であり、スカラー倍を保つことだけが**積の可換性**を
追加で要求する。値が代数的数であることも、添字が行配位であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionLinear
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarActionLinear

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版（和）は必要十分版の特殊化である。 -/
theorem qbarAction_add_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (v w : QbarRowVector L) :
    qbarAction L A (qbarVectorAdd L v w)
      = qbarVectorAdd L (qbarAction L A v) (qbarAction L A w) := by
  funext τ
  exact
    NecSuf.AlgebraicEigenvalue.action_add_necSuf
      (ι := RowConfig L) (M := Qbar) A v w τ

/-- 具体版（スカラー倍）は必要十分版の特殊化である。 -/
theorem qbarAction_smul_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) :
    qbarAction L A (qbarVectorSmul L z v)
      = qbarVectorSmul L z (qbarAction L A v) := by
  funext τ
  exact
    NecSuf.AlgebraicEigenvalue.action_smul_necSuf
      (ι := RowConfig L) (M := Qbar) A z v τ

end Ising2DLambda.AlgebraicEigenvalue
