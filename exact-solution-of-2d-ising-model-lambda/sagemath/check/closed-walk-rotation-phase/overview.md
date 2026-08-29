# 閉歩道の循環総回転数

**対象ラベル**: `claim_closed_walk_rotation_phase`
- 実行: `sage sagemath/check/closed-walk-rotation-phase/check.sage`
- 状態: PASS（2026-08-30、閉じた非後退辺列 1,064 件）

`L = 1,2,3`、辺 1〜5 本の全ての閉じた非後退辺列について、開いた部分の回転位相積へ
終辺から始辺への回転位相を掛けた値が、`ζ₈` の循環総回転数冪に等しいことを
`QQbar` と `ZZ` で厳密に検査する。浮動小数点は使わない。
