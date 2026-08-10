/-
具体版が必要十分版の特殊化として得られることの導出（`claim_qbar_matrix_pow_succ_right`）。

必要十分版 `pow_succ_right_necSuf` を次のように取る。

  M := QbarRowMatrix L        m := qbarRowMatrixProduct L
  a := A                      e := qbarIdentityMatrix L
  p := qbarMatrixPow L A

必要十分版が要求する 5 つの仮定は、具体版では次から出る。

  hzero  := rfl（冪の定義 A^0 = I）
  hsucc  := rfl（冪の定義 A^{k+1} = A A^k）
  hright := qbarMatrix_mul_qbarIdentityMatrix（A I = A）
  hleft  := qbarIdentityMatrix_mul（I A = A）
  hassoc := qbarMatrixProduct_assoc（両端が A の三つ組についてだけ使う）

すなわち、この段が要求するのは上の 5 つだけであり、値が代数的数であること（体であること・
代数閉であること）も、加法も零元も分配則も積の可換性も、添字の型の有限性も、
添字が行配位であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixPowSuccRight
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PowSuccRight

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版を必要十分版の特殊化として導いたもの。 -/
theorem qbarMatrixPow_succ_right_from_necSuf (L : ℕ) [NeZero L] (A : QbarRowMatrix L) (k : ℕ) :
    qbarMatrixPow L A (k + 1) = qbarRowMatrixProduct L (qbarMatrixPow L A k) A :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_succ_right_necSuf
    (m := qbarRowMatrixProduct L) (a := A) (e := qbarIdentityMatrix L)
    (p := qbarMatrixPow L A)
    rfl (fun _ => rfl)
    (qbarMatrix_mul_qbarIdentityMatrix L A) (qbarIdentityMatrix_mul L A)
    (fun X => (qbarMatrixProduct_assoc L A X A).symm)
    k

end Ising2DLambda.AlgebraicEigenvalue
