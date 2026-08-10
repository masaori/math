/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := 代数的数を成分とする行列   V := 列ベクトル   S := Qbar
  act := 作用   smul := スカラー倍   mul := 行列の積   sum := 列ベクトルの有限和
  pow := A の冪   c := (k ↦ z^{L-k})   s := {0,1,…,L-1}

すなわち、この段が要求するのは 4 つの等式（作用が有限和を保つこと・作用がスカラー倍を
保つこと・作用が積と両立すること・冪の一歩の式）だけである。値が代数的数であることも、
添字が行配位であることも、係数が冪の形であることも、`A^L = I` も `z^L = 1` も使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProjector
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarProjector

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarProjector_action_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L) :
    qbarAction L A (qbarProjector L A z v)
      = qbarVectorSum L (range L)
          (fun k => qbarVectorSmul L (z ^ (L - k))
            (qbarAction L (qbarMatrixPow L A (k + 1)) v)) :=
  NecSuf.AlgebraicEigenvalue.projector_action_necSuf
    (act := qbarAction L) (smul := qbarVectorSmul L)
    (mul := qbarRowMatrixProduct L) (sum := qbarVectorSum L)
    (A := A) (pow := qbarMatrixPow L A) (v := v)
    (c := fun k => z ^ (L - k)) (s := range L)
    (fun f => qbarAction_sum L A (range L) f)
    (fun a w => qbarAction_smul L A a w)
    (fun B C w => qbarAction_product L B C w)
    (fun _ => rfl)

end Ising2DLambda.AlgebraicEigenvalue
