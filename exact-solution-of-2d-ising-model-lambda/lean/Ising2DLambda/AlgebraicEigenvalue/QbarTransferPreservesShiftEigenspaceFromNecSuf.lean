/-
具体版が必要十分版の特殊化として得られることの導出。

**この段には新しい必要十分版を書いていない。** 人手証明のこの段は組み立てだけであり、
新しく必要十分性を問うべき論法が無いためである。要るのは既にある 2 つで、

  commuting_preserves_eigenspace_necSuf  可換な 2 元の一方の固有空間が他方の作用で閉じること
  map_comm_necSuf                        積を保つ写像は可換な 2 元を可換な 2 元へ写すこと

前者を M := QbarRowMatrix L、V := QbarRowVector L、S := Qbar、
act := 作用、mul := 行列の積、smul := ⊙ と取り、その仮定 `hcomm` を後者を
A := RowMatrix L、B := QbarRowMatrix L、f := Ev_ξ と取って得た等式で埋める。
一行で終わる別名を新しい必要十分版として立てないという規約に従った
（`docs/context/証明の書き方.md` の「一行で終わる宣言や単なる別名定義は認めない」）。

すなわちこの段が要求するのは、作用の積 1 本・作用がスカラー倍を保つこと 1 本・
写像が積を保つこと 1 本・もとの側の 2 元についての可換性 1 本の合計 4 本だけであり、
行列であることも、値が代数的数であることも、添字の型が有限であることも、
積の結合則も単位元も分配則も使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarTransferPreservesShiftEigenspace
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.CommutingEigenspace
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MapComm

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版は、既にある 2 つの必要十分版の特殊化を合わせたものである。 -/
theorem qbarTransfer_preserves_shift_eigenspace_from_necSuf
    (L : ℕ) [NeZero L] (ξ : Qbar) (z : Qbar) (v : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L (qbarMatrixEval L ξ (shiftMatrix L)) z) :
    qbarAction L (qbarMatrixEval L ξ (transferMatrix L)) v
      ∈ qbarEigenspace L (qbarMatrixEval L ξ (shiftMatrix L)) z :=
  NecSuf.AlgebraicEigenvalue.commuting_preserves_eigenspace_necSuf
    (M := QbarRowMatrix L) (V := QbarRowVector L) (S := Qbar)
    (qbarAction L) (qbarRowMatrixProduct L) (qbarVectorSmul L)
    (fun A B w => qbarAction_product L A B w)
    (fun B c w => qbarAction_smul L B c w)
    (qbarMatrixEval L ξ (shiftMatrix L)) (qbarMatrixEval L ξ (transferMatrix L))
    -- 仮定 AB = BA は、積を保つ写像についての必要十分版の特殊化で埋める。
    (NecSuf.AlgebraicEigenvalue.map_comm_necSuf
      (A := RowMatrix L) (B := QbarRowMatrix L)
      (qbarMatrixEval L ξ) (rowMatrixProduct L) (qbarRowMatrixProduct L)
      (fun A B => qbarMatrixEval_product L ξ A B)
      (shiftMatrix L) (transferMatrix L)
      (shiftMatrix_transferMatrix_comm L))
    z v hv

end Ising2DLambda.AlgebraicEigenvalue
