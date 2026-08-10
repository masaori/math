/-
章「固有値の代数性」の「転送行列はシフト行列の各固有空間をそれ自身へ写す」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_transfer_preserves_shift_eigenspace`）に対応する。

  人手証明                                            このファイル
  1 段だけの適用（可換な行列は固有空間を保つ）        qbarCommuting_preserves_eigenspace
  その仮定 AB = BA（評価で運んだ 2 つが可換）          qbarShiftTransfer_comm

この段は組み立てだけである。新しい論法は無く、既に示した 2 つの主張を
この章が扱う 2 つの行列（Ev_ξ(U) と Ev_ξ(T)）へ当てている。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarCommutingEigenspace
import Ising2DLambda.AlgebraicEigenvalue.QbarShiftTransferComm

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 人手証明の本体。転送行列を運んだ行列の作用は、シフト行列を運んだ行列の固有空間を保つ
（`claim_qbar_transfer_preserves_shift_eigenspace`）。 -/
theorem qbarTransfer_preserves_shift_eigenspace (L : ℕ) [NeZero L] (ξ : Qbar) (z : Qbar)
    (v : QbarRowVector L)
    (hv : v ∈ qbarEigenspace L (qbarMatrixEval L ξ (shiftMatrix L)) z) :
    qbarAction L (qbarMatrixEval L ξ (transferMatrix L)) v
      ∈ qbarEigenspace L (qbarMatrixEval L ξ (shiftMatrix L)) z :=
  -- 可換な行列は固有空間を保つことを A = Ev_ξ(U)、B = Ev_ξ(T) に当てる。
  -- その仮定 AB = BA は、評価で運んだ 2 つの行列の可換性そのものである。
  qbarCommuting_preserves_eigenspace L
    (qbarMatrixEval L ξ (shiftMatrix L)) (qbarMatrixEval L ξ (transferMatrix L)) z v
    (qbarShiftTransfer_comm L ξ) hv

end Ising2DLambda.AlgebraicEigenvalue
