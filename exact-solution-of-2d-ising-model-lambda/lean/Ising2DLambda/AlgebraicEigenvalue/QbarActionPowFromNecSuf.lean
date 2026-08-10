/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := QbarRowMatrix L      V := QbarRowVector L
  mulf := qbarRowMatrixProduct L      act := qbarAction L
  e := qbarIdentityMatrix L           a := A
  p := qbarMatrixPow L A              w := qbarActionIterate L A v

必要十分版が要求する仮定は、具体版では次から出る。

  hp0 / hpsucc  := 冪の定義そのもの（`rfl`）
  hw0 / hwsucc  := 作用の反復の定義そのもの（`rfl`）
  hact_one      := `qbarIdentity_action`（単位行列の作用は列ベクトルを動かさない）
  hact_mul      := `qbarAction_product`（積の作用は作用を 2 度施したものである）

すなわち、この段が要求するのは上の 4 つだけであり、成分が代数的数であること・添字が
行配位であること・添字の型が有限であること・積の結合則や可換性は使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarActionPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarActionPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版を必要十分版の特殊化として導いたもの（`claim_qbar_action_pow`）。 -/
theorem qbarAction_pow_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (v : QbarRowVector L) (k : ℕ) :
    qbarAction L (qbarMatrixPow L A k) v = qbarActionIterate L A v k :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_pow_necSuf
    (mulf := qbarRowMatrixProduct L) (act := qbarAction L)
    (e := qbarIdentityMatrix L) (a := A) (v := v)
    (p := qbarMatrixPow L A) (w := qbarActionIterate L A v)
    rfl (fun _ => rfl) rfl (fun _ => rfl)
    (qbarIdentity_action L v)
    (fun B C u => qbarAction_product L B C u)
    k

end Ising2DLambda.AlgebraicEigenvalue
