# 閉歩道の回転数と回転位相の符号

**対象ラベル**: `claim_closed_walk_rotation_phase_sign`
- 実行: `sage sagemath/check/closed-walk-rotation-number-sign/check.sage`
- 状態: PASS（2026-08-30、閉じた非後退辺列 1,064 件）

`L=1,2,3`・辺 1〜5 本の全閉じた非後退辺列について、循環総回転数が `4` で割り切れ、
その商を回転数とした等式 `t_circ = 4 rot` と、回転位相積 `= ζ₈^t_circ = (-1)^rot` を
`ZZ` と `QQbar` で厳密に検査する。浮動小数点は使わない。
