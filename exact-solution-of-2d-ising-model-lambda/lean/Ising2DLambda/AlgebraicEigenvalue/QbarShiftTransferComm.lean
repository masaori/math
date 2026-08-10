/-
章「固有値の代数性」の「評価で運んだシフト行列と転送行列は可換である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_shift_transfer_commute`）に対応する。

  人手証明                                       このファイル
  鎖の第 1 段（評価が積を保つのを右辺から左辺へ） qbarMatrixEval_product の .symm
  鎖の第 2 段（UT = TU）                          shiftMatrix_transferMatrix_comm の書き換え
  鎖の第 3 段（評価が積を保つこと）               qbarMatrixEval_product

可換性そのものを Qbar の側で示し直してはいない。Z[x] の側の等式を写像で運ぶだけである。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEval
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrix

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の本体。`Ev_ξ(U) Ev_ξ(T) = Ev_ξ(T) Ev_ξ(U)`
（`claim_qbar_shift_transfer_commute`）。 -/
theorem qbarShiftTransfer_comm (ξ : Qbar) :
    qbarRowMatrixProduct L (qbarMatrixEval L ξ (shiftMatrix L))
        (qbarMatrixEval L ξ (transferMatrix L))
      = qbarRowMatrixProduct L (qbarMatrixEval L ξ (transferMatrix L))
          (qbarMatrixEval L ξ (shiftMatrix L)) :=
  calc qbarRowMatrixProduct L (qbarMatrixEval L ξ (shiftMatrix L))
          (qbarMatrixEval L ξ (transferMatrix L))
      = qbarMatrixEval L ξ (rowMatrixProduct L (shiftMatrix L) (transferMatrix L)) :=
        -- 第 1 段。評価が積を保つこと（右辺から左辺へ）。
        (qbarMatrixEval_product L ξ (shiftMatrix L) (transferMatrix L)).symm
    _ = qbarMatrixEval L ξ (rowMatrixProduct L (transferMatrix L) (shiftMatrix L)) := by
        -- 第 2 段。Z[x] の側の可換性 UT = TU。
        rw [shiftMatrix_transferMatrix_comm]
    _ = qbarRowMatrixProduct L (qbarMatrixEval L ξ (transferMatrix L))
          (qbarMatrixEval L ξ (shiftMatrix L)) :=
        -- 第 3 段。評価が積を保つこと。
        qbarMatrixEval_product L ξ (transferMatrix L) (shiftMatrix L)

end Ising2DLambda.AlgebraicEigenvalue
