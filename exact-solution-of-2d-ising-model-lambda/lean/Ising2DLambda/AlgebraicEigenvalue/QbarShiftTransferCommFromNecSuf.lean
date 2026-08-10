/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  A := RowMatrix L（Z[x] の行列の全体）   B := QbarRowMatrix L（Qbar の行列の全体）
  f := Ev_ξ                                mulA := Z[x] の行列の積
                                           mulB := Qbar の行列の積

必要十分版が要求する仮定は、具体版では次から出る。

  hmap_mul := qbarMatrixEval_product（評価が行列の積を保つこと）
  hcomm    := shiftMatrix_transferMatrix_comm（Z[x] の側の UT = TU）

すなわち、この段が要求するのは積を保つこと 1 本と、もとの側の可換性 1 本だけであり、
行列であることも、値が代数的数であることも、添字の型が有限であることも、
積の結合則も単位元も分配則も使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarShiftTransferComm
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MapComm

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarShiftTransfer_comm_from_necSuf (L : ℕ) [NeZero L] (ξ : Qbar) :
    qbarRowMatrixProduct L (qbarMatrixEval L ξ (shiftMatrix L))
        (qbarMatrixEval L ξ (transferMatrix L))
      = qbarRowMatrixProduct L (qbarMatrixEval L ξ (transferMatrix L))
          (qbarMatrixEval L ξ (shiftMatrix L)) :=
  NecSuf.AlgebraicEigenvalue.map_comm_necSuf
    (A := RowMatrix L) (B := QbarRowMatrix L)
    (qbarMatrixEval L ξ) (rowMatrixProduct L) (qbarRowMatrixProduct L)
    (fun A B => qbarMatrixEval_product L ξ A B)
    (shiftMatrix L) (transferMatrix L)
    (shiftMatrix_transferMatrix_comm L)

end Ising2DLambda.AlgebraicEigenvalue
