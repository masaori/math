/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := QbarRowMatrix L（行列の全体）   V := QbarRowVector L   S := Qbar
  act := 作用 A·(-)                     mul := 行列の積        smul := ⊙

必要十分版が要求する仮定は、具体版では次から出る。

  hact_mul  := qbarAction_product（行列の積の作用は作用を 2 度施したものであること）
  hact_smul := qbarAction_smul（作用がスカラー倍を保つこと）
  hcomm     := そのまま仮定として渡す

すなわち、この段が要求するのは上の 2 本の等式と可換性の仮定だけであり、
行列の積の結合則も単位元も分配則も、値が代数的数であることも、
添字の型が有限であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarCommutingEigenspace
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.CommutingEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarCommuting_preserves_eigenspace_from_necSuf (L : ℕ) [NeZero L]
    (A B : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (hcomm : qbarRowMatrixProduct L A B = qbarRowMatrixProduct L B A)
    (hv : v ∈ qbarEigenspace L A z) :
    qbarAction L B v ∈ qbarEigenspace L A z :=
  NecSuf.AlgebraicEigenvalue.commuting_preserves_eigenspace_necSuf
    (M := QbarRowMatrix L) (V := QbarRowVector L) (S := Qbar)
    (qbarAction L) (qbarRowMatrixProduct L) (qbarVectorSmul L)
    (fun A B v => qbarAction_product L A B v)
    (fun B c v => qbarAction_smul L B c v)
    A B hcomm z v hv

end Ising2DLambda.AlgebraicEigenvalue
