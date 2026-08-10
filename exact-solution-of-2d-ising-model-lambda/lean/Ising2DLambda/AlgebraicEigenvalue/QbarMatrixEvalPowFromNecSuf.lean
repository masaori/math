/-
具体版が必要十分版の特殊化として得られることの導出（`claim_qbar_matrix_eval_pow`）。

必要十分版 `eval_pow_necSuf` を次のように取る。

  M := RowMatrix L            mM := rowMatrixProduct L
  N := QbarRowMatrix L        mN := qbarRowMatrixProduct L
  f := qbarMatrixEval L ξ     a  := A            e := qbarIdentityMatrix L
  p := rowMatrixPow L A       q  := qbarMatrixPow L (qbarMatrixEval L ξ A)

必要十分版が要求する 7 つの仮定は、具体版では次から出る。

  hmul    := qbarMatrixEval_product（評価が積を保つこと）
  hpzero  := rfl（ℤ[x] の冪の定義。引数 0 が指数 1 にあたる）
  hpsucc  := rfl（ℤ[x] の冪の定義。右から掛ける）
  hqzero  := rfl（Qbar の冪の定義。B^0 = I）
  hqsucc  := rfl（Qbar の冪の定義。左から掛ける）
  hright  := qbarMatrix_mul_qbarIdentityMatrix（B I = B）
  hqright := qbarMatrixPow_succ_right（冪は右から掛けても得られること）

すなわち、この段が要求するのは上の 7 つだけであり、値が代数的数であること（体であること・
代数閉であること）も、加法も零元も分配則も積の可換性も結合則も、添字の型の有限性も、
添字が行配位であることも、評価が環準同型であることも使っていない
（評価について要るのは積を保つこと 1 本だけである）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEvalPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.EvalPow

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版を必要十分版の特殊化として導いたもの。 -/
theorem qbarMatrixEval_pow_from_necSuf (L : ℕ) [NeZero L] (ξ : Qbar) (A : RowMatrix L) (k : ℕ) :
    qbarMatrixEval L ξ (rowMatrixPow L A k)
      = qbarMatrixPow L (qbarMatrixEval L ξ A) (k + 1) :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.eval_pow_necSuf
    (mM := rowMatrixProduct L) (mN := qbarRowMatrixProduct L)
    (f := qbarMatrixEval L ξ) (a := A) (e := qbarIdentityMatrix L)
    (p := rowMatrixPow L A) (q := qbarMatrixPow L (qbarMatrixEval L ξ A))
    (fun X Y => qbarMatrixEval_product L ξ X Y)
    rfl (fun _ => rfl)
    rfl (fun _ => rfl)
    (qbarMatrix_mul_qbarIdentityMatrix L (qbarMatrixEval L ξ A))
    (fun j => qbarMatrixPow_succ_right L (qbarMatrixEval L ξ A) j)
    k

end Ising2DLambda.AlgebraicEigenvalue
