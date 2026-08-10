/-
具体版が必要十分版の特殊化として得られることの導出（`claim_qbar_identity_matrix_unit`）。

左から掛ける側は、**既にある**必要十分版 `identity_action_necSuf`
（`claim_qbar_identity_action` の必要十分版）を次のように取ったものである。

  ι := RowConfig L   M := Qbar   v := fun τ' => A τ' τ''

すなわち、列ベクトルを `A` の第 τ'' 列と取れば、単位行列の作用についての言明が
そのまま `I^Qbar_L A = A` の成分ごとの等式になる。新しい必要十分版を書き起こしていないのは、
一行で終わる別名を必要十分版として立てない方針（`docs/context/証明の書き方.md`）による。

右から掛ける側は別の必要十分版 `identity_action_right_necSuf` を取ったものである。
左の版から得ることはできない。あちらの仮定は `1 * a = a` と `0 * a = 0` であり、
積の可換性を仮定しない以上、こちらの `a * 1 = a` と `a * 0 = 0` は別の仮定だからである。

必要十分版が要求する構造は、具体版では次から出る。

  Fintype ι       := 行配位の全体が有限であること
  DecidableEq ι   := 行配位の相等が判定できること
  hone / hzero    := Qbar の単位元との積・零元との積（`one_mul` / `zero_mul`、
                     右からは `mul_one` / `mul_zero`）
  AddCommMonoid M := Qbar の加法

すなわち、この段が要求するのは上の 4 つだけであり、値が代数的数であること（体であること・
代数閉であること）も、積の可換性・結合則・分配則も、添字が行配位であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityMatrixUnit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarIdentityAction
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarIdentityActionRight

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 左から掛ける側を必要十分版の特殊化として導いたもの。 -/
theorem qbarIdentityMatrix_mul_from_necSuf (L : ℕ) [NeZero L] (A : QbarRowMatrix L) :
    qbarRowMatrixProduct L (qbarIdentityMatrix L) A = A := by
  funext τ τ''
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_necSuf
    (ι := RowConfig L) (M := Qbar) (fun a => one_mul a) (fun a => zero_mul a)
    (fun τ' => A τ' τ'') τ

/-- 右から掛ける側を必要十分版の特殊化として導いたもの。 -/
theorem qbarMatrix_mul_qbarIdentityMatrix_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) :
    qbarRowMatrixProduct L A (qbarIdentityMatrix L) = A := by
  funext τ τ''
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_right_necSuf
    (ι := RowConfig L) (M := Qbar) (fun a => mul_one a) (fun a => mul_zero a)
    (fun τ' => A τ τ') τ''

end Ising2DLambda.AlgebraicEigenvalue
