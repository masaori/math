/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  V := QbarRowVector L（列ベクトルの全体）   S := Qbar
  act := A の作用 A·(-)                       add := ⊕      smul := ⊙

必要十分版が要求する 2 本ずつの仮定は、具体版では次から出る。

  hact_add   := qbarAction_add（作用が和を保つこと）
  hsmul_add  := 値の側の分配則（`mul_add`）を各成分で当てたもの
  hact_smul  := qbarAction_smul（作用がスカラー倍を保つこと）
  hsmul_comm := 値の側の積の結合則と可換性を各成分で当てたもの

すなわち、固有空間が和で閉じることが要求するのは**作用が和を保つことと、スカラー倍が
和へ配ることだけ**であり、スカラー倍で閉じることだけが**2 つのスカラー倍の交換**を
追加で要求する。値が代数的数であることも、添字が行配位であることも、
そもそも値の型に代数構造があることさえ使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 必要十分版の仮定 `hsmul_add` にあたる事実。スカラー倍は和へ配る。
成分ごとに値の側の分配則を当てるだけである。 -/
theorem qbarVectorSmul_add (L : ℕ) (z : Qbar) (v w : QbarRowVector L) :
    qbarVectorSmul L z (qbarVectorAdd L v w)
      = qbarVectorAdd L (qbarVectorSmul L z v) (qbarVectorSmul L z w) := by
  funext τ
  exact mul_add z (v τ) (w τ)

/-- 必要十分版の仮定 `hsmul_comm` にあたる事実。2 つのスカラー倍は交換できる。
成分ごとに積の結合則と可換性を当てるだけである。 -/
theorem qbarVectorSmul_comm (L : ℕ) (c z : Qbar) (v : QbarRowVector L) :
    qbarVectorSmul L c (qbarVectorSmul L z v)
      = qbarVectorSmul L z (qbarVectorSmul L c v) := by
  funext τ
  calc c * (z * v τ)
      = (c * z) * v τ := (mul_assoc _ _ _).symm
    _ = (z * c) * v τ := by rw [mul_comm c z]
    _ = z * (c * v τ) := mul_assoc _ _ _

/-- 具体版（和で閉じること）は必要十分版の特殊化である。 -/
theorem qbarEigenspace_add_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v w : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L A z) (hw : w ∈ qbarEigenspace L A z) :
    qbarVectorAdd L v w ∈ qbarEigenspace L A z :=
  NecSuf.AlgebraicEigenvalue.eigenspace_add_necSuf
    (V := QbarRowVector L) (S := Qbar)
    (qbarAction L A) (qbarVectorAdd L) (qbarVectorSmul L)
    (fun v w => qbarAction_add L A v w)
    (fun z v w => qbarVectorSmul_add L z v w)
    z v w hv hw

/-- 具体版（スカラー倍で閉じること）は必要十分版の特殊化である。 -/
theorem qbarEigenspace_smul_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z c : Qbar) (v : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L A z) :
    qbarVectorSmul L c v ∈ qbarEigenspace L A z :=
  NecSuf.AlgebraicEigenvalue.eigenspace_smul_necSuf
    (V := QbarRowVector L) (S := Qbar)
    (qbarAction L A) (qbarVectorSmul L)
    (fun c v => qbarAction_smul L A c v)
    (fun c z v => qbarVectorSmul_comm L c z v)
    z c v hv

end Ising2DLambda.AlgebraicEigenvalue
