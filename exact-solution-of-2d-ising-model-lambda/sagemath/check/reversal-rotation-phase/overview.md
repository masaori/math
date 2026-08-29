# 逆歩道の回転位相

**対象ラベル**: `claim_reversal_rotation_phase_product`
- 実行: `sage sagemath/check/reversal-rotation-phase/check.sage`
- 状態: PASS（2026-08-30）

`L = 1,...,5` の全ての非後退接続について、逆順にして両辺を反転した接続も非後退であり、
二つの回転位相の積が `QQbar` で厳密に `1` になることを検査する。浮動小数点は使わない。
