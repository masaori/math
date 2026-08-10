/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := QbarRowMatrix L      V := QbarRowVector L      K := Qbar
  mulf := qbarRowMatrixProduct L      mulK := (· * ·)      act := qbarAction L
  smul := qbarVectorSmul L
  e := qbarIdentityMatrix L           a := A           one := 1           z := z
  p := qbarMatrixPow L A              q := fun k => z ^ k

必要十分版が要求する仮定は、具体版では次から出る。

  hp0 / hpsucc  := 冪の定義そのもの（`rfl`）
  hq0 / hqsucc  := `pow_zero` / `pow_succ`（`z^k` の約束そのもの）
  hact_one      := `qbarIdentity_action`
  hsmul_one     := `qbarVectorSmul_one`（準備の第 1 の等式）
  hact_mul      := `qbarAction_product`
  hact_smul     := `qbarAction_smul`（作用がスカラー倍を保つこと）
  heigen        := 仮定 `A·v = z⊙v`
  hsmul_mul     := `qbarVectorSmul_mul`（準備の第 2 の等式）

すなわち、この段が要求するのは上の 8 つだけであり、成分が代数的数であること・
添字が行配位であること・添字の型が有限であること・`v` が零ベクトルでないことは
使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenvectorPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarEigenvectorPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版を必要十分版の特殊化として導いたもの（`claim_qbar_eigenvector_pow`）。 -/
theorem qbarAction_pow_smul_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (h : qbarAction L A v = qbarVectorSmul L z v) (k : ℕ) :
    qbarAction L (qbarMatrixPow L A k) v = qbarVectorSmul L (z ^ k) v :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_pow_smul_necSuf
    (mulf := qbarRowMatrixProduct L) (mulK := fun y y' => y * y')
    (act := qbarAction L) (smul := qbarVectorSmul L)
    (e := qbarIdentityMatrix L) (a := A) (one := 1) (z := z) (v := v)
    (p := qbarMatrixPow L A) (q := fun k => z ^ k)
    rfl (fun _ => rfl) (pow_zero z) (fun k => pow_succ z k)
    (qbarIdentity_action L v)
    (qbarVectorSmul_one L v)
    (fun B C u => qbarAction_product L B C u)
    (fun y => qbarAction_smul L A y v)
    h
    (fun y y' => qbarVectorSmul_mul L y y' v)
    k

end Ising2DLambda.AlgebraicEigenvalue
