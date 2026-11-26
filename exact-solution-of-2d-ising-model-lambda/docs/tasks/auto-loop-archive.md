## 現在地から移したもの
- **2026-11-25（並列・八十三回目）、並列の表の先頭の行「Kac--Ward の具体版の導出を導出のファイルへ移し、import を分ける」のうち 15 行を直した（行は未了）。** 名前順で `OneSidedClosureNonbacktracking` から `RightRayVerticalCrossingCount` までの 13 ファイルと、`ReversalRotationPhase` の導出の定義 `Turn.toNecSuf` を使う `TotalTurning`（計 14 ファイル：`OneSidedClosureNonbacktracking`・`OneSidedClosurePeriodDifferenceTurning`・`PeriodicPlaneLiftPeriodTurning`・`PlaneCellBoundaryInjective`・`PrimitiveIntegerPair`・`ReconnectionTurningDifference`・`ReferenceLongMatching`・`ReferenceLongMate`・`RepresentativeIncrement`・`ReversalDirectionShift`・`ReversalMatrixDeterminant`・`ReversalRotationPhase`・`RightRayVerticalCrossingCount`・`TotalTurning`）の導出の補題を同名の `*FromNecSuf.lean` へ移して具体版から `NecSuf` の import を外した（導出のファイルが既にあった三つは import を外すだけ）。`ClosedWalkRotationPhaseFromNecSuf` は `TotalTurningFromNecSuf` を、`OddRayInteriorCellsFromNecSuf` は `RightRayVerticalCrossingCountFromNecSuf` を import する。import が外れて使えなくなった具体版の `open Ising2DLambda.NecSuf.KacWard`（使われていなかった）を 11 ファイルから、`simp` の `NecSuf.KacWard.reverseBool`（同じく不要）を 2 ファイルから消し、`RepresentativeIncrement`・`RightRayVerticalCrossingCount` に `Mathlib`、`PrimitiveIntegerPair` に `Mathlib.Data.Int.GCD` を直接足した。分離の台帳は 105→90 行。

## レビュー記録から移したもの
- 2026-11-25（並列・八十三回目）: 前回の 12 ファイルの導出の移動を含む main の上で `lake build` が通ることを、今回の直しの検証と合わせて確かめた。修正は無かった。

## 前進の記録から移したもの
- 2026-11-25（並列・八十三回目）: 【分離】の導出を移す行の 15 行を直した（残り 22 行）。具体版の import を外すと、その具体版を通して `NecSuf` を間接に受け取っていた下流の具体版の `open Ising2DLambda.NecSuf.KacWard` が「未知の名前空間」で落ちる。具体版が必要十分版の定数を使う行は台帳に無いので、その `open` は消してよい。導出の定義（`Turn.toNecSuf`）を別の具体版の導出が使うときは、両方を同じ回に移す。

