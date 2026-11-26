## 現在地から移したもの
- **2026-11-25（並列・八十三回目）、並列の表の先頭の行「Kac--Ward の具体版の導出を導出のファイルへ移し、import を分ける」のうち 15 行を直した（行は未了）。** 名前順で `OneSidedClosureNonbacktracking` から `RightRayVerticalCrossingCount` までの 13 ファイルと、`ReversalRotationPhase` の導出の定義 `Turn.toNecSuf` を使う `TotalTurning`（計 14 ファイル：`OneSidedClosureNonbacktracking`・`OneSidedClosurePeriodDifferenceTurning`・`PeriodicPlaneLiftPeriodTurning`・`PlaneCellBoundaryInjective`・`PrimitiveIntegerPair`・`ReconnectionTurningDifference`・`ReferenceLongMatching`・`ReferenceLongMate`・`RepresentativeIncrement`・`ReversalDirectionShift`・`ReversalMatrixDeterminant`・`ReversalRotationPhase`・`RightRayVerticalCrossingCount`・`TotalTurning`）の導出の補題を同名の `*FromNecSuf.lean` へ移して具体版から `NecSuf` の import を外した（導出のファイルが既にあった三つは import を外すだけ）。`ClosedWalkRotationPhaseFromNecSuf` は `TotalTurningFromNecSuf` を、`OddRayInteriorCellsFromNecSuf` は `RightRayVerticalCrossingCountFromNecSuf` を import する。import が外れて使えなくなった具体版の `open Ising2DLambda.NecSuf.KacWard`（使われていなかった）を 11 ファイルから、`simp` の `NecSuf.KacWard.reverseBool`（同じく不要）を 2 ファイルから消し、`RepresentativeIncrement`・`RightRayVerticalCrossingCount` に `Mathlib`、`PrimitiveIntegerPair` に `Mathlib.Data.Int.GCD` を直接足した。分離の台帳は 105→90 行。

## レビュー記録から移したもの
- 2026-11-25（並列・八十三回目）: 前回の 12 ファイルの導出の移動を含む main の上で `lake build` が通ることを、今回の直しの検証と合わせて確かめた。修正は無かった。

## 前進の記録から移したもの
- 2026-11-25（並列・八十三回目）: 【分離】の導出を移す行の 15 行を直した（残り 22 行）。具体版の import を外すと、その具体版を通して `NecSuf` を間接に受け取っていた下流の具体版の `open Ising2DLambda.NecSuf.KacWard` が「未知の名前空間」で落ちる。具体版が必要十分版の定数を使う行は台帳に無いので、その `open` は消してよい。導出の定義（`Turn.toNecSuf`）を別の具体版の導出が使うときは、両方を同じ回に移す。


## 現在地から移したもの
- **2026-11-25（並列・八十四回目）、並列の表の先頭の行「Kac--Ward の具体版の導出を導出のファイルへ移し、import を分ける」の残り 22 行を直し、行を済ませた（表から消した）。** 名前順で `ShortPairCoefficientNonzero` から `WalkSideInteriorBandConnected` までの 20 ファイルの導出の補題を同名の `*FromNecSuf.lean` へ移して具体版から `NecSuf` の import を外し（導出のファイルが既にあった `TransverseTranslatedPeriodicPlaneLift`・`WalkSideInteriorBandConnected` はそこへ足した）、`StepTurning`・`VertexSimpleBoundaryNonloopPropagation` は import を外すだけにした。import が外れて落ちた下流の具体版 `WalkSideExteriorBandConnected` の導出の補題も既存の導出のファイルへ移し、`ExteriorCellSetEdgeConnectedFromNecSuf` に `NecSuf.KacWard.WalkSideInteriorBandConnected` の import を足した。導出が使う具体版の二つの補助定理（`TaggedMatchingNonzeroSupport` の長い寄与・短い寄与の非零性）の `private` を外し、`SmoothingClosedWalkSplit` に `Mathlib.Data.Nat.Basic` を直接足した。分離の台帳は 90→68 行（具体版のモジュールが必要十分版を import する組 37→15）。

## レビュー記録から移したもの
- 2026-11-25（並列・八十四回目）: 前回の 14 ファイルの導出の移動を含む main の上で `lake build` が通ることを、今回の直しの検証と合わせて確かめた。修正は無かった。

## 前進の記録から移したもの
- 2026-11-25（並列・八十四回目）: 【分離】の導出を移す行の残り 22 行を直し、行を済ませた。台帳に載っていない下流の具体版も、import を外した具体版から `NecSuf` を間接に受け取って導出の補題を置いていることがある（今回は `WalkSideExteriorBandConnected`）。`lake build` で落ちたものを同じ回に移す。並列の表の次は Kac--Ward と離散 Whitney 系の【一対一】である。
