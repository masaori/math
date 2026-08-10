/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  ι := RowConfig L（行配位の全体。有限で相等が判定できる）   M := Qbar

必要十分版が要求する構造は、具体版では次から出る。

  Fintype ι      := 行配位の全体が有限であること
  DecidableEq ι  := 行配位の相等が判定できること
  hone           := Qbar の単位元との積（`one_mul`）
  hzero          := Qbar の零元との積（`zero_mul`）
  AddCommMonoid M := Qbar の加法

すなわち、この段が要求するのは上の 4 つだけであり、値が代数的数であること（体であること・
代数閉であること）も、積の可換性・結合則・分配則も、添字が行配位であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityAction
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarIdentityAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版を必要十分版の特殊化として導いたもの（`claim_qbar_identity_action`）。 -/
theorem qbarIdentity_action_from_necSuf (L : ℕ) [NeZero L] (v : QbarRowVector L) :
    qbarAction L (qbarIdentityMatrix L) v = v := by
  funext τ
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_necSuf
    (ι := RowConfig L) (M := Qbar) (fun a => one_mul a) (fun a => zero_mul a) v τ

end Ising2DLambda.AlgebraicEigenvalue
